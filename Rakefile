require 'fiedl/log'
require 'active_support/core_ext/object/blank'

task :default => :help

def linux?
  RUBY_PLATFORM.include?("linux")
end

def mac?
  RUBY_PLATFORM.include?("darwin")
end


def brew_install(formula)
  sh "brew install #{formula}" if `brew info #{formula}`.include? "Not installed"
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
  log.info "  - homebrew"
  log.info "  - apps"
  log.info "  - keyboard"
  log.info "  - bin"
  log.info "  - git"
end

task :install do
  if ARGV == ["install"] # without any other arguments
    sh "rake install dot-zsh zshrc homebrew keyboard bin apps"
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

task :'dot-zsh' => [:'oh-my-zsh', :git_submodules] do
  sh "ln -s '#{repo_path}/dot-zsh' ~/.zsh" unless File.exists? File.expand_path "~/.zsh"
  sh "ls ~/.zsh"
end

task :git_submodules do
  sh "git submodule update --init"
end

task :homebrew do
  if mac? and not `which brew`.strip.present?
    sh '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  end
end

task :apps => [:emacs, :bat] do
  if mac?
    sh "brew install iterm2" unless File.exists? "/Applications/iTerm.app"
    sh "brew install textmate" unless File.exists? "/Applications/TextMate.app"
    sh "brew install vlc" unless File.exists? "/Applications/VLC.app"
    sh "brew install cyberduck" unless File.exists? "/Applications/Cyberduck.app"
    sh "brew install github" unless File.exists? "/Applications/Github Desktop.app"
    # sh "brew install zoom" unless File.exists? "/Applications/zoom.us.app"
    # sh "brew install slack" unless File.exists? "/Applications/Slack.app"
    # sh "brew install signal" unless File.exists? "/Applications/Signal.app"
  end
end

task :bat do
  if mac?
    sh "brew install bat" if `brew info bat`.include? "Not installed"
  elsif linux?
    sh "sudo apt install bat"
  end
end

task :keyboard => [:karabiner, :phoenix]

task :karabiner do
  if mac?
    sh "ln -s '#{repo_path}/config/karabiner' ~/.config/karabiner" unless File.exists? File.expand_path "~/.config/karabiner"
    sh "brew install karabiner-elements" unless File.exists? "/Applications/Karabiner-Elements.app"
  end
end

task :phoenix do
  if mac?
    sh "ln -s '#{repo_path}/phoenix.js' ~/.phoenix.js" unless File.exists? File.expand_path "~/.phoenix.js"
    sh "brew install phoenix" unless File.exists? "/Applications/Phoenix.app"
    sh "brew install coffeescript" unless `which coffee`.strip.present?
  end
end

desc "Symlink bin folder to ~/bin"
task :bin do
  sh "ln -s '#{repo_path}/bin' ~/bin" unless File.exists? File.expand_path "~/bin"
end

task :emacs do
  sh "brew install emacs" if mac?
  sh "ln -s '#{repo_path}/emacs.d' ~/.emacs.d" unless File.exists? File.expand_path "~/.emacs.d"
  sh "~/.emacs.d/bin/doom install"
end

task :yabai do
  sh "brew install koekeishiya/formulae/yabai --HEAD" if `brew info koekeishiya/formulae/yabai`.include? "Not installed"
  sh "ln -s '#{repo_path}/yabairc' ~/.yabairc" unless File.exists? File.expand_path "~/.yabairc"

  brew_install "koekeishiya/formulae/skhd"
  sh "ln -s '#{repo_path}/skhdrc' ~/.skhdrc" unless File.exists? File.expand_path "~/.skhdrc"
  sh "brew services start skhd"
end

task :polybar => :ubersicht do
  brew_install "jq"
  # https://github.com/knazarov/dotfiles/tree/master/ubersicht/polybar
  # This lives now in `.dotfiles/ubersicht/polybar`.
end

task :ubersicht do
  sh "ln -s '#{repo_path}/ubersicht' ~/Library/Application\\ Support/Übersicht/widgets" unless File.exists? File.expand_path "~/Library/Application Support/Übersicht/widgets"
  brew_install "ubersicht"
  open "/Applications/Übersicht.app"
end

task :simple_bar => :ubersicht do
  sh "git clone https://github.com/Jean-Tinland/simple-bar $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar" unless File.exists? File.expand_path "~/Library/Application\ Support/Übersicht/widgets/simple-bar"
  brew_install "homebrew/cask-fonts/font-jetbrains-mono"
  brew_install "homebrew/cask-fonts/font-jetbrains-mono-nerd-font"
end

task :git => :git_config
task :git_config do
  sh "ln -s '#{repo_path}/gitconfig' ~/.gitconfig" unless File.exists? File.expand_path "~/.gitconfig"
end
