# PackageStarter

Welcome to PackageStarter! This package is designed to automate the creation of Python packages, providing a convenient way to set up directory structures, initialize Git repositories, and manage project files.

## Features

- Automatically generates a Python package structure with customizable options.
- Initializes a Git repository with common project files and follows the Git Flow branching model.
- Provides templates for commonly used files such as README.md, LICENSE, pyproject.toml, .gitignore, requirements.txt, Makefile, and more.
- Simplifies the process of setting up package documentation and testing frameworks.

## Installation

PackageStarter can be installed via pip:

```bash
pip install packagestarter
```

## Usage

To use PackageStarter, simply run the `packagestarter` command followed by the name of your package:

```bash
packagestarter my_package
```

You can also specify the target directory where the package will be created using the `-d` or `--directory` option:

```bash
packagestarter my_package -d /path/to/target_directory
```

For more options and customization, refer to the documentation or use the `--help` option:

```bash
packagestarter --help
```

## Contributing

We welcome contributions from the community! If you have any ideas, bug reports, or feature requests, please open an issue on GitHub or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
