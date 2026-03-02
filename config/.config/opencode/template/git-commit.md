I need you committed changes to a git repository following best practices for commit messages and ensuring clarity on the changes being made.

**Task Steps**
- **Read Repository Status:** Execute `git status` to confirm the current branch, uncommitted changes, staged content, and untracked files.
- **Change Review (Mandatory):**
    - **Unstaged Changes:** Execute `git diff`
    - **Staged Changes:** Execute `git diff --staged`
    - Determine the nature of the changes (e.g., feature addition, bug fix, documentation, refactoring, testing, build, etc.) based on the diffs.
- **Handle Unstaged Changes:**
    - If unstaged changes exist, ask the user whether to stage them.
    - If the user agrees, execute `git add <file>` or `git add .` (specify the scope clearly).
- **Handle Untracked Files:**
    - If untracked files exist, prompt for each file whether to add it.
    - Explicitly exclude sensitive or irrelevant files.
- **Generate Commit Message:**
    - Generate candidate messages following **Conventional Commits**.
    - Prioritize explaining the **"why"**; avoid merely restating **"what was done"**.
- **Confirm Staged State:**
    - If the staged area is empty, **prohibit committing** and prompt the user to stage changes first.
- **Execute Commit:**
    - Declare the command to be executed before committing.
    - Execute `git commit -m "<message>"`.
- **Result Summary:**
    - Output the commit hash, number of files, and primary change types.
    - If the commit fails (e.g., due to hooks or conflicts), summarize the reason and provide next-step suggestions.

**Specifications**
- **Prohibit `rebase`; prohibit `push --force`.**
- Do not modify `git config`; do not skip hooks (e.g., with `--no-verify`).
- **Commit messages must comply with Conventional Commits:**
    - **Format:** `type(scope?): subject`
    - **Allowed Types:** `feat` | `fix` | `docs` | `style` | `refactor` | `perf` | `test` | `build` | `ci` | `chore` | `revert`
    - **Scope** is optional, must be concise, and align with the change domain.
    - **Subject** uses imperative mood, starts with lowercase letter, and has no period at the end.
- **Breaking Changes:**
    - Must be confirmed by the user.
    - Use `!` or `BREAKING CHANGE:` to describe them.
- **Security & Sensitive Information:**
    - If `.env`, `credentials.json`, keys, or suspected confidential information are detected, **refuse to commit by default** and issue a warning.
    - If the user insists, **require re-confirmation** and log a risk disclaimer.
- **Change Transparency:**
    - Explain the command to be executed before committing.
    - After committing, output only a key summary, not lengthy logs.
- **Pre-Write Operation Checks:**
    - Must confirm `git status` before any `git add` or `git commit`.
    - If there are unaddressed local changes, their handling must be clarified first.