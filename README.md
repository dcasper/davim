# davim

David's Vim Config

- install Droid Sans Mono font from `./fonts`, set terminal default font to use it
- run `./setup.sh` to get started (it asks before replacing a file or directory that
  already exists in `~`; replaced entries are moved aside to `<name>.bak.<timestamp>`.
  Use `./setup.sh --force` to replace without asking)
- run `sudo chsh -s $(which zsh) $(whoami)` to set ZSH as default shell
- initialize ViM plugins with `:PlugInstall` in a running vim instance


Outdated:
- run `git submodule update --recursive` to download all git submodules (2/26/22: out of date, use vim plugins instead)
