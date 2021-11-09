require 'fiedl/log'
require 'active_support/core_ext/object/blank'

task :default => :help

def linux?
  RUBY_PLATFORM.include?("linux")
end

task :help do
  log.head "dotfiles"
  log.info "Repo: https://github.com/fiedl/dotfiles\n"

  log.info 'Run `rake install` to install everything.'

  log.section "Usage"
  log.info '* Run `rake install` to install or link everything available within this repository, but do not overwrite anything.'
  log.info "* Run `rake install foo bar` to install only `foo` and `bar` out of this list of options:"
  log.info "  - oh-my-zsh"
end

task :install do
  if ARGV == ["install"] # without any other arguments
    sh "rake install oh-my-zsh"
  end
end

task :'oh-my-zsh' => :zsh do
  unless File.exists? File.expand_path "~/.oh-my-zsh"
    sh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  end
end

task :zsh do
  sh "sudo apt install zsh" if linux? and `which zsh`.strip.blank?
end
