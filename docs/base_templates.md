# Base Templates

This module provides functions for generating content templates for initializing a Python package.

## Functionality

The `get_file_contents` function in this module generates a dictionary containing file paths and their content for initializing a Python package. It includes templates for various files such as `__init__.py`, `pyproject.toml`, `requirements.txt`, `README.md`, `LICENSE`, `.gitignore`, documentation files, test files, and a Makefile.

### `get_file_contents(package_name)`

Returns a dictionary containing file paths and their content for initializing a Python package.

#### Arguments
- `package_name (str)`: The name of the package.

#### Returns
- `dict`: Keys are relative file paths, and values are the content of the files.

```
def get_file_contents(package_name):
    """
    Returns a dictionary containing file paths and their content for initializing a Python package.

    Args:
    - package_name (str): The name of the package.

    Returns:
    - dict: Keys are relative file paths, and values are the content of the files.
    """
```

### Usage Example

```python
import os

# Generate file contents for package initialization
contents = get_file_contents("mypackage")

# Write contents to files
for file_path, file_content in contents.items():
    with open(file_path, "w") as file:
        file.write(file_content)
```
