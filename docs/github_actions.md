# GitHub Actions Workflows

This document provides an overview of the GitHub Actions workflows set up for the Python project. There are two main workflows defined to automate testing and deployment processes: one for pre-release (beta versions) and another for main branch and stable releases.

## Workflow for Pre-Release (Beta Versions)

### Filename: `python-test-package-workflow.yml`

This workflow is designed to handle continuous integration and delivery for the development and pre-release stages, particularly focusing on beta versions.

#### Triggers

- **Branches:** Develop (on push)
- **Tags:** Tags that match `v*-beta` (on push)

#### Jobs

1. **Test**
   - **Purpose:** Runs tests to ensure code changes do not break existing functionality.
   - **Runs on:** Ubuntu-latest.
   - **Python Versions:** Tests against Python 3.7, 3.8, 3.9, and 3.10.
   - **Key Steps:**
     - Checkout code.
     - Set up Python environment.
     - Install dependencies using Poetry.
     - Run tests using pytest.

2. **Release**
   - **Purpose:** Builds and publishes the package to the Test PyPI upon successful testing when a beta tag is pushed.
   - **Runs on:** Ubuntu-latest.
   - **Python Version:** Uses Python 3.10 for release.
   - **Key Steps:**
     - Checkout code.
     - Set up Python environment.
     - Install dependencies.
     - Build the package using Poetry.
     - Publish the package using Twine to Test PyPI.

### Workflow for Main Branch and Stable Releases

#### Filename: `python-main-package-workflow.yml`

This workflow is tailored for handling stable releases that are pushed to the main branch or tagged without the 'beta' qualifier.

#### Triggers

- **Branches:** Main (on push)
- **Tags:** Tags that match `v*` and do not include `beta` (on push)

#### Jobs

1. **Test**
   - **Purpose:** Verifies that updates to the main branch or stable version releases do not introduce regressions.
   - **Runs on:** Ubuntu-latest.
   - **Python Versions:** Tests across Python 3.7, 3.8, 3.9, and 3.10.
   - **Key Steps:**
     - Checkout code.
     - Set up Python.
     - Conditionally update `pyproject.toml` to reflect tag version.
     - Install dependencies.
     - Run tests.

2. **Release**
   - **Purpose:** Builds and publishes the package to the official PyPI upon successful testing when a non-beta tag is pushed.
   - **Runs on:** Ubuntu-latest.
   - **Python Version:** Uses Python 3.10 for release.
   - **Key Steps:**
     - Checkout code.
     - Set up Python.
     - Install dependencies.
     - Build the package.
     - Publish the package to PyPI using Twine.

## Notes

Both workflows are crucial for maintaining the quality and stability of the software throughout its lifecycle. By automating these processes, we ensure consistent and reliable package deployments, and rigorous standards are maintained throughout the development and release phases.
