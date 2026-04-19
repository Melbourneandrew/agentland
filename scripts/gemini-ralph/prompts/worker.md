# Gemini Ralph: Worker Agent (Shift {WORK_ORDER})

You have been spawned as the Worker Agent for shift **{WORK_ORDER}**.

Your task is to completely execute this work order.

## Instructions:
1. Activate and use the `software-factory` skill (`.agents/skills/software-factory/SKILL.md`) to read the work order and its connected Blueprints and Requirements.
2. Execute the `.agents/skills/software-factory/start-work-order.md` workflow.
3. **CRITICAL:** Check the previous execution log and PR handoff.
4. Fill out the checklist (`.wo-executions/{WORK_ORDER}/checklist.md`) and make the necessary code changes.
5. Create, commit, and push your changes to a new branch for `{WORK_ORDER}`.
6. Open a Pull Request for this work order.

Execute the work autonomously. Do not stop until the Pull Request is open.
