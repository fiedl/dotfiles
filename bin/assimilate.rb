#!/usr/bin/env ruby
#
# This script assimilates the useer's account to adapt the dot files
# of this repository.
#
# Use this for virgin user accounts you wish to load the dot files on.
#
# Usage:
#
#   cd
#   git clone https://github.com/fiedl/dotfiles.git .dotfiles
#   .dotfiles/bin/assimilate.rb
#
# Requirements
#   * Ruby
#   * Ruby gems: colored
#   * Arch Linux or Mac OS
#   * Arch Packages: yaourt, pacaur
#   * Linux Packages: inxi
#

require_relative 'lib/log'
require_relative 'lib/shell'

def arch?
  RUBY_PLATFORM == "x86_64-linux" and File.exist? "/usr/bin/pacman"
end
def debian?
  RUBY_PLATFORM == "x86_64-linux" and File.exist? "/usr/bin/apt-get"
end
def ubuntu?
  @ubuntu ||= `inxi -S`.to_s.include?("Ubuntu")
end

def install_packages(*packages)
  if arch?
    shell "pacaur -S --needed --noconfirm --noedit #{packages.join(" ")}"
  end
end

def play_intro
  install_packages :figlet, :wget, :mplayer
  shell "figlet -c Assimilation in Progress ..."
  Process.fork do
    shell "wget www.moviesoundclips.net/movies1/startrek8/borg.mp3 -O - |mplayer -noconsolecontrols -cache 8192 - > /dev/null 2>&1 &"
  end
end

# This symlinks the given dotfile.
#
def install_file(file)
  backup_file file
  symlink_file file
end

def expand_home(file)
  File.join(ENV['HOME'], file)
end
def expand_repo(file)
  File.join(ENV['HOME'], '.dotfiles', file_without_dot(file))
end
def file_without_dot(file)
  file.start_with?(".") ? file[1..-1] : file
end
def expand_repo_relative(file)
  File.join('.dotfiles', file_without_dot(file))
end

def backup_file(file)
  if File.exist? expand_home(file)
    shell "mv #{expand_home(file)} #{expand_home(file) + ".bak"}"
  end
end

def symlink_file(file)
  shell "ln -s #{expand_repo_relative(file)} #{expand_home(file)}"
end

def install_zsh
  log.section "Install ZSH"
  install_packages 'oh-my-zsh-git'
  install_file '.zshrc'
  install_file '.zshenv'
end

def install_fun
  log.section "Install Fun"
  install_packages :cmatrix
end

def install_ruby
  log.section "Install Ruby"
  unless File.exist? "~/.rbenv"
    shell "git clone git://github.com/sstephenson/rbenv.git ~/.rbenv"
    shell "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
  end
  shell "rbenv install --skip-existing 2.2.0"
  shell "rbenv global 2.2.0"
  shell "rbenv rehash"
  shell "ruby --version"
end

def install_multimedia
  log.section "Install Multimedia"
  install_packages :moc
end

def install_tools
  log.section "Install Tools"
  install_packages :htop
end

play_intro
install_zsh
install_fun
#install_ruby
install_multimedia
install_tools
# TODO: install_keyboard_layout if mac?
