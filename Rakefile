require 'fiedl/log'
require 'active_support/core_ext/object/blank'

task :default => :help

def linux?
  RUBY_PLATFORM.include?("linux")
end

def repo_path
  __dir__
end

task :help do
  log.head "dotfiles"
  log.info "Repo: https://github.com/fiedl/dotfiles\n"

  log.info 'Run `rake install` to install everything.'

  log.section "Usage"
  log.info '* Run `rake install` to install or link everything available within this repository, but do not overwrite anything.'
  log.info "* Run `rake install foo bar` to install only `foo` and `bar` out of this list of options:"
  log.info "  - oh-my-zsh   https://github.com/ohmyzsh/ohmyzsh"
  log.info "  - dot-zsh     https://github.com/fiedl/dot-zsh"
  log.info "  - zshrc"
end

task :install do
  if ARGV == ["install"] # without any other arguments
    sh "rake install dot-zsh zshrc"
  end
end

task :'oh-my-zsh' => :zsh do
  unless File.exists? File.expand_path "~/.oh-my-zsh"
    sh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    sh "mv ~/.zshrc ~/.zshrc.oh-my-zsh"
    sh "mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc" if File.exists? File.expand_path "~/.zshrc.pre-oh-my-zsh"
  end
end

task :zsh do
  sh "sudo apt install zsh" if linux? and `which zsh`.strip.blank?
end

task :zshrc => :zsh do
  sh "ln -s '#{repo_path}/zshrc' ~/.zshrc" unless File.exists? File.expand_path "~/.zshrc"
  sh "ls -la ~/ |grep zshrc"
end

task :'dot-zsh' => :'oh-my-zsh' do
  sh "ln -s '#{repo_path}/dot-zsh' ~/.zsh" unless File.exists? File.expand_path "~/.zsh"
  sh "ls ~/.zsh"
end
