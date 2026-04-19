#!/usr/bin/env bash

# Token-efficient command wrapper. 
# Runs a command silently, buffering output.
# Prints a single success line on success.
# Only dumps output on failure.

NAME=$1
shift

# Run the command and capture output (both stdout and stderr)
OUTPUT=$("$@" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ $NAME passed"
else
  echo "❌ $NAME failed:"
  echo "----------------------------------------"
  echo "$OUTPUT"
  echo "----------------------------------------"
  exit $EXIT_CODE
fi
