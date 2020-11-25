bootstrap: ## Install ruby tools
	brew update
	brew install mint
	mint bootstrap
	sudo gem install bundler
	bundle --path vendor/bundle --binstubs=vendor/bin
	bundle install --path=vendor/bundle

project: ## Generate Xcode project and workspace
	mint run XcodeGen xcodegen
	mint run Carthage carthage bootstrap --platform iOS --cache-builds
	echo mint run Carthage carthage update --platform iOS --cache-builds 

open: ## Open Xcode workspace
	open smart-novel-ios.xcodeproj

xcode12-workaround: ## Temporary steps to build with Xcode 12
	sh ./scripts/carthage-workaround-xc12.sh update --platform iOS --cache-builds
