require 'fiedl/log'

task :default => :help

task :help do
  log.head "dotfiles"
  log.info "Repo: https://github.com/fiedl/dotfiles\n"

  log.info 'Run `rake install` to install everything.'

  log.section "Usage"
  log.info '* Run `rake install` to install or link everything available within this repository, but do not overwrite anything.'
end

task :install do
  if ARGV == ["install"] # without any other arguments
    shell "rake install oh-my-zsh"
  end
end
