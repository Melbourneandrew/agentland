# Root Makefile for Agentland
#
# ⚠️ CRITICAL INSTRUCTION ⚠️
# This Makefile is the WELL-DOCUMENTED ENTRYPOINT for ALL local development commands.
# It is EXCLUSIVELY for local development, testing, and agent harness execution.
# DO NOT use anything from this Makefile in deployed environments.
# Deployment is handled entirely via CI/CD pipelines.
#
# All project-related scripts and checks should go through here.
# We utilize scripts/quiet-run.sh to keep LLM context token usage down on successful runs.

.PHONY: help check test build lint docs docs-build gemini-resume gemini-main gemini-ralph

help:
	@echo "Available commands:"
	@echo "  make check          - Run all linters and tests via the token-efficient pre-commit hook"
	@echo "  make lint           - Run only linters"
	@echo "  make test           - Run only tests"
	@echo "  make build          - Run all builds (including docs)"
	@echo "  make docs           - Start the local VitePress documentation server"
	@echo "  make docs-build     - Build the documentation silently"
	@echo "  make gemini-main    - Resume the main Gemini CLI session for this repository"
	@echo "  make gemini-resume  - Alias for gemini-main"
	@echo "  make gemini-ralph   - Start the autonomous Gemini Ralph adversarial work order loop"

# As the project grows, add specific lint/test/build tools here, wrapping them in quiet-run.sh
# Example: ./scripts/quiet-run.sh "ESLint" npx eslint .

gemini-main:
	gemini --resume a256123f-292c-4957-aa86-bdc3950f2d24 --yolo

gemini-resume: gemini-main

gemini-ralph:
	@echo "Starting the Gemini Ralph Loop..."
	./scripts/gemini-ralph/gemini-ralph.sh

lint:
	@./scripts/quiet-run.sh "Basic syntax check" bash -n scripts/*.sh
	@./scripts/quiet-run.sh "Lat.md Check" npx lat.md check

test:
	@./scripts/quiet-run.sh "Mock Test Suite" true

build: docs-build
	@./scripts/quiet-run.sh "Mock Build" true

docs:
	@echo "Starting local VitePress server at http://localhost:5173..."
	@npm run docs:dev

docs-build:
	@./scripts/quiet-run.sh "VitePress Docs Build" npm run docs:build

# Run everything as part of a pre-commit or CI check
check: lint test build
	@echo "✅ All checks passed successfully."

