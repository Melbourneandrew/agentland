---
name: testing
description: Use this skill when executing the test plan for a work order or verifying behavior against accepted requirements. It covers programmatic tests (unit, integration) and browser-based testing using Chrome MCP.
---

# Testing Skill

This skill provides guidelines and strategies for testing the application at various levels. Whenever testing new functionality, protecting against mistakes, or verifying bug fixes, use the appropriate sub-skill defined in the subdirectories.

As developers introduce new conventions or patterns, this skill should be updated to enforce those new standards.

## Testing Dimensions

The testing approach is divided into multiple strategies, each with its own directory containing specific conventions:

### 1. Programmatic Testing
- **Unit Testing (`unit/`):** For isolated tests of individual components, functions, or classes.
- **Integration Testing (`integration/`):** For testing the interaction between multiple components or systems (e.g., API routes, database operations).

### 2. E2E and UI Testing
- **Browser Use / Chrome MCP (`browser-use/`):** For testing actual user flows in the browser. Whenever appropriate, we leverage Chrome MCP for computer-use style testing to navigate the UI, click buttons, and visually verify that the application matches the requirements and designs.

## Updating the Skill
Whenever you introduce new functionality, fix a complex bug, or establish a new testing convention, **you must add or update the relevant testing guidelines** in this directory to protect against future regressions.
