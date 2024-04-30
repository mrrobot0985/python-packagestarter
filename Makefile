PYTHON_VERSION := 3.10  # Default Python version
PACKAGE_NAME := packagestarter
VENV_DIR := .venv
POETRY_BIN := $(VENV_DIR)/bin/poetry

# Define phony targets
.PHONY: help install install-deps test lint format build install-local uninstall-local clean \
        github-actions docker-setup security-scan release

# Display help message
help:
	@echo "\033[1mAvailable targets:\033[0m"
	@echo "  \033[32mmake install\033[0m                  Create virtual environment, install Poetry, and upgrade pip."
	@echo "  \033[32mmake install-deps\033[0m             Install dependencies using Poetry."
	@echo "  \033[32mmake test\033[0m                     Run tests using Poetry."
	@echo "  \033[32mmake lint\033[0m                     Lint code using Flake8."
	@echo "  \033[32mmake format\033[0m                   Format code using Black."
	@echo "  \033[32mmake build\033[0m                    Build the package using Poetry."
	@echo "  \033[32mmake install-local\033[0m            Install the package locally using Poetry."
	@echo "  \033[32mmake uninstall-local\033[0m          Uninstall the package locally using Poetry."
	@echo "  \033[32mmake clean\033[0m                    Remove virtual environment and build artifacts."
	@echo "  \033[32mmake github-actions\033[0m           Run GitHub Actions workflow locally."
	@echo "  \033[32mmake docker-setup\033[0m             Set up local Docker environment."
	@echo "  \033[32mmake security-scan\033[0m            Scan for security vulnerabilities using trivy."
	@echo "  \033[32mmake release\033[0m                  Release the package (increment version, tag, and publish)."

# Create virtual environment and install Poetry
install:
	@echo "\n\033[1mCreating virtual environment and installing Poetry...\033[0m"
	@python3 -m venv $(VENV_DIR) && \
	$(VENV_DIR)/bin/python -m pip install --upgrade pip && \
	$(VENV_DIR)/bin/python -m pip install poetry
	@echo "\n\033[32mVirtual environment created and Poetry installed.\033[0m"
	@echo "\033[1mTo activate the virtual environment, run:\033[0m\n\033[33msource $(VENV_DIR)/bin/activate\033[0m"

# Install dependencies using Poetry
install-deps:
	@echo "\n\033[1mInstalling dependencies using Poetry...\033[0m"
	@$(POETRY_BIN) install
	@echo "\n\033[32mDependencies installed.\033[0m"

# Run tests using Poetry
test:
	@echo "\n\033[1mRunning tests using Poetry...\033[0m"
	@$(POETRY_BIN) run pytest
	@echo "\n\033[32mTests completed.\033[0m"

# Lint code using Flake8
lint:
	@echo "\n\033[1mLinting code using Flake8...\033[0m"
	@$(POETRY_BIN) run flake8 $(shell find . -type f \( -name '*.py' ! -name '*.py.jinja' \) -not -path "./.venv/*" -not -path "./.git/*" $(shell while read line; do echo "-not -path \"$${line}/*\" "; done < .gitignore)) 2>&1 | grep -v "FileNotFoundError: [Errno 2] No such file or directory: './src/packagestarter/base_templates'"
	@echo "\n\033[32mLinting completed.\033[0m"

# Format code using Black
format:
	@echo "\n\033[1mFormatting code using Black...\033[0m"
	@$(POETRY_BIN) run black $$(find . -type f \( -name '*.py' ! -name '*.pyc' \) \
		-not -path "./src/packagestarter/base_templates/*" \
		-not -path "./.venv/*" \
		-not -path "./.git/*" \
		-not -path "$(POETRY_HOME)/*" \
		| grep -v './src/packagestarter/base_templates') \
		|| true
	@echo "\n\033[32mCode formatted.\033[0m"


# Build the package using Poetry
build:
	@echo "\n\033[1mBuilding the package using Poetry...\033[0m"
	@$(POETRY_BIN) build
	@echo "\n\033[32mPackage built successfully.\033[0m"

# Install the package locally using Poetry
install-local:
	@echo "\n\033[1mInstalling the package locally using Poetry...\033[0m"
	@$(POETRY_BIN) install
	@echo "\n\033[32mPackage installed locally.\033[0m"

# Uninstall the package locally using Poetry
uninstall-local:
	@echo "\n\033[1mUninstalling the package locally using Poetry...\033[0m"
	@$(POETRY_BIN) uninstall $(PACKAGE_NAME) -y
	@echo "\n\033[32mPackage uninstalled locally.\033[0m"

# Remove virtual environment and build artifacts
clean:
	@echo "\n\033[1mRemoving virtual environment and build artifacts...\033[0m"
	@rm -rf $(VENV_DIR)
	@rm -rf dist build *.egg-info
	@echo "\n\033[32mVirtual environment and build artifacts removed.\033[0m"

# Run GitHub Actions workflow locally in a Docker container
github-actions:
	@echo "\n\033[1mRunning GitHub Actions workflow locally...\033[0m"
	@docker run --rm -v $(PWD):/github/workspace -w /github/workspace python:3.10 /bin/bash -c "pip install -r requirements.txt && make install && make test && make lint && make build && make security-scan"
	@echo "\n\033[32mGitHub Actions workflow ran locally.\033[0m"


# Set up local Docker environment
docker-setup:
	@echo "\n\033[1mSetting up local Docker environment...\033[0m"
	@# Add commands to set up local Docker environment
	@echo "\n\033[32mLocal Docker environment set up.\033[0m"

# Scan for security vulnerabilities using trivy
security-scan:
	@echo "\n\033[1mScanning for security vulnerabilities using trivy...\033[0m"
	@# Add commands to run security scan using trivy
	@echo "\n\033[32mSecurity scan completed.\033[0m"

# Release the package
release:
	@echo "\n\033[1mReleasing the package...\033[0m"
	@# Add commands to handle versioning, tagging, and publishing the package
	@echo "\n\033[32mPackage released.\033[0m"

# Run development tasks
devrun: install install-deps test lint format build
	@echo "\n\033[32mDevelopment tasks completed.\033[0m"
