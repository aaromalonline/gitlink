#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: gitlink --clone <repo-link> [folder]"
    echo "       gitlink --init <repo-link> [folder] [--add r/g/rg]"
    exit 1
}

# Check if at least two arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    usage
fi

# Parse options
MODE="$1"
REPO_LINK="$2"
TARGET_DIR="${3:-$(pwd)}"
ADD_README=false
ADD_GITIGNORE=false

# Handle --add flag with options
if [[ "$4" == "--add" ]]; then
    case "$5" in
        "r") ADD_README=true ;;
        "g") ADD_GITIGNORE=true ;;
        "rg"|"gr") ADD_README=true; ADD_GITIGNORE=true ;;
        *) echo -e "\e[31m✖ Invalid --add option. Use 'r' for README, 'g' for .gitignore, or 'rg' for both.\e[0m"; exit 1 ;;
    esac
fi

# Ensure valid mode
if [[ "$MODE" != "--clone" && "$MODE" != "--init" ]]; then
    usage
fi

# Clone mode
if [ "$MODE" == "--clone" ]; then
    echo -e "\e[33m✔ Cloning repository into $TARGET_DIR\e[0m"
    if ! git clone --depth=1 "$REPO_LINK" "$TARGET_DIR"; then
        echo -e "\e[31m✖ Cloning failed. Please resolve conflicts manually.\e[0m"
        exit 1
    fi
    exit 0
fi

# Initialize mode: Check if remote repository is empty
if git ls-remote --exit-code "$REPO_LINK" &>/dev/null; then
    echo -e "\e[31m✖ Initialization failed. The remote repository is not empty.\e[0m"
    exit 1
fi

# Initialize a new repository
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit

git init && echo -e "\e[32m✔ Git repository initialized in $TARGET_DIR\e[0m"
git branch -M main && echo -e "\e[32m✔ Branch set to main\e[0m"
git remote add origin "$REPO_LINK" && echo -e "\e[32m✔ Remote origin added: $REPO_LINK\e[0m"

# Add .gitignore if requested
if [ "$ADD_GITIGNORE" = true ]; then
    echo "# Add files to ignore below" > .gitignore
    echo -e "\e[32m✔ .gitignore file added\e[0m"
    while true; do
        read -p "Enter a file or pattern to ignore (or press Enter to finish): " IGNORE_ENTRY
        if [ -z "$IGNORE_ENTRY" ]; then
            break
        fi
        echo "$IGNORE_ENTRY" >> .gitignore
        echo -e "\e[32m✔ Added '$IGNORE_ENTRY' to .gitignore\e[0m"
    done
fi

# Add README.md if requested
if [ "$ADD_README" = true ]; then
    echo "# Project Title" > README.md
    echo -e "\e[32m✔ README.md file added\e[0m"
fi

# Add, commit files
git add . && echo -e "\e[32m✔ Files added\e[0m"
if ! git commit -m "Initial commit"; then
    echo -e "\e[31m✖ Commit failed. Please resolve conflicts manually.\e[0m"
    exit 1
fi
git branch --set-upstream-to=origin/main && echo -e "\e[32m✔ Upstream set to origin/main\e[0m"

echo -e "\e[32m✔ Git setup completed successfully in $TARGET_DIR\e[0m"
