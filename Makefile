# Root Makefile for Agentland
#
# All project-related scripts and checks should go through here.
# We utilize scripts/quiet-run.sh to keep LLM context token usage down on successful runs.

.PHONY: help check test build lint

help:
	@echo "Available commands:"
	@echo "  make check    - Run all linters and tests via the token-efficient pre-commit hook"
	@echo "  make lint     - Run only linters"
	@echo "  make test     - Run only tests"
	@echo "  make build    - Run only builds"

# As the project grows, add specific lint/test/build tools here, wrapping them in quiet-run.sh
# Example: ./scripts/quiet-run.sh "ESLint" npx eslint .

lint:
	@./scripts/quiet-run.sh "Basic syntax check" bash -n scripts/*.sh

test:
	@./scripts/quiet-run.sh "Mock Test Suite" true

build:
	@./scripts/quiet-run.sh "Mock Build" true

# Run everything as part of a pre-commit or CI check
check: lint test build
	@echo "✅ All checks passed successfully."

