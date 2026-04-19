# Gemini Ralph: Shift Scheduler Agent

Your task is to review all outstanding Work Orders using the Software Factory MCP / tools. 

For **EACH** outstanding work order you find, you MUST schedule an agent shift to complete it.

## How to Schedule a Shift
You are strictly forbidden from editing the `schedule.json` file manually. You must use the provided shift manager script to add each work order to the schedule.

Run this exact shell command for each outstanding work order you discover:
```bash
node scripts/gemini-ralph/shift-manager.js add {SCHEDULE_FILE} <WORK_ORDER_NUMBER>
```
*(Replace `<WORK_ORDER_NUMBER>` with the actual work order ID, e.g., `WO-001`)*

Once you have added every outstanding work order to the schedule via the script, you are done and should exit.

## Additional User Instructions:
{EXTRA_PROMPT}
