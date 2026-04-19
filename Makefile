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

.PHONY: help check test build lint docs docs-build

help:
	@echo "Available commands:"
	@echo "  make check      - Run all linters and tests via the token-efficient pre-commit hook"
	@echo "  make lint       - Run only linters"
	@echo "  make test       - Run only tests"
	@echo "  make build      - Run all builds (including docs)"
	@echo "  make docs       - Start the local VitePress documentation server"
	@echo "  make docs-build - Build the documentation silently"

# As the project grows, add specific lint/test/build tools here, wrapping them in quiet-run.sh
# Example: ./scripts/quiet-run.sh "ESLint" npx eslint .

lint:
	@./scripts/quiet-run.sh "Basic syntax check" bash -n scripts/*.sh

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

