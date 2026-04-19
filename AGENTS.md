# Agent Workflow & Conventions

This project utilizes AI agents (Gemini CLI, Cursor, etc.) for development. Agents working in this repository must adhere to the following operational standards:

## 1. Version Control & Committing
- **Commit Frequently:** Make small, atomic, and logical commits as features are developed or bugs are fixed.
- **Conventional Commits:** Use the conventional commit format for all commit messages (e.g., `feat: ...`, `fix: ...`, `chore: ...`, `refactor: ...`, `docs: ...`).
- **`.gitignore` Maintenance:** Before creating new directories, temporary files, or outputs, ensure they are properly covered by `.gitignore`. **NEVER** commit secrets, `.env` files, build outputs, or `.wo-executions` to the repository.

## 2. Pull Requests & Work Order Handoff
- **One PR per Work Order:** Every work order must be developed on a branch and submitted as a distinct Pull Request.
- **The "Next Agent Merges" Rule:** The agent starting a *new* work order is responsible for merging the *previous* work order's PR. Before beginning new work, the agent must verify that the previous work order's PR has a completed checklist, a passing review log, and successful CI checks. If it passes, merge it. If it fails, fix the previous PR before starting the new one.

## 3. Token-Efficient Automation
- **Quiet Execution:** When running tests, builds, or lints, utilize the `scripts/quiet-run.sh` wrapper (via the `Makefile`). This ensures that successful commands output only a single line of success, preserving the LLM's context window and saving tokens.
- **Failures Only:** Logs and stdout/stderr are only printed if a command fails, providing you with the exact context needed to fix the issue.

## 4. Extending the System & Local Development
- **The Makefile as Local Entrypoint:** The root `Makefile` must be the well-documented entrypoint for *all* commands needed to do local development (linting, testing, building, running local services).
- **Strict Separation from Deployment:** The `Makefile` is strictly for local development and the agent harness. **Nothing from the `Makefile` should be used in deployed environments.** Deployment is handled entirely by CI/CD.
- **Scripts and Hooks:** All project-related scripts must go through the root `Makefile` and `scripts/` directory. 
- When introducing a new linter, test suite, or convention, **add it to the pre-commit hook system** to enforce it automatically across the lifetime of the project.
