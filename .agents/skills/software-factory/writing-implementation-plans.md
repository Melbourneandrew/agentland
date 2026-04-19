# Writing Implementation Plans

Write the implementation plan immediately after Phase 1 (context gathering). The blueprint already defines the component architecture — the implementation plan fills in the language-specific and syntactic details that support that architecture.

## Prerequisites (Required)

Before writing the plan:

1. Read the applicable rules and skills for the stack you will modify (backend/frontend, naming, architecture, and relevant implementation skills).
2. Explore analogous existing code in the modules you expect to touch.
3. Run a reuse-first discovery pass (use subagents for search) to find existing code you can:
   - reuse directly,
   - extract into a shared/common component or utility and then reuse, or
   - use as a proven pattern to follow.

## What to Include

1. **File and package structure** — list every file you will create or modify, and where it lives. Prefer reusing or extending existing files/components when they already satisfy the requirement. Follow the code-splitting and package structure guidance in `.cursor/skills/review/architecture-and-conventions.md` (this will be checked during review).

2. **Component and method signatures** — define the public interfaces before writing the bodies. For each new class, service, hook, or component, write out the signature (name, parameters, return type). This locks in the contract boundaries from the blueprint at the code level.

3. **Control flow** — describe the call chain: which component calls which, in what order, with what data. This is the prose from the blueprint's relationship paragraphs translated into concrete function calls.

4. **Steps** — break the work into ordered steps. Each step should produce a compilable intermediate state. Note which steps can run in parallel (touch different files, no dependency between them).

## Guidelines For The Implementation Plan

- Prefer reuse over building from scratch; when requirements only partially overlap existing code, extract reusable components/utilities first, then compose the feature from those shared pieces.
- Keep plans concrete and resumable so a follow-on agent loop can continue without re-planning.
- Ensure planned file placement, naming, and layer boundaries follow the applicable rules and skills for the stack being modified.
- The plan should be high quality and follow architecture conventions that match the rest of the codebase.

## Keeping It Current

If implementation reveals the plan needs to change, update the plan before proceeding. The plan and the implementation should stay in sync.
