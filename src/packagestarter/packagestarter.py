import os
import argparse
from .structure_creation import create_directory_structure
from .base_templates import get_file_contents
from .git_initializer import initialize_git


def main():
    # Setup argument parser
    parser = argparse.ArgumentParser(description="Generate a Python package structure.")
    parser.add_argument("package_name", help="The name of the package to create.")
    parser.add_argument(
        "-d",
        "--directory",
        help="The target directory where the package will be created. Defaults to the current directory.",
        default=os.getcwd(),
    )

    # Parse arguments
    args = parser.parse_args()

    # Determine the base path
    base_path = os.path.join(args.directory, args.package_name)

    # Get content for files
    file_contents = get_file_contents(args.package_name)

    # Create the directory structure and files
    create_directory_structure(base_path, file_contents)

    # Initialize git
    initialize_git(base_path, args.package_name)

    # Final message
    print(
        f"Package {args.package_name} created successfully with Git repository at {base_path}"
    )


if __name__ == "__main__":
    main()
