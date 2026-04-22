#!/usr/bin/env bash

set -euo pipefail

# These agent-specific directories are forbidden to keep the repository tool-agnostic
# and universally rely on the `.agents/` standard.
FORBIDDEN=(".gemini" ".cursor" ".aider" ".claude" ".cline")
FOUND=0

for dir in "${FORBIDDEN[@]}"; do
  if [ -d "$dir" ]; then
    echo "❌ Forbidden agent-specific directory found: $dir"
    echo "Please move any context into .agents/, lat.md/, or root AGENTS.md, then delete $dir."
    FOUND=1
  fi
done

if [ "$FOUND" -eq 1 ]; then
  exit 1
fi
