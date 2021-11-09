require 'fiedl/log'

task :default => :help

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
    shell "rake install oh-my-zsh"
  end
end

task :'oh-my-zsh' do
  shell 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
end
