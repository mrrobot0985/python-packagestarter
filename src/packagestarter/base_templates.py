import os
from jinja2 import Environment, FileSystemLoader

def get_file_contents(package_name):
    """
    Returns a dictionary containing file paths and their content for initializing a Python package.

    Args:
    - package_name (str): The name of the package.

    Returns:
    - dict: Keys are relative file paths, and values are the content of the files.
    """
    contents = {}
    # Initialize Jinja environment with an absolute path to the templates directory
    template_loader = FileSystemLoader(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates'))
    env = Environment(loader=template_loader)

    # Map template files to their output paths
    template_files = {
        'src/package_name/__init__.py.jinja': f'src/{package_name}/__init__.py',
        'tests/__init__.py.jinja': 'tests/__init__.py',
        'tests/test_main.py.jinja': 'tests/test_main.py',
        'tests/conftest.py.jinja': 'tests/conftest.py',
        'root/pyproject.toml.jinja': 'pyproject.toml',
        'root/requirements.txt.jinja': 'requirements.txt',
        'root/README.md.jinja': 'README.md',
        'root/LICENSE.jinja': 'LICENSE',
        'root/.gitignore.jinja': '.gitignore',
        'docs/index.md.jinja': 'docs/index.md',
        'docs/BUILD.md.jinja': 'docs/BUILD.md',
        'root/Makefile.jinja': 'Makefile'
    }

    # Render templates
    for template_path, file_path in template_files.items():
        template = env.get_template(template_path)
        rendered_content = template.render(package_name=package_name)
        contents[file_path] = rendered_content

    return contents

def main():
    package_name = "my_package"

    # Get file contents
    contents = get_file_contents(package_name)

    # Output file paths and contents
    for file_path, content in contents.items():
        print(f"File: {file_path}")
        print(content)
        print()

if __name__ == "__main__":
    main()
