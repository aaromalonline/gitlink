#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: gitlink --clone <repo-link> [folder]"
    echo "       gitlink --init <repo-link> [folder]"
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

# Ensure valid mode
if [[ "$MODE" != "--clone" && "$MODE" != "--init" ]]; then
    usage
fi

# Clone mode
if [ "$MODE" == "--clone" ]; then
    echo -e "\e[33m✔ Cloning repository into $TARGET_DIR\e[0m"
    git clone --depth=1 "$REPO_LINK" "$TARGET_DIR"
    exit 0
fi

# Initialize mode
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit

git init && echo -e "\e[32m✔ Git repository initialized in $TARGET_DIR\e[0m"
git branch -M main && echo -e "\e[32m✔ Branch set to main\e[0m"
git remote add origin "$REPO_LINK" && echo -e "\e[32m✔ Remote origin added: $REPO_LINK\e[0m"

# Ask user whether to create a .gitignore file
read -p "Do you want to add a .gitignore file? (y/n): " ADD_GITIGNORE
if [[ "$ADD_GITIGNORE" =~ ^[Yy]$ ]]; then
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

# Ask user whether to create a README file
read -p "Do you want to add a README.md file? (y/n): " ADD_README
if [[ "$ADD_README" =~ ^[Yy]$ ]]; then
    echo "# Project Title" > README.md
    echo -e "\e[32m✔ README.md file added\e[0m"
fi

# Add, commit files
git add . && echo -e "\e[32m✔ Files added\e[0m"
git commit -m "Initial commit" && echo -e "\e[32m✔ Commit created\e[0m"
git branch --set-upstream-to=origin/main && echo -e "\e[32m✔ Upstream set to origin/main\e[0m"

echo -e "\e[32m✔ Git setup completed successfully in $TARGET_DIR\e[0m"
