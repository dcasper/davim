# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
export SHELL="/bin/zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH="$PATH:/usr/local/share/npm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

plugins=(git rails ruby brew ant rake history-substring-search)

bindkey -v
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' up-line-or-search
bindkey '^[OB' down-line-or-search


alias be="bundle exec"

alias rake="noglob rake"
alias bundle="noglob bundle"
alias rctl="rabbitmqctl"

# Git Aliases
alias gits="git status"
alias gitd="git diff"
alias gitdn="git diff --name-only"
alias gitc="git commit"
alias gitl="git log"

alias k="cd .."
alias kk="cd ../.."
alias kkk="cd ../../.."
alias kkkk="cd ../../../.."

new_screen="/usr/local/Cellar/screen/HEAD/bin/screen"
# Add vertical split enabled GNU screen for OSX
alias vscreen=$new_screen


# Add portal screen setup alias
alias pscr="$new_screen -S cloud -c ~/.portal-screenrc"
alias cscr="$new_screen -S connector -c ~/.connector-screenrc"

if type "aws" > /dev/null; then

  function alk {
    s=$(aws --region us-east-1 opsworks describe-stacks | jq -r ".Stacks[] | select(.Name==\"$1\") | .StackId")
    if [ -z ${2+x} ]; then
      c=".Instances[] | .Hostname + \"\t\" + .PrivateIp"
    else
      c=".Instances[] | select(.Hostname==\"$2\") | .PrivateIp"
    fi
    aws --region us-east-1 opsworks describe-instances --stack-id $s | jq -r "$c"
  }

  function dterm {
    ips=$(alk docker-cloud | grep node | awk '{print $NF}')
    res=$(pssh -H $ips "sudo su -c \"docker ps | grep $1\"")
    docker_ip=$(echo $res | grep SUCCESS | awk '{print $NF}')
    ssh -t $docker_ip "sudo su -c \"d_name=\\\$(docker ps | grep $1 | awk '{print \\\$NF}'); echo \\\$d_name; docker exec -it \\\$d_name bash\""
  }

  PROD_MAINT_HOST=`alk api-production maint1`

  function maintconsole {
    ssh -tt -i ~/.ssh/id_rsa.pub $PROD_MAINT_HOST 'sudo -u deploy sh -c "cd /srv/www/app/current ; RAILS_ENV=production bundle exec rails console"'
  }

fi

rgrep() { grep -r --exclude-dir="**/fixtures" --exclude-dir="tmp" --exclude-dir="log" --exclude-dir="node_modules" "$*" . }
