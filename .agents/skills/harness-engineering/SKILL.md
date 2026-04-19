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
- **Hard Failures:** If an agent violates a rule, the CI system must block it. The error must be formatted so it can be injected directly back into the agent's context for fixing.

### 3. Agent Legibility (The "Context" Loop)
Ensure that the codebase is readable for an LLM. Use high-level maps (like `AGENTS.md`) instead of sprawling documentation. Ensure that S3/DB dependencies can be run entirely offline via `docker-compose.agentland-services.yaml` so the agent never needs external credentials to exercise the system.

### 4. Living Documentation (`lat.md/`)
The project's public-facing and architectural documentation is stored in the `lat.md/` directory and deployed via VitePress.
- **Document New Contributions:** Every new feature, service, or architectural component must be documented here.
- **Document Conventions:** Any new codebase conventions, patterns, or harness engineering rules must be clearly explained so future agents can learn them.
- **Bonus (Connections to Blueprints):** Whenever possible, explicitly link these documentation pages directly to the Software Factory Blueprints (`@BlueprintName`) that originated the architecture. This connects the original "plan" to the final "documentation."
