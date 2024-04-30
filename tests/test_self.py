import os

def test_license_exists():
    assert os.path.exists("LICENSE")

def test_makefile_exists():
    assert os.path.exists("Makefile")

def test_readme_exists():
    assert os.path.exists("README.md")

def test_poetry_lock_exists():
    assert os.path.exists("poetry.lock")

def test_pyproject_toml_exists():
    assert os.path.exists("pyproject.toml")

def test_src_directory_exists():
    assert os.path.exists("src")

def test_tests_directory_exists():
    assert os.path.exists("tests")

def test_docs_directory_exists():
    assert os.path.exists("docs")

def test_base_templates_md_exists():
    assert os.path.exists("docs/base_templates.md")

def test_git_initializer_md_exists():
    assert os.path.exists("docs/git_initializer.md")

def test_packagestarter_md_exists():
    assert os.path.exists("docs/packagestarter.md")

def test_structure_creation_md_exists():
    assert os.path.exists("docs/structure_creation.md")

def test_packagestarter_directory_exists():
    assert os.path.exists("src/packagestarter")

def test_package_init_py_exists():
    assert os.path.exists("src/packagestarter/__init__.py")

def test_base_templates_py_exists():
    assert os.path.exists("src/packagestarter/base_templates.py")

def test_git_initializer_py_exists():
    assert os.path.exists("src/packagestarter/git_initializer.py")

def test_packagestarter_py_exists():
    assert os.path.exists("src/packagestarter/packagestarter.py")

def test_structure_creation_py_exists():
    assert os.path.exists("src/packagestarter/structure_creation.py")

def test_templates_directory_exists():
    assert os.path.exists("src/packagestarter/templates")

def test_templates_files_exist():
    assert os.path.exists("src/packagestarter/templates/BUILD.md.jinja")
    assert os.path.exists("src/packagestarter/templates/LICENSE.jinja")
    assert os.path.exists("src/packagestarter/templates/Makefile.jinja")
    assert os.path.exists("src/packagestarter/templates/README.md.jinja")
    assert os.path.exists("src/packagestarter/templates/__init__.py.jinja")
    assert os.path.exists("src/packagestarter/templates/conftest.py.jinja")
    assert os.path.exists("src/packagestarter/templates/index.md.jinja")
    assert os.path.exists("src/packagestarter/templates/pyproject.toml.jinja")
    assert os.path.exists("src/packagestarter/templates/requirements.txt.jinja")
    assert os.path.exists("src/packagestarter/templates/test_main.py.jinja")

def test_self_py_exists():
    assert os.path.exists("tests/test_self.py")
