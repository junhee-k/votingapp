# Flutter Project GitHub Collaboration Guide

## 1. Repository Setup
- Use the provided GitHub repository: [VotingApp Repository](https://github.com/junhee-k/votingapp.git)
- Ask the repository owner to add you as a **Collaborator** under "Settings" → "Manage Access".

## 2. Cloning the Repository
Each team member should:
1. Clone the repository:
   ```sh
   git clone https://github.com/junhee-k/votingapp.git
   ```
2. Navigate into the project directory:
   ```sh
   cd votingapp
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```

## 3. Branching & Workflow
- Always work in a separate branch.
- Use meaningful branch names, e.g., `feature-login-screen`.
- Avoid working directly on `main`.

### Creating a New Branch
```sh
git checkout -b feature-branch-name
```
- Creates a new branch and switches to it.

### Making Changes
1. Modify files.
2. Stage changes:
```sh
git add .
```
3. Commit changes:
```sh
git commit -m "Describe the change"
```
4. Push the branch to GitHub:
```sh
git push origin feature-branch-name
```

## 4. Pull Requests (PR)
- Open a PR when a feature is ready for review.
- Assign at least one reviewer.
- Merge only after approval.
- Always **pull latest changes** before starting new work:
```sh
git checkout main
git pull origin main
git checkout -b new-feature-branch
```

## 5. Code & Commit Guidelines
- Follow Flutter's best practices.
- Keep commit messages clear and concise.
- Example commit messages:
  - ✅ "Fixed UI bug in login screen"
  - ❌ "Update main.dart"

## 6. Common Git Commands Explained
- Check branch:
  ```sh
  git branch
  ```
  - Lists all branches in the repository.
- Switch branches:
  ```sh
  git checkout branch-name
  ```
  - Moves to the specified branch.
- Pull latest changes:
  ```sh
  git pull origin main
  ```
  - Updates the local branch with the latest remote changes.
- Merge a branch into `main`:
  ```sh
  git checkout main
  git merge feature-branch-name
  git push origin main
  ```
  - Combines changes from the feature branch into `main`.

## 7. Handling Merge Conflicts
- If Git shows a merge conflict, open the conflicting file and manually resolve it.
- After resolving, run:
  ```sh
  git add .
  git commit -m "Resolved merge conflict"
  git push origin main
  ```

## 8. Additional Tips
- Keep your branches updated (`git pull origin main`).
- Use `.gitignore` to avoid committing unnecessary files.
- Use **issues** and **project boards** for task management.

Happy coding! 🚀

