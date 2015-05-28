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
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

if [ -z "$PS1" ]; then return ; fi

if [ -z $TMUX ] ; then
        if [ -z `tmux ls` ] ; then
                tmux
        else
                tmux attach
        fi
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH=/home/hime/.nodebrew/current/bin:/home/hime/.rbenv/shims:/home/hime/.rbenv/bin:/home/hime/.rbenv/plugins/ruby-build/bin:/home/hime/.rbenv/shims:/home/hime/.rbenv/bin:/home/hime/.rbenv/shims:/home/hime/.rbenv/bin:/home/hime/.rbenv/plugins/ruby-build/bin:/home/hime/.rbenv/shims:/home/hime/.rbenv/bin:/home/hime/.rbenv/plugins/ruby-build/bin:/home/hime/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH="$HOME/.linuxbrew/bin:$PATH"
