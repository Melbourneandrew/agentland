# Agent Harness

The Agent Harness defines the environment, constraints, and feedback loops that allow AI agents to operate autonomously and reliably at scale within Agentland. 

## Core Philosophy

**"Humans Steer, Agents Execute."**

An AI agent's performance is determined by its surrounding environment (the harness) rather than just the underlying model. The harness provides the structural "track" that channels the agent's power into useful, stable work without human intervention.

## Harness Components

### The Gemini Ralph Loop
The adversarial orchestration system located at `scripts/gemini-ralph/gemini-ralph.sh`. 
It surveys outstanding Work Orders and spawns pairs of agents to execute them:
1. **Worker Agent**: Completes the implementation and opens a Pull Request.
2. **Reviewer Agent**: Audits the PR against architectural blueprints and test requirements.

### Token-Efficient Automation
To preserve the LLM's context window, all local development runs through the root `Makefile`. Commands are wrapped in `scripts/quiet-run.sh`, which suppresses output on success and only dumps verbose logs on failure. This ensures agents aren't blinded by walls of successful test output.

### Pre-commit Constraints (Hard Failures)
All conventions, tests, and linters must be added to `.pre-commit-config.yaml`. This creates a "Hard Failure" constraint—if an agent writes code that violates the harness, the commit fails, and the exact error is injected back into the agent's context for immediate repair.

### External Provisioning & Services
The harness enforces strict rules for interacting with third-party infrastructure:
- **Cloudflare**: Provisioned using `wrangler.toml` and tested locally via `wrangler dev` native emulators (D1, R2, KV) to allow completely offline execution.
- **Stripe**: Provisioned via the Stripe CLI using Stripe Projects (`stripe projects`).
- **Identity & OAuth**: External OAuth is strictly bypassed during local development. A "Human Handoff" protocol is used to securely inject production credentials via CLI prompts without requiring the agent to navigate captchas or UI logins.

## Extending the Harness

Writing code is only half the job. When an agent or human adds new functionality, they **must** provide a matching contribution to the repo's harness. This includes:
- Verification scripts or tests.
- CI/CD workflow updates.
- Emulators or local bypasses to ensure the feature can be tested entirely offline.
