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
plugins=(git brew bundler macports osx )

source $ZSH/oh-my-zsh.sh


# brew
export PATH=/usr/local/bin:$PATH

# java
export JAVA_HOME=`/usr/libexec/java_home`

# rbenv
PATH="$HOME/.rbenv/bin:$PATH"
PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# executable scripts
export PATH=$PATH:/home/fiedl/.exec

# editor
export EDITOR=emacs

# general aliases
cdl() { cd "$@"; ls; }
gre() { grep --recursive --regexp="$@" --exclude-dir=log --exclude-dir=coverage --exclude-dir=neo4j --exclude-dir=tmp --exclude-dir=.git . ; }
alias emacs='emacs -nw'
alias e='mate'

# directory aliases
alias cdw='cd /Users/fiedl/rails/wingolfsplattform'
alias cdy='cd /Users/fiedl/rails/wingolfsplattform/vendor/engines/your_platform'
alias cdo='cd /Users/fiedl/rails/wingolfsplattform_ops'
alias cda='cd /Users/fiedl/rails/wingolfsplattform/vendor/engines/your_platform/app/assets/javascripts/'

# rails shortcuts
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias gis='git status'
alias pry='be pry -r ./config/environment'

# documentation shortcut: generates documentation and opens it in the browser
alias doc='cdw && yardoc && chromium-browser doc/index.html && cdy && yardoc && chromium-browser doc/index.html'

# icecube
export I3_PORTS="/Users/fiedl/icecube/software/ports"
alias ice-port='/Users/fiedl/icecube/software/ports/bin/port'

