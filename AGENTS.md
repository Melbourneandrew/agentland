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

## 4. Universal Agent Standards & Documentation Separation
- **Universal `.agents/` Directory:** To keep the repository tool-agnostic, we strictly use the `.agents/` standard. Tool-specific directories like `.gemini/`, `.cursor/`, or `.aider/` are explicitly forbidden and blocked by CI.
- **`lat.md/` (Codebase Conventions):** This bidirectional knowledge graph is EXCLUSIVELY for storing our technical conventions, architectural patterns, and structural rules (e.g., how we route, how we test, how we talk to the DB). Agents should reference these pages for the rules of the repo.
- **Requirements & Blueprints (Specifications):** These define *what* to build for a specific feature. They are the inputs to the Software Factory. `lat.md` is NOT for feature specifications.
- **`.agents/skills/` (Agent Workflows):** Skills define *how* an agent should operate (e.g., the workflow for reviewing a PR, executing a work order). New skills and rules should be added to trigger agents to look for specific documentation in `lat.md/`.

## 5. Extending the System & Local Development
- **The Makefile as Local Entrypoint:** The root `Makefile` must be the well-documented entrypoint for *all* commands needed to do local development (linting, testing, building, running local services).
- **Strict Separation from Deployment:** The `Makefile` is strictly for local development and the agent harness. **Nothing from the `Makefile` should be used in deployed environments.** Deployment is handled entirely by CI/CD.
- **Scripts and Hooks:** All project-related scripts must go through the root `Makefile` and `scripts/` directory. 
- When introducing a new linter, test suite, or convention, **add it to the pre-commit hook system** to enforce it automatically across the lifetime of the project.
