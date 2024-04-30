# Git Initializer

This module provides functions for initializing a Git repository and managing branches according to the Git Flow model.

## Functionality

The `run_command` function executes system commands in the specified directory, while the `initialize_git` function initializes a Git repository, manages branches, and mimics the Git Flow model.

### `run_command(command, cwd)`

Executes a system command in the specified directory.

#### Arguments
- `command (str)`: The system command to execute.
- `cwd (str)`: The directory in which to execute the command.

#### Returns
None

```
def run_command(command, cwd):
    """ Execute system command in the specified directory. """
```

### `initialize_git(base_path, package_name)`

Initializes a Git repository, manages branches, and mimics the Git Flow model.

#### Arguments
- `base_path (str)`: The base path of the directory in which to initialize the Git repository.
- `package_name (str)`: The name of the package.

#### Returns
None

```
def initialize_git(base_path, package_name):
    """ Initialize git repository and manage branches mimicking the Git Flow model. """
```

### `branch_exists(branch_name, base_path)`

Checks if a Git branch exists.

#### Arguments
- `branch_name (str)`: The name of the branch to check.
- `base_path (str)`: The base path of the directory containing the Git repository.

#### Returns
- `bool`: True if the branch exists, False otherwise.

```
def branch_exists(branch_name, base_path):
    """ Check if a Git branch exists. """
```

### Usage Example

```python
import os
import time

# Initialize Git repository for package
initialize_git("/path/to/repository", "mypackage")
```
