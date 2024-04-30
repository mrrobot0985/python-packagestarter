import os


def create_directory_structure(base_path, file_contents):
    """
    Create directories and files with content for a new Python package.

    Args:
    - base_path (str): The base path where the package should be created.
    - file_contents (dict): A dictionary where keys are file paths and values are file contents.
    """
    # Create all directories
    directories = {os.path.dirname(path) for path in file_contents}
    for directory in directories:
        directory_path = os.path.join(base_path, directory)
        if not os.path.exists(directory_path):
            os.makedirs(directory_path)
            print(f"Created directory: {directory_path}")
        else:
            print(f"Directory already exists: {directory_path}")

    # Create all files
    for file_path, content in file_contents.items():
        full_path = os.path.join(base_path, file_path)
        if not os.path.exists(full_path):
            with open(full_path, "w") as file:
                file.write(content)
                print(f"Created file: {full_path}")
        else:
            print(f"File already exists, skipping: {full_path}")
