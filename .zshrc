export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

autoload -Uz compinit
compinit
 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

setopt print_eight_bit
 
setopt no_beep
 
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

alias ls='ls -F --color=auto' 
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# if [ -z "$PS1" ]; then return ; fi
# 
# if [ -z $TMUX ] ; then
#   if [ -z `tmux ls` ] ; then
#     tmux
#   else
#     tmux attach
#   fi
# fi

export PATH="$HOME/.rbenv/bin:$PATH"
if type "rbenv" > /dev/null; then
  eval "$(rbenv init -)"
fi

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.linuxbrew/bin:$PATH"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
export PATH=${PATH}:${HOME}/Android/Sdk/tools:${HOME}/Android/Sdk/platform-tools
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias copy='tmux save-buffer - | pbcopy'
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
        ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    # echo "no ssh-agent"
    eval $(ssh-agent)
fi

# added by travis gem
[ -f /home/xyz/.travis/travis.sh ] && source /home/xyz/.travis/travis.sh

# export NVM_DIR="/home/xyz/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$PATH:./node_modules/.bin"

# attach already session
#if [[ ! -n $TMUX ]]; then
  # get the IDs
#  ID="`tmux list-sessions`"
#  if [[ -z "$ID" ]]; then
#    tmux new-session
#  fi
#  ID="`echo $ID | $PERCOL | cut -d: -f1`"
#  tmux attach-session -t "$ID"
#fi

function peco-history-selection() {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
source ~/.cargo/env

# peco find directory
function peco-find() {
  local current_buffer=$BUFFER
  local search_raoot=""
  local file_path=""

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    search_root=`git rev-parse --show-toplevel`
  else
    search_root=`pwd`
  fi
  file_path="$(find ${search_root} -maxdepth 5 | peco)"
  BUFFER="${current_buffer} ${file_path}"
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-find

# bind keys
bindkey '^f' peco-find

function git-root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

function start-activity() {
  adb shell am start -n $(xmllint --xpath '//activity/@*[local-name()="name"]' app/src/main/AndroidManifest.xml | sed -r "s/ /\n/g; s/android:name|[\"]//g; s/=/$(xmllint --xpath 'string(/manifest/@package)' app/src/main/AndroidManifest.xml)\//g" | peco)
}

alias ls=exa

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
export PATH="$PATH:`yarn global bin`"
bindkey '^[[1;2C' forward-word
bindkey '^[[1;2D' backward-word
alias cat=bat
alias start-ac=start-activity
bindkey '^A' start-activity
export PATH="$PATH:/opt/gradle/gradle-5.4.1/bin"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH=$PATH:$JAVA_HOME/bin
export PATH=/home/xyz/.cargo/bin:/home/xyz/.linuxbrew/bin:/home/xyz/.nodebrew/current/bin:/home/xyz/.rbenv/shims:/home/xyz/.rbenv/bin:/home/xyz/.rbenv/plugins/ruby-build/bin:/home/xyz/.cargo/bin:/home/xyz/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/xyz/Android/Sdk/tools:/home/xyz/Android/Sdk/platform-tools:./node_modules/.bin:/home/xyz/.yarn/bin:/opt/gradle/gradle-5.4.1/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:/opt/flutter/bin
zstyle ':completion:*:default' menu select=2
export PATH=$PATH:/snap/bin
export PATH=$PATH:~/.local/bin


# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/home/xyz/.netlify/helper/path.zsh.inc' ]; then source '/home/xyz/.netlify/helper/path.zsh.inc'; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/xyz/google-cloud-sdk/path.zsh.inc' ]; then . '/home/xyz/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/xyz/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/xyz/google-cloud-sdk/completion.zsh.inc'; fi
export PATH=$PATH:/usr/local/go/bin
eval "$(direnv hook zsh)"

