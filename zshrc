# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tjkirch"   # "robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git brew bundler macports osx )
plugins=(git bundler)

# rbenv (must go before oh-my-zsh!)
eval "$(rbenv init -)"

if [ ! -d $ZSH ]
then
  curl -L http://install.ohmyz.sh | sh
fi

source $ZSH/oh-my-zsh.sh

# iterm customizations
source bin/iterm2.zsh
[ -f .iterm2_shell_integration.zsh ] && source .iterm2_shell_integration.zsh

# editor
export EDITOR=emacs

# PS1
#PS1="%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m(fiedl-mbp)%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
#%_$(prompt_char) "

# # Set the hostname on Mac OS
# sudo scutil --set HostName fiedl-mbp

# general aliases
cdl() { cd "$@"; ls; }
gre() { grep --recursive --regexp="$@" --exclude-dir=log --exclude-dir=coverage --exclude-dir=neo4j --exclude-dir=tmp --exclude-dir=.git . ; }
# alias emacs='emacs -nw'
alias e='mate'
alias f='ffind'
unalias g
function g () { grep --exclude-dir log --exclude-dir tmp --exclude-dir .yardoc --exclude-dir doc --recursive --line-number "$*" . }  # --ignore-case
alias ka='pkill -f'

# directory aliases
if [ -d /Users/fiedl ]
then
  alias cdw='cd /Users/fiedl/rails/wingolfsplattform'
  alias cdy='cd /Users/fiedl/rails/wingolfsplattform/vendor/engines/your_platform'
  alias cdo='cd /Users/fiedl/rails/your_platform_ops'
  alias cda='cd /Users/fiedl/rails/wingolfsplattform/vendor/engines/your_platform/app/assets/javascripts/'
  alias cdm='cd /Users/fiedl/rails/my_platform'
fi

# rails shortcuts
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias gis='git status'
alias pry='be pry -r ./config/environment'
alias production='git co production && git merge master && git co master'

# documentation shortcut: generates documentation and opens it in the browser
alias doc='cdw && yardoc && chromium-browser doc/index.html && cdy && yardoc && chromium-browser doc/index.html'

# icecube
if [ -d /Users/fiedl/icecube ]
then
  alias ice-port="$I3_PORTS/bin/port"
  # alias ice-cmake="$I3_PORTS/bin/cmake"
  alias shovel="$SIM/../build/bin/steamshovel"
  alias clsim-make="cd $SIM/clsim && make -j 4 && cd -"
  alias cdc="cd /Users/fiedl/icecube/clsim"
  
  alias icesim="$SIM/env-shell.sh"
  alias icesimfix="source ~/icecube/geant4fix.sh"
  alias icedoc="open $SIM/../documentation/html/index.html && cd $SIM/../src && doxygen sim.doxygen"
  alias nb='ipython notebook --pylab=inline'
  
  alias ci="./zsh_to_markdown *.sh && git add . && git commit -m"
  
  # python
  # export PYTHONPATH=/usr/local/lib/python3.3:$PYTHONPATH
  # alias ipy='cd ~/diplomarbeit/Notebooks && ipython3 notebook --pylab=inline'
  
  # iruby
  alias iruby-notebook=' iruby notebook --pylab=inline'
fi

# Musik
if [ -f /Applications/VLC.app/Contents/MacOS/VLC ]
then
  alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
  alias klassikradio='vlc http://edge.live.mp3.mdn.newmedia.nacamar.net/klassikradio128/livestream.mp3 > /dev/null 2>&1 &'
  #alias classicfm='open http://www.classicfm.com/radio/player/'
  alias classicfm='open -a iTunes -g http://media-ice.musicradio.com/ClassicFMMP3.m3u'
fi

# uni ssh tunnel
alias uni-ssh='ssh sfiedlschuster@pi2158.physik.uni-erlangen.de -L 8080:proxy.rrze.uni-erlangen.de:80'


# stuff from moo
# https://github.com/idk/zsh/blob/master/.zshrc
# 
alias matrix='cmatrix -C magenta'
alias random='echo $[RANDOM % 30 + 1] && read \?"I am waiting for you to press [Enter] before I continue." && echo $[RANDOM % 2 + 1] && echo "Have fun!"'                                                         

# identify the computer on login
figlet $(hostname)

# added by travis gem
[ -f /Users/fiedl/.travis/travis.sh ] && source /Users/fiedl/.travis/travis.sh

# zip verschlüsseln
[ -d /Users/fiedl ] && alias zip-verschlüsseln='echo "zip -er archive.zip folder-to-zip"' 
