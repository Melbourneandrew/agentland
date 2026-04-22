# Agentland: Project-Specific Instructions for Gemini CLI

You are working in the Agentland repository. This is an agent-operated codebase managed by a strict "Harness Engineering" philosophy. 

## Mandatory Directives

1. **Living Documentation (`lat.md`)**:
   - This project uses `lat.md` as a bidirectional knowledge graph.
   - You MUST consult the `lat.md/` directory for architectural context before beginning implementation.
   - You MUST run `npx lat.md check` using the `run_shell_command` tool after modifying any documentation or source code to ensure referential integrity.
   - All newly added components, conventions, or requirements must be documented in the `lat.md/` graph following its strict structure (headings and leading paragraphs ≤250 chars).

2. **Harness Compliance**:
   - Do not use `docker-compose` for backing services. We rely exclusively on Cloudflare's `wrangler dev` (which emulates D1, R2, and KV locally).
   - Use the token-efficient `Makefile` (e.g., `make check`, `make lint`) for testing and validation.
   - Any external identity providers (like Google OAuth) must be bypassed locally, and setup instructions must follow the "Human Handoff" protocol documented in `lat.md/harness.md`.

3. **Skills Integration**:
   - If asked to execute a work order, activate the `software-factory` skill.
   - If asked to review a PR, activate the `reviewing` skill.
   - If writing new UI code, activate the `frontend-design` skill and strictly adhere to the Brutalist / Soft Natural palette defined in its `STYLE.md`.

*Note: These instructions override general defaults. You must adhere to them unconditionally.*
