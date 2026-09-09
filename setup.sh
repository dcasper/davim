#!/bin/bash
#
# Symlink the dotfiles in this repo into $HOME.
#
# Existing entries are never overwritten blindly: `ln` happily resolves a
# directory target and creates the link *inside* it (~/<name>/<name>), so every
# pre-existing file, directory, or symlink is reported and handled explicitly.

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Entries are repo-relative paths, optionally "<source>:<dest>" when the link in
# $HOME should not reuse the source file's name.
files=(".vim" ".vimrc" ".screenrc" ".zshenv" ".zshrc" ".tmux.conf" "karabiner.edn" ".zshenv:.config/mise/config.d/zsh-zshrc.zsh")

force=0
for arg in "$@"; do
  case "$arg" in
    -f|--force) force=1 ;;
    -h|--help)
      echo "usage: $(basename "$0") [-f|--force]"
      echo "  -f, --force  replace existing entries without asking"
      echo "               (they are moved aside to <name>.bak.<timestamp>, not deleted)"
      exit 0
      ;;
    *)
      echo "unknown option: $arg (see --help)" >&2
      exit 1
      ;;
  esac
done

# Move an existing entry out of the way instead of deleting it.
back_up() {
  local path="$1"
  local backup="$1.bak.$(date +%Y%m%d-%H%M%S)"
  while [ -e "$backup" ] || [ -L "$backup" ]; do
    backup="$backup~"
  done
  mv "$path" "$backup" || return 1
  echo "$backup"
}

replace_target() {
  local dest="$1" src="$2" kind="$3" answer backup

  if [ "$force" -eq 1 ]; then
    answer="r"
  elif [ ! -t 0 ]; then
    echo "skip     $kind already exists at $dest (pass --force to replace)"
    return 1
  else
    printf '%s already exists at %s\n' "$kind" "$dest"
    printf 'Replace it with a symlink to %s? [r]eplace or [s]kip: ' "$src"
    read -r answer || answer="s"
  fi

  case "$answer" in
    r|R*)
      backup="$(back_up "$dest")" || {
        echo "failed   $dest could not be moved aside" >&2
        return 1
      }
      echo "backup   $dest -> $backup"
      return 0
      ;;
    *)
      echo "skip     $kind left in place at $dest"
      return 1
      ;;
  esac
}

link_file() {
  local entry="$1"
  local src_rel="${entry%%:*}"
  local dest_rel="$entry"
  case "$entry" in *:*) dest_rel="${entry#*:}" ;; esac

  local src="$REPO_DIR/$src_rel"
  local dest="$HOME/$dest_rel"

  if [ ! -e "$src" ]; then
    echo "$src_rel DOES NOT EXIST"
    return
  fi

  if [ -L "$dest" ] && [ ! -e "$dest" ]; then
    # Stale link from an earlier run: nothing of value to preserve.
    rm -f "$dest"
    echo "remove   stale symlink at $dest"
  elif [ -e "$dest" ] && [ "$dest" -ef "$src" ]; then
    # Same inode as the repo copy, whether linked by absolute or relative path.
    echo "ok       $src_rel -> $dest_rel"
    return
  elif [ -e "$dest" ] || [ -L "$dest" ]; then
    local kind="file"
    [ -d "$dest" ] && kind="directory"
    [ -L "$dest" ] && kind="symlink"
    replace_target "$dest" "$src" "$kind" || return
  fi

  # Needed for nested targets such as .config/mise/config.d/*.zsh.
  mkdir -p "$(dirname "$dest")" || {
    echo "failed   could not create $(dirname "$dest")" >&2
    return 1
  }

  if ln -s "$src" "$dest"; then
    echo "link     $src_rel -> $dest_rel"
  else
    echo "failed   could not link $src_rel" >&2
  fi
}

for file in "${files[@]}"; do
  link_file "$file"
done

echo "Don't forget to run ':PlugInstall' in vim to get plugins"
