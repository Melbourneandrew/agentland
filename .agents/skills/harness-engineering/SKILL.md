---
name: harness-engineering
description: Use this skill when building or evaluating the tools, tests, and conventions that allow AI agents to autonomously and reliably work on the codebase.
---

# Harness Engineering

This codebase is **entirely agent-written and operated.** To succeed, human engineers must focus on "Harness Engineering"—building the environment, constraints, and feedback loops that allow AI agents to execute predictably at scale.

## Core Principle: "Agents Execute, Humans Steer"

Every time new functionality is contributed, it is not enough to just write the code. You must also provide a **matching contribution to the repo's harness** that allows the agent to:
1. **Run the functionality completely.**
2. **Exercise and verify the functionality automatically.**
3. **Audit for regressions in the future.**

Without a harness, agents operate blindly. The harness is the infrastructure (tests, linters, pre-commit hooks, simulation scripts, observability) that channels the agent's work and instantly alerts it when it breaks a rule.

## Harness Requirements for New Contributions

Whenever a feature is implemented, the agent (or human) must also implement the following harness components:

### 1. Verification Scripts (The "Exercise" Loop)
If you build an API, you must build a script or test suite that allows the agent to `curl` the API and verify the output. If you build a UI, you must update the `browser-use` tests so the agent can load the page and verify its state.
- Keep tests fast and deterministic.
- Use `scripts/quiet-run.sh` wrappers so that success is silent (saving context window tokens) and failure is loud (providing exact stack traces for immediate repair).

### 2. Architectural Constraints (The "Audit" Loop)
- **Pre-commit Hooks:** Any new convention (e.g., a specific folder structure, a ban on certain imports) should be enforced via standard `.pre-commit-config.yaml` or project `Makefile`.
- **Baseline Quality:** For **every app/service** added to the project (clients, backend services), you **must** configure linting, type-checking, and code formatting. These must run locally via pre-commit (`make check`) AND be verified in CI.
- **Continuous Integration (GitHub Actions):** Whenever new kinds of tests, checks, or services are added, you must set up or update the corresponding GitHub Actions workflows to ensure these quality gates are continuously enforced on all pull requests.
- **Hard Failures:** If an agent violates a rule, the CI system must block it. The error must be formatted so it can be injected directly back into the agent's context for fixing.

### 3. Agent Legibility (The "Context" Loop)
Ensure that the codebase is readable for an LLM. Use high-level maps (like `AGENTS.md`) instead of sprawling documentation. Ensure that dependencies (like databases and storage) can be run entirely offline via `wrangler dev` local emulators (e.g., D1, R2, KV) so the agent never needs external credentials to exercise the system.

### 4. External Services & Provisioning
When adding third-party services (Cloudflare, Stripe, Google OAuth), agents must follow these provisioning rules:
- **Cloudflare (Infrastructure):** Use the `wrangler` CLI. Infrastructure is defined in `wrangler.toml`. Agents can use `wrangler tail` for monitoring and `wrangler dev` for local simulation. Actual deployment happens in CI/CD.
- **Stripe (Payments & Billing):** Use the `stripe` CLI. Agents can use it to provision isolated environments via Stripe Projects (`stripe projects`), forward webhooks locally (`stripe listen`), and monitor logs (`stripe logs tail`).
- **The "Human Handoff" Protocol (Google OAuth, etc.):** For services that require UI-based setup, domain verification, or anti-bot protected consoles (like creating a Google Cloud OAuth Client ID), the agent MUST NOT attempt to automate the browser. 
  **CRITICAL FOR IDENTITY:** OAuth and external Identity Providers (IdP) are strictly for **deployed environments only**. Local development must implement a secure, configurable bypass (e.g., local mock tokens or a development-only admin login route) so the system can be exercised offline without external internet calls.
  When it is time to set up the real IdP for deployment:
  1. The agent writes a concise, step-by-step markdown guide (e.g., `infra/google-oauth-setup.md`) with exact URLs for the human to follow.
  2. The agent creates a local script (e.g., `make setup-secrets`) that prompts the human to paste the resulting credentials (e.g., `CLIENT_ID` and `CLIENT_SECRET`).
  3. The script automatically uses `wrangler secret put` to provision them in Cloudflare CI/CD securely.

### 5. Living Documentation & Knowledge Graph (`lat.md/`)
The project's public-facing and architectural documentation is stored in the `lat.md/` directory and deployed via VitePress. **This is not just a folder of markdown files; it is a bidirectional knowledge graph powered by the `lat.md` CLI.**

**Documentation Separation of Concerns:**
To maintain a scalable and self-improving harness, we strictly separate *what* we build, *how* we operate, and our *codebase conventions*:
- **`lat.md/` (Codebase Conventions):** This graph is EXCLUSIVELY for storing codebase conventions, architectural patterns, and structural rules (e.g., how to build a component, how routing works, how to use the DB). Agents should look here to learn the rules of the repo.
- **Requirements & Blueprints (Specifications):** These define *what* to build for a specific feature. They are the inputs to the Software Factory. `lat.md` is NOT for specifications.
- **`.agents/skills/` (Agent Workflows):** Skills define *how* the agent should operate (e.g., how to run a test, how to review a PR, how to use the software factory). Skills and rules can be added or updated to trigger the agent to go look for specific documentation in `lat.md/`.

- **Always Consult the Graph:** When starting a task, agents should read the relevant `lat.md` documentation to understand architectural constraints before writing code.
- **Link Your Code (Backlinks):** When you implement a feature described in `lat.md`, you MUST add a backlink comment in the source code (e.g., `// @lat: [[harness#Agent Harness]]` for JS/TS, or `# @lat: ...` for Python). This proves the documentation is implemented.
- **Link Your Docs:** Use Wiki-style links `[[filename#Section]]` when referencing other parts of the documentation.
- **Formatting Rules:** `lat.md` strictly enforces formatting. Every section must have a leading paragraph of ≤250 characters summarizing the section. 
- **Enforcement:** The `lat.md check` command is strictly enforced in `make check` (our pre-commit and CI hook). If you break a link or fail to conform to the markdown rules, the commit will be blocked. You MUST run `npx lat.md check` to verify your documentation and code changes.
