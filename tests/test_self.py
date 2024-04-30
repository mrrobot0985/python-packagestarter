import os


def test_license_exists():
    assert os.path.exists("LICENSE")


def test_makefile_exists():
    assert os.path.exists("Makefile")


def test_readme_exists():
    assert os.path.exists("README.md")


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
    base_path = "src/packagestarter/templates"
    assert os.path.exists(os.path.join(base_path, "src/package_name/__init__.py.jinja"))
    assert os.path.exists(os.path.join(base_path, "tests/test_main.py.jinja"))
    assert os.path.exists(os.path.join(base_path, "tests/__init__.py.jinja"))
    assert os.path.exists(os.path.join(base_path, "tests/conftest.py.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/pyproject.toml.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/requirements.txt.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/README.md.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/LICENSE.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/.gitignore.jinja"))
    assert os.path.exists(os.path.join(base_path, "docs/index.md.jinja"))
    assert os.path.exists(os.path.join(base_path, "docs/BUILD.md.jinja"))
    assert os.path.exists(os.path.join(base_path, "root/Makefile.jinja"))


def test_self_py_exists():
    assert os.path.exists("tests/test_self.py")
