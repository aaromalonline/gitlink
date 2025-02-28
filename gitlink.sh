#!/bin/bash

# Check if at least the repo link is provided
if [ -z "$1" ] || { [ -n "$2" ] && [ -z "$2" ]; }; then
    echo "Usage: initialize [folder] <ssh-repo-link>"
    exit 1
fi

# Determine if a folder argument is provided
if [ -z "$2" ]; then
    REPO_LINK="$1"
    TARGET_DIR="$(pwd)"
else
    TARGET_DIR="$1"
    REPO_LINK="$2"

    # Create and navigate to the target directory if it doesn't exist
    if [ ! -d "$TARGET_DIR" ]; then
        mkdir -p "$TARGET_DIR"
    fi
    cd "$TARGET_DIR" || exit
fi

# Check if remote repository has any content
git ls-remote --exit-code "$REPO_LINK" &>/dev/null
if [ $? -eq 0 ]; then
    echo -e "\e[33m✔ Remote repository contains data. Cloning instead.\e[0m"
    git clone --depth=1 "$REPO_LINK" .
    exit 0
fi

# Initialize git repository
git init && echo -e "\e[32m✔ Git repository initialized in $TARGET_DIR\e[0m"

# Set branch to main
git branch -M main && echo -e "\e[32m✔ Branch set to main\e[0m"

# Add remote origin
git remote add origin "$REPO_LINK" && echo -e "\e[32m✔ Remote origin added: $REPO_LINK\e[0m"

# Ask user whether to create a .gitignore file
read -p "Do you want to add a .gitignore file? (y/n): " ADD_GITIGNORE
if [[ "$ADD_GITIGNORE" =~ ^[Yy]$ ]]; then
    echo "# Add files to ignore below" > .gitignore
    echo -e "\e[32m✔ .gitignore file added\e[0m"
    
    # Ask user for files to ignore
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
git commit -m "current" && echo -e "\e[32m✔ Commit created\e[0m"

git branch --set-upstream-to=origin/main && echo -e "\e[32m✔ Upstream set to origin/main\e[0m"

echo -e "\e[32m✔ Git setup completed successfully in $TARGET_DIR\e[0m"
