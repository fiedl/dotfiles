# https://gist.github.com/wadey/1140259

# Usage:
# source iterm2.zsh
 
# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}
 
# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "production|ec2-.*compute-1" ]]; then
            tab-color 255 0 0
        else
            tab-color 0 255 0
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh
 
alias ssh=color-ssh

# Change the color when using bundler
color-bundle() {
  if [[ -n "$ITERM_SESSION_ID" ]]; then
      trap "tab-reset" INT EXIT
      if [[ "$*" =~ "rails s|guard" ]]; then
          tab-color 255 0 0
      else
          tab-color 0 0 255
      fi
  fi
  bundle $*
}
compdef _bundle color-bundle=bundle

alias bundle=color-bundle