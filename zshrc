# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$HOME/.zsh/oh-my-zsh-customization"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fiedl"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Auto-install ~/.oh-my-zsh if missing.
if [ ! -d $ZSH ]; then
  curl -L http://install.ohmyz.sh | sh
fi

# Auto-install ~/.zsh if missing.
if [ ! -d ~/.zsh ]; then
  git clone git@github.com:fiedl/dot-zsh.git ~/.zsh
fi

# Auto-updating ~/.oh-my-zsh as well as ~/.zsh
# requires to use another upgrade script.
# Therefore, deactivate the oh-my-zsh-only one.
# The rest is done by the `auto-update` plugin.
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=1

# Which plugins would you like to load?
# Plugins can be found in:
# ~/.oh-my-zsh/plugins/*
# ~/.zsh/oh-my-zsh-customization/plugins/*
# ZSH_PLUGINS is defined in ~/.zshenv
plugins=(git zsh-autosuggestions zsh-syntax-highlighting bundler editor auto-update highlight fiedl icecube gnuplot install plattform latex powerlevel lcars)

# rbenv (must go before oh-my-zsh!)
export PATH=$RBENV_ROOT/bin:/opt/rbenv/bin:/opt/rbenv/shims:$PATH
eval "$(rbenv init -)"


include () {
    [[ -f "$1" ]] && source "$1"
}

include $ZSH/oh-my-zsh.sh

# iterm customizations
include bin/iterm2.zsh
[ -f .iterm2_shell_integration.zsh ] && source .iterm2_shell_integration.zsh

# editor
export EDITOR=emacs


# # Set the hostname on Mac OS
# sudo scutil --set HostName fiedl-mbp


# cdl() { cd "$@"; ls; }
# alias emacs='emacs -nw'


# Musik
if [ -f /Applications/VLC.app/Contents/MacOS/VLC ]
then
  alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
  alias klassikradio='vlc http://edge.live.mp3.mdn.newmedia.nacamar.net/klassikradio128/livestream.mp3 > /dev/null 2>&1 &'
  #alias classicfm='open http://www.classicfm.com/radio/player/'
  alias classicfm='open -a iTunes -g http://media-ice.musicradio.com/ClassicFMMP3.m3u'
fi

# ssh tunnel
alias uni-ssh='ssh sfiedlschuster@pi2158.physik.uni-erlangen.de -L 8080:proxy.rrze.uni-erlangen.de:80'
alias uniproxy='ssh snaasoer@dialog.rrze.uni-erlangen.de -L 8080:proxy.rrze.uni-erlangen.de:80'
alias haus-ip='curl "http://fiedlschuster.de/ip/?key=wingolf"'
alias haus-ssh='ssh `haus-ip` -p 50223'

# stuff from moo
# https://github.com/idk/zsh/blob/master/.zshrc
#
alias random='echo $[RANDOM % 30 + 1] && read \?"I am waiting for you to press [Enter] before I continue." && echo $[RANDOM % 2 + 1] && echo "Have fun!"'
alias r1="echo $[RANDOM % 30 + 1] && echo $[RANDOM % 2 + 1]"
alias r3='echo $[RANDOM % 30 + 1] && echo $[RANDOM % 2 + 1] && echo $[RANDOM % 30 + 1] && echo $[RANDOM % 2 + 1] && echo $[RANDOM % 30 + 1] && echo $[RANDOM % 2 + 1]'

alias würfeln='echo $[RANDOM % 20 + 1] $[RANDOM % 20 + 1] $[RANDOM % 20 + 1]'

# added by travis gem
[ -f /Users/fiedl/.travis/travis.sh ] && source /Users/fiedl/.travis/travis.sh

# zip verschlüsseln
[ -d /Users/fiedl ] && alias zip-verschlüsseln='echo "zip -er archive.zip folder-to-zip"'

alias festplattenbelegung='baobab'
alias grandperspective='festplattenbelegung'

# Some tab color settings.
include bin/iterm2_helper.sh

alias reload='source ~/.zshrc'
alias hosts='nmap -sP -T5 192.168.0.0/24 |grep report |awk '\''{print $5, $6}'\'''

monitor() {
  include "bin/anybar.zsh"
}

## Start Anybar Server Monitor
##
#if [ ANYBAR_STARTED != true ]; then
#  include "bin/anybar.zsh"
#  ANYBAR_STARTED=true
#fi

which colorls > /dev/null && alias ls='colorls'
alias ll='ls -l'
alias la='ls -l -a'

alias yt='youtube-dl'
alias yt-mp3='yt --extract-audio --audio-format m4a'
yt-play() {
  youtube-dl --get-title "ytsearch1:$*"
  echo "TODO: Versuche mpsyt, https://github.com/mps-youtube/mps-youtube"
  curl $(yt-mp3 --get-url "ytsearch1:$*") | mplayer - > /dev/null
}



# https://superuser.com/a/208294/273249
alias mate-new-window="open -na TextMate"
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
# https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# overwrite yabai path for debug version
export PATH="$HOME/code/yabai/bin:$PATH"

