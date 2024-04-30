# Structure Creation

This module provides functions for creating the directory structure and files for a new Python package.

## Functionality

The `create_directory_structure` function creates directories and files with content for a new Python package.

### `create_directory_structure(base_path, file_contents)`

Creates directories and files with content for a new Python package.

#### Arguments
- `base_path (str)`: The base path where the package should be created.
- `file_contents (dict)`: A dictionary where keys are file paths and values are file contents.

#### Returns
None

```
def create_directory_structure(base_path, file_contents):
    """
    Create directories and files with content for a new Python package.

    Args:
    - base_path (str): The base path where the package should be created.
    - file_contents (dict): A dictionary where keys are file paths and values are file contents.
    """
```

### Usage Example

```python
import os

# Define directory structure and file contents
file_contents = {
    'src/mypackage/__init__.py': '# Initialization file for mypackage',
    'tests/__init__.py': '# Initialization file for tests',
    'tests/test_main.py': '# Unit tests for mypackage',
    'README.md': '# MyPackage\n\nWelcome to MyPackage!',
    'LICENSE': '# Add your license here',
    '.gitignore': '*.pyc\n__pycache__/\n',
}

# Create directory structure and files
create_directory_structure("/path/to/new/package", file_contents)
```
