# GitLink

GitLink is a command-line utility that simplifies the process of cloning and initializing Git repositories automating whole git repository setup. It provides two primary modes of operation:

- **Clone Mode (`--clone`)**: Clones an existing Git repository into a specified directory.
- **Init Mode (`--init`)**: Initializes a new Git repository in an empty directory and sets up a remote origin.

## Installation

1. Download the `gitlink` script.
2. Make it executable:
   ```bash
   chmod +x gitlink
   ```
3. Move it to a directory in your system's `$PATH`, such as `/usr/local/bin`:
   ```bash
   sudo mv gitlink /usr/local/bin/
   ```

## Usage

### Clone an Existing Repository

To clone an existing repository into a specified folder:
```bash
gitlink --clone <repo-link> [folder]
```

- `<repo-link>`: SSH or HTTPS link to the Git repository.
- `[folder]` (optional): Target directory to clone the repository into (defaults to the current directory).

Example:
```bash
gitlink --clone git@github.com:user/repo.git myproject
```

### Initialize a New Repository

- initialize a git repository in the specified folder with respective add arguments & change the main branch to main (incase master).
- Add a remote connection origin to the remote repo and upstream it with main.
- added, commited and pulled/pushed the current local repo to the remote repository.

To initialize a new repository and set up a remote origin:
```bash
gitlink --init <repo-link> [folder]
```

- `<repo-link>`: SSH or HTTPS link to the Git repository.
- `[folder]` (optional): Target directory for the new repository (defaults to the current directory).

Example:
```bash
gitlink --init git@github.com:user/newrepo.git mynewproject
```

### Optional Features

During initialization, GitLink prompts you to:
- Add a `.gitignore` file.
- Add a `README.md` file.

## Workflow

After the repository setup, workflow continues around with
- git add .
- git commit -m "some msg"
- git pull --rebase && git push


## Features
- Automates the whole Git repository setup.
- Ensures repositories are cloned/initialized correctly.
- Supports SSH and HTTPS remote URLs.
- Interactive prompts for adding `.gitignore` and `README.md`.

## Requirements
- Git must be installed.
- A valid SSH key must be set up for SSH-based repositories.

## License
This project is licensed under the MIT License.

