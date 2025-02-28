# 🚀 **GitLink** - Setup your repository in seconds – Clone, Init, Automate! ⚡

**GitLink** is a command-line utility that simplifies cloning and initializing Git repositories, automating the entire setup process.  

It provides two primary modes of operation:  

- 🔹 **Clone Mode (`--clone`)**: Clones an existing Git repository into a specified directory.  
- 🔹 **Init Mode (`--init`)**: Initializes a new Git repository in an empty directory and sets up a remote origin.  

---

## 📦 Installation  

1️⃣ **Download the `gitlink` script.**  
2️⃣ **Make it executable:**  
   ```bash
   chmod +x gitlink
   ```
3️⃣ **Move it to a directory in your system's `$PATH`, such as `/usr/local/bin`:**  
   ```bash
   sudo mv gitlink /usr/local/bin/
   ```
4️⃣ **Check the help menu:**  
   ```bash
   gitlink --help
   ```

---

## 🛠 **Usage**  

### 📥 Clone an Existing Repository  
To clone an existing repository into a specified folder:  
```bash
gitlink --clone <repo-link> [folder]
```
✅ **Parameters:**  
- 🔗 `<repo-link>`: SSH or HTTPS link to the Git repository.  
- 📂 `[folder]` *(optional)*: Target directory for cloning (defaults to the current directory).  

**Example:**  
```bash
gitlink --clone git@github.com:user/repo.git myproject
```

---

### 🌱 Initialize a New Repository  
- 📌 Initializes a **new** Git repository in the specified folder.  
- 🔗 Sets up a **remote origin** and switches the main branch to **main** (if needed).  
- 📂 Adds, commits, pulls (with rebase), and pushes local changes.  

To initialize a new repository and set up a remote origin:  
```bash
gitlink --init <repo-link> [folder] [--add r/g/rg]
```
✅ **Parameters:**  
- 🔗 `<repo-link>`: SSH or HTTPS link to the Git repository.  
- 📂 `[folder]` *(optional)*: Target directory (defaults to the current directory).  
- ✏️ `--add r/g/rg` *(optional)*:  
  - 📝 `r` → Add `README.md`  
  - 💜 `g` → Add `.gitignore` (prompts for patterns)  
  - 📦 `rg` / `gr` → Add **both**  

**Example:**  
```bash
gitlink --init git@github.com:user/newrepo.git mynewproject --add rg
```

---

### ⚠️ **Important Notes**  
🔴 `--init` **fails** if the remote repository is not empty.  
🔴 `.gitignore` prompts for patterns **only** when `--add g` is used.  

---

## 🔄 **Workflow**  
After setup, continue with:  
```bash
git add .
git commit -m "Some commit message"
git pull --rebase && git push
```

---

## ✨ **Features**  
✅ **Fully automates Git repository setup**  
✅ **Supports both SSH & HTTPS remote URLs**  
✅ **Ensures correct cloning & initialization**  
✅ **Handles rebase during `init` mode for minor conflicts**  
✅ **Optionally adds `README.md` & `.gitignore`**  

---

## 📌 **Requirements**  
✔️ Git must be installed 🛠️  
✔️ A valid **SSH key** must be set up for SSH-based repositories 🔑  

---

## 📝 **License**  
📖 Licensed under the **MIT License**.  

🚀 **Make Git Hassle-Free with GitLink!** 🔥✨  

