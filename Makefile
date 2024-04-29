PYTHON_VERSION := 3.10  # Default Python version

# Define phony targets
.PHONY: help install install-deps test clean build install-local uninstall-local

# Display help message
help:
	@echo "\033[1mAvailable targets:\033[0m"
	@echo "  \033[32mmake install\033[0m              Create virtual environment, install Poetry, and upgrade pip."
	@echo "  \033[32mmake install-deps\033[0m         Install dependencies using Poetry."
	@echo "  \033[32mmake test\033[0m                 Run tests using Poetry."
	@echo "  \033[32mmake build\033[0m                Build the package using Poetry."
	@echo "  \033[32mmake install-local\033[0m        Install the package locally using Poetry."
	@echo "  \033[32mmake uninstall-local\033[0m      Uninstall the package locally using Poetry."
	@echo "  \033[32mmake clean\033[0m                Remove virtual environment and build artifacts."

# Create virtual environment and install Poetry
install:
	@echo "\n\033[1mCreating virtual environment and installing Poetry...\033[0m"
	@python3 -m venv .venv && \
	.venv/bin/python -m pip install --upgrade pip && \
	.venv/bin/python -m pip install poetry
	@echo "\n\033[32mVirtual environment created and Poetry installed.\033[0m"
	@echo "\033[1mTo activate the virtual environment, run:\033[0m\n\033[33msource .venv/bin/activate\033[0m"

# Install dependencies using Poetry
install-deps:
	@echo "\n\033[1mInstalling dependencies using Poetry...\033[0m"
	@poetry install
	@echo "\n\033[32mDependencies installed.\033[0m"

# Run tests using Poetry
test:
	@echo "\n\033[1mRunning tests using Poetry...\033[0m"
	@poetry run pytest
	@echo "\n\033[32mTests completed.\033[0m"

# Build the package using Poetry
build:
	@echo "\n\033[1mBuilding the package using Poetry...\033[0m"
	@poetry build
	@echo "\n\033[32mPackage built successfully.\033[0m"

# Install the package locally using Poetry
install-local:
	@echo "\n\033[1mInstalling the package locally using Poetry...\033[0m"
	@poetry install
	@echo "\n\033[32mPackage installed locally.\033[0m"

# Uninstall the package locally using Poetry
uninstall-local:
	@echo "\n\033[1mUninstalling the package locally using Poetry...\033[0m"
	@poetry uninstall <package_name>
	@echo "\n\033[32mPackage uninstalled locally.\033[0m"

# Remove virtual environment and build artifacts
clean:
	@echo "\n\033[1mRemoving virtual environment and build artifacts...\033[0m"
	@rm -rf .venv
	@poetry env remove $(PYTHON_VERSION)  # Remove the Poetry virtual environment
	@rm -rf dist build *.egg-info  # Remove build artifacts
	@echo "\n\033[32mVirtual environment and build artifacts removed.\033[0m"
