REQUIRED_GEMS=rake colored fiedl-log

install:
	@echo "Welcome to https://github.com/fiedl/dotfiles!"
	@echo "This will install some required tools and then give you options on how to proceed."
	@echo ""

	bin/install_ruby
	ruby --version

	gem install $(REQUIRED_GEMS) || sudo gem install $(REQUIRED_GEMS)

	rake
