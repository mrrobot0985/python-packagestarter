PYTHON_VERSION := 3.10
VENV_DIR := .venv
POETRY_BIN := $(VENV_DIR)/bin/poetry
AUTHOR_NAME := $(shell git config user.name)
AUTHOR_EMAIL := $(shell git config user.email)

PACKAGE_NAME := packagestarter
PACKAGE_VERSION := $(if $(shell git tag | tail -n 1),$(shell git tag | tail -n 1 | cut -c 2-),0)

# Define phony targets
.PHONY: help install install-deps test lint format build install-local uninstall-local clean \
        github-actions docker-setup security-scan release test-release generate-pyproject set-version

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
	@echo "  \033[32mmake security-scan\033[0m            Scan for security vulnerabilities using Trivy."
	@echo "  \033[32mmake release\033[0m                  Release the package to the official PyPI registry."
	@echo "  \033[32mmake test-release\033[0m             Release the package to the test PyPI registry."
	@echo "  \033[32mmake generate-pyproject\033[0m       Generate pyproject.toml."
	@echo "  \033[32mmake clear-cache\033[0m              Clear cache files."

# Create virtual environment and install Poetry
install:
	@echo "\n\033[1mCreating virtual environment and installing Poetry...\033[0m"
	@python3 -m venv $(VENV_DIR) && \
	$(VENV_DIR)/bin/python -m pip install --upgrade pip && \
	$(VENV_DIR)/bin/python -m pip install jinja2 poetry pytest flake8 black twine
	@echo "\n\033[32mVirtual environment created and Poetry installed.\033[0m"
	@echo "\033[1mTo activate the virtual environment, run:\033[0m\n\033[33msource $(VENV_DIR)/bin/activate\033[0m"

	@echo "\n\033[1mInstalling Trivy...\033[0m"
	@wget https://github.com/aquasecurity/trivy/releases/download/v0.50.4/trivy_0.50.4_Linux-64bit.deb && \
	sudo dpkg -i trivy_0.50.4_Linux-64bit.deb && \
	rm trivy_0.50.4_Linux-64bit.deb
	@echo "\n\033[32mTrivy installed.\033[0m"

# Install dependencies using Poetry
install-deps:
	@echo "\n\033[1mInstalling dependencies using Poetry...\033[0m"
	@$(POETRY_BIN) install
	@echo "\n\033[32mDependencies installed.\033[0m"

# Run tests using Poetry
test:
	@echo "\n\033[1mRunning tests using Poetry...\033[0m"
	@$(POETRY_BIN) run pytest -v
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
build: generate-pyproject
	rm -f dist/*
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

# Clear cache files
clear-cache:
	@echo "\n\033[1mClearing cache files...\033[0m"
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	@find . -type f -name '*.pyc' -exec rm -f {} +
	@echo "\n\033[32mCache files cleared.\033[0m"

# Run development tasks
devrun: install install-deps lint format build
	@echo "\n\033[32mDevelopment tasks completed.\033[0m"

# Test release to test PyPI registry
test-release: build test
	@echo "\n\033[1mReleasing to Test PyPI registry...\033[0m"
	@twine upload --repository-url https://test.pypi.org/legacy/ dist/* -u __token__ -p $(PYPI_TEST_TOKEN)
	@echo "\n\033[32mPackage released to Test PyPI registry.\033[0m"

# Official release to PyPI registry
release: build test
	@echo "\n\033[1mReleasing to PyPI registry...\033[0m"
	@twine upload dist/* -u __token__ -p $(PYPI_TOKEN)
	@echo "\n\033[32mPackage released to PyPI registry.\033[0m"

# Generate pyproject.toml
generate-pyproject:
	@echo "\n\033[1mGenerating pyproject.toml...\033[0m"
	@echo "[tool.poetry]" > pyproject.toml
	@echo "name = \"packagestarter\"" >> pyproject.toml
	@echo "version = \"${PACKAGE_VERSION}\"" >> pyproject.toml
	@echo "description = \"A package to create structured Python packages.\"" >> pyproject.toml
	@echo "license = \"The Unlicense\"" >> pyproject.toml
	@echo "authors = [\"$(AUTHOR_NAME) <$(AUTHOR_EMAIL)>\"]" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "[tool.poetry.dependencies]" >> pyproject.toml
	@echo "python = \"^$(PYTHON_VERSION)\"" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "[tool.poetry.dev-dependencies]" >> pyproject.toml
	@echo "pytest = \"^6.2\"" >> pyproject.toml
	@echo "jinja2 = \"^3.1\"" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "[build-system]" >> pyproject.toml
	@echo "requires = [\"poetry-core>=1.0.0\"]" >> pyproject.toml
	@echo "build-backend = \"poetry.core.masonry.api\"" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "[[tool.poetry.packages]]" >> pyproject.toml
	@echo "include = \"packagestarter\"" >> pyproject.toml
	@echo "from = \"src\"" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "[tool.poetry.scripts]" >> pyproject.toml
	@echo "packagestarter = \"packagestarter.packagestarter:main\"" >> pyproject.toml
	@echo "" >> pyproject.toml
	@echo "\033[32mpyproject.toml generated.\033[0m"

# Scan for security vulnerabilities using Trivy
security-scan:
	@echo "\n\033[1mScanning for security vulnerabilities using Trivy...\033[0m"
	@trivy filesystem ./src
	@echo "\033[32mSecurity scan completed.\033[0m"

# Run GitHub Actions workflow locally
github-actions:
	@echo "\n\033[1mRunning GitHub Actions workflow locally...\033[0m"
	@# Insert command to run GitHub Actions workflow locally
	@echo "\033[32mGitHub Actions workflow completed.\033[0m"

# Set up local Docker environment
docker-setup:
	@echo "\n\033[1mSetting up local Docker environment...\033[0m"
	@# Insert command to set up local Docker environment
	@echo "\033[32mLocal Docker environment set up.\033[0m"
