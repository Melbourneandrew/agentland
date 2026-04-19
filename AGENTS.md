# Agent Workflow & Conventions

This project utilizes AI agents (Gemini CLI, Cursor, etc.) for development. Agents working in this repository must adhere to the following operational standards:

## 1. Version Control & Committing
- **Commit Frequently:** Make small, atomic, and logical commits as features are developed or bugs are fixed.
- **Conventional Commits:** Use the conventional commit format for all commit messages (e.g., `feat: ...`, `fix: ...`, `chore: ...`, `refactor: ...`, `docs: ...`).
- **`.gitignore` Maintenance:** Before creating new directories, temporary files, or outputs, ensure they are properly covered by `.gitignore`. **NEVER** commit secrets, `.env` files, build outputs, or `.wo-executions` to the repository.

## 2. Token-Efficient Automation
- **Quiet Execution:** When running tests, builds, or lints, utilize the `scripts/quiet-run.sh` wrapper (via the `Makefile`). This ensures that successful commands output only a single line of success, preserving the LLM's context window and saving tokens.
- **Failures Only:** Logs and stdout/stderr are only printed if a command fails, providing you with the exact context needed to fix the issue.

## 3. Extending the System
- **Scripts and Hooks:** All project-related scripts must go through the root `Makefile` and `scripts/` directory. 
- When introducing a new linter, test suite, or convention, **add it to the pre-commit hook system** to enforce it automatically across the lifetime of the project.
