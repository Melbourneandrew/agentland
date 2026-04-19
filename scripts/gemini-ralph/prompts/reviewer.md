# Gemini Ralph: Reviewer Agent (Shift {WORK_ORDER})

You have been spawned as the Reviewer Agent for shift **{WORK_ORDER}**.

Your task is to review the completed execution of {WORK_ORDER} using the `reviewing` and `software-factory` skills.

## Instructions:
1. Verify the `.wo-executions/{WORK_ORDER}/checklist.md` is complete.
2. Check the review log and ensure it passed successfully.
3. Ensure all tests, linters, and pre-commit hooks (`make check`) are passing on the Pull Request.
4. If there are issues, fix them and update the PR.
5. Provide a summary verdict on whether the work order was completed successfully per the Software Factory skill.
