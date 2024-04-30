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

    # Load Jinja templates
    template_files = [
        '__init__.py.jinja',
        'test_main.py.jinja',
        'pyproject.toml.jinja',
        'requirements.txt.jinja',
        'README.md.jinja',
        'LICENSE.jinja',
        '.gitignore.jinja',
        'index.md.jinja',
        'BUILD.md.jinja',
        'conftest.py.jinja',
        'Makefile.jinja'
    ]

    # Render templates
    for template_file in template_files:
        template = env.get_template(template_file)
        rendered_content = template.render(package_name=package_name)
        file_path = template_file.replace('.jinja', '')
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
