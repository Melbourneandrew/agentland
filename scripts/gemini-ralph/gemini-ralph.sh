#!/usr/bin/env bash

set -euo pipefail

EXTRA_PROMPT="${1:-"No additional prompt provided."}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RALPH_ROOT="${REPO_ROOT}/scripts/gemini-ralph"
RUN_ID="$(date -u +"%Y%m%d-%H%M%S")"
SHIFT_DIR="${RALPH_ROOT}/shifts/shift-${RUN_ID}"
SCHEDULE_FILE="${SHIFT_DIR}/schedule.json"
SHIFT_MANAGER="${RALPH_ROOT}/shift-manager.js"

GEMINI_CMD="${GEMINI_CMD:-gemini}"
GEMINI_MODEL="${GEMINI_MODEL:-gemini-3.1-pro-preview}"
GEMINI_APPROVAL_MODE="${GEMINI_APPROVAL_MODE:-yolo}"

log() {
  printf '[%s] %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$1" | tee -a "${SHIFT_DIR}/runner.log"
}

mkdir -p "${SHIFT_DIR}"
node "${SHIFT_MANAGER}" init "${SCHEDULE_FILE}"

log "Starting Gemini Ralph Shift Setup (Run: ${RUN_ID})"

# 1. Spawning Scheduler Agent
log "=> Spawning Scheduler Agent to build the schedule..."
TMP_SCHEDULER_PROMPT="${SHIFT_DIR}/prompt-scheduler.md"
sed -e "s|{SCHEDULE_FILE}|${SCHEDULE_FILE}|g" \
    -e "s|{EXTRA_PROMPT}|${EXTRA_PROMPT}|g" \
    "${RALPH_ROOT}/prompts/scheduler.md" > "${TMP_SCHEDULER_PROMPT}"

(
  cd "${REPO_ROOT}"
  "${GEMINI_CMD}" \
    --model "${GEMINI_MODEL}" \
    --approval-mode="${GEMINI_APPROVAL_MODE}" \
    < "${TMP_SCHEDULER_PROMPT}"
) | tee -a "${SHIFT_DIR}/scheduler.log"

# 2. Reading the Schedule
PENDING_WOS=$(node "${SHIFT_MANAGER}" list-pending "${SCHEDULE_FILE}" || echo "")

if [[ -z "$PENDING_WOS" ]]; then
  log "No pending work orders found in ${SCHEDULE_FILE}. Exiting."
  exit 0
fi

# 3. Executing the Shifts Loop
for WO in $PENDING_WOS; do
  log "====================================================="
  log "=> Starting Shift for Work Order: ${WO}"
  log "====================================================="

  # Phase A: Worker Agent
  TMP_WORKER_PROMPT="${SHIFT_DIR}/prompt-worker-${WO}.md"
  sed "s|{WORK_ORDER}|${WO}|g" "${RALPH_ROOT}/prompts/worker.md" > "${TMP_WORKER_PROMPT}"
  
  log "--> Spawning Worker Agent..."
  (
    cd "${REPO_ROOT}"
    "${GEMINI_CMD}" \
      --model "${GEMINI_MODEL}" \
      --approval-mode="${GEMINI_APPROVAL_MODE}" \
      < "${TMP_WORKER_PROMPT}"
  ) | tee -a "${SHIFT_DIR}/worker-${WO}.log"

  # Phase B: Reviewer Agent
  TMP_REVIEWER_PROMPT="${SHIFT_DIR}/prompt-reviewer-${WO}.md"
  sed "s|{WORK_ORDER}|${WO}|g" "${RALPH_ROOT}/prompts/reviewer.md" > "${TMP_REVIEWER_PROMPT}"
  
  log "--> Spawning Reviewer Agent..."
  (
    cd "${REPO_ROOT}"
    "${GEMINI_CMD}" \
      --model "${GEMINI_MODEL}" \
      --approval-mode="${GEMINI_APPROVAL_MODE}" \
      < "${TMP_REVIEWER_PROMPT}"
  ) | tee -a "${SHIFT_DIR}/reviewer-${WO}.log"

  # Complete Shift
  log "--> Shift for ${WO} completed. Marking as done..."
  node "${SHIFT_MANAGER}" complete "${SCHEDULE_FILE}" "${WO}"
done

log "=> Gemini Ralph Run ${RUN_ID} Completed."
