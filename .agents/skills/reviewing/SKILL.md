---
name: reviewing
description: Use this skill for reviewing and verifying Software Factory documents. It focuses on ensuring alignment between Requirements (FRDs) and Blueprints, verifying that all acceptance criteria have a corresponding technical implementation plan, and adhering to conventions.
---

# Reviewing Skill

As a reviewer within the Software Factory, your primary role is to ensure that the technical plans (Blueprints) completely and accurately align with the functional requests (Requirements). Before any code is written, a rigorous review of these documents is necessary to prevent architectural gaps or missed features.

## Core Responsibilities

1. **Alignment Verification:** 
   - Verify that every user story (`REQ-{PREFIX}-{NNN}`) and acceptance criterion (`AC-{PREFIX}-{NNN}.{N}`) defined in the Feature Requirements Document (FRD) has a corresponding implementation detail in the linked Feature Blueprint.
   - Ensure that the proposed technical solution does not introduce scope creep (i.e., adding features not specified in the requirements).

2. **Blueprint Validation:**
   - Confirm that Blueprints use the correct mention types: `#ComponentName` for components, `ElementName` for data shapes/contracts, and `@SystemEntity` for documents and platform entities.
   - Check that the blueprint adequately specifies components, contracts, models, and relationships across runtime boundaries.

3. **Requirements Validation:**
   - Ensure FRDs are structured correctly with clear user stories and testable acceptance criteria.
   - For Overview Requirements, confirm they establish clear product-wide context (Business Problem, Current State, Personas).

4. **Frontend Design Verification:**
   - If reviewing frontend code or visual components, verify adherence to the agreed aesthetic direction and the `frontend-design` skill guidelines.
   - Check for production-grade design qualities: appropriate and distinct typography, cohesive color schemes, intentional layout and motion, and the explicit avoidance of generic "AI slop" or cookie-cutter design patterns.

5. **Harness Engineering & Pre-commit Automation:**
   - Verify that updates to pre-commit hooks, tests, and project `Makefile` checks are proposed and made whenever new functionality is introduced.
   - According to the `harness-engineering` skill, ensure there is a matching contribution to the repo's harness that allows the agent to run, exercise, and audit the new functionality completely.
   - Ensure new conventions, build steps, tests, and linters are automatically enforced by extending the token-efficient hook system (`.pre-commit-config.yaml` / `Makefile`), preventing regressions and reducing manual verification steps.

6. **Living Documentation (`lat.md`):**
   - Ensure new architectural choices are documented in `lat.md/`.
   - Verify the PR passes `npx lat.md check`.
   - Ensure the new source code uses backlink comments (e.g., `// @lat: [[section]]`) pointing back to the documentation.

## Review Process

When asked to review a feature or document:
1. **Read the Requirement (FRD):** Understand what needs to be built. Pay close attention to the Acceptance Criteria.
2. **Read the Blueprint:** Understand how it is proposed to be built.
3. **Cross-Reference:** Map each Acceptance Criterion to a specific component or logic block in the Blueprint. 
4. **Identify Gaps:** Highlight any missing ACs in the Blueprint, incorrect assumptions, or violations of Software Factory conventions.
5. **Report Findings:** Provide a structured summary of your review. If everything aligns, approve the documents for the next phase (Work Orders). If there are gaps, provide specific, actionable feedback to the author/architect.
