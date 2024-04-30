import os
import subprocess
import time


def run_command(command, cwd):
    """Execute system command in the specified directory."""
    try:
        print(f"Running command: {command}")
        subprocess.check_call(command, shell=True, cwd=cwd)
        print("Command executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing {command}: {e}")


def initialize_git(base_path, package_name):
    """Initialize git repository and manage branches mimicking the Git Flow model."""
    # Check if .git directory already exists
    git_dir = os.path.join(base_path, ".git")
    if os.path.exists(git_dir):
        print("Git repository already exists, skipping Git initialization.")
        return

    # Initialize the Git repository
    run_command("git init", base_path)
    time.sleep(1)  # Pause for 1 second

    # Set default Git user identity if not configured
    if not is_git_configured(base_path):
        run_command(f'git config user.email "you@example.com"', base_path)
        run_command(f'git config user.name "Your Name"', base_path)

    # Initial commit with common files like README, LICENSE, pyproject.toml, .gitignore, requirements.txt, and Makefile
    run_command(
        "git add README.md LICENSE pyproject.toml .gitignore requirements.txt Makefile",
        base_path,
    )

    # Check if there are changes to commit
    status_output = (
        subprocess.check_output("git status --porcelain", shell=True, cwd=base_path)
        .decode()
        .strip()
    )
    if status_output:
        run_command(
            'git commit -m "Initial commit: Add common project files."', base_path
        )
    else:
        print("No changes to commit.")

    time.sleep(1)  # Pause for 1 second

    # Check if 'main' branch exists and switch to it, else create it
    if branch_exists("main", base_path):
        run_command("git checkout main", base_path)
    else:
        run_command("git checkout -b main", base_path)
    time.sleep(1)  # Pause for 1 second

    # Create and switch to the 'develop' branch
    run_command("git checkout -b develop", base_path)
    time.sleep(1)  # Pause for 1 second

    # Create a feature branch from 'develop'
    feature_branch_name = "feature/initial-setup"
    run_command(f"git checkout -b {feature_branch_name} develop", base_path)
    time.sleep(1)  # Pause for 1 second

    # Add package-specific files and commit in the feature branch
    run_command("git add .", base_path)

    # Check if there are changes to commit after adding files
    status_output = (
        subprocess.check_output("git status --porcelain", shell=True, cwd=base_path)
        .decode()
        .strip()
    )
    if status_output:
        run_command(
            f'git commit -m "Feature commit: Add initial package structure and documentation."',
            base_path,
        )
    else:
        print("No changes to commit.")

    time.sleep(1)  # Pause for 1 second

    # Merge the feature branch back to 'develop' with a no-fast-forward merge
    run_command("git checkout develop", base_path)
    run_command(
        f'git merge --no-ff {feature_branch_name} -m "Merge {feature_branch_name}"',
        base_path,
    )
    run_command(f"git branch -d {feature_branch_name}", base_path)
    time.sleep(1)  # Pause for 1 second

    # Optionally, prepare for release by merging 'develop' to 'main'
    run_command("git checkout main", base_path)
    run_command('git merge develop -m "Prepare release"', base_path)
    run_command("git checkout develop", base_path)
    time.sleep(1)  # Pause for 1 second


def branch_exists(branch_name, base_path):
    """Check if a Git branch exists."""
    try:
        subprocess.check_output(
            f"git show-ref --verify --quiet refs/heads/{branch_name}",
            shell=True,
            cwd=base_path,
        )
        return True
    except subprocess.CalledProcessError:
        return False


def is_git_configured(base_path):
    """Check if Git user identity is configured."""
    try:
        subprocess.check_output(
            "git config --get user.email", shell=True, cwd=base_path
        )
        subprocess.check_output(
            "git config --get user.name", shell=True, cwd=base_path
        )
        return True
    except subprocess.CalledProcessError:
        return False
