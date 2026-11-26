# CLAUDE.md

## Workflow

Always work on a git worktree, not the main repository.

1. **Spec** - Understand the task and read relevant code first. Write down
   the success criteria: what must be true in the actual output (rendered
   report, printed table, image, returned object) for the change to work,
   not just in the code.
2. **Plan** - Use plan mode to design the approach
3. **Draft** - Implement the changes
4. **Simplify** - Review and simplify the solution
5. **Update Tests** - Add or update tests for changed functionality
6. **Update Docs** - Update roxygen comments and `dev/` documentation
   - User-facing changes (new/renamed/removed function arguments, changed
     defaults or output) must also be carried over into the affected
     vignette(s) in `vignettes/`
7. **Test** - Run `devtools::test()`
8. **Verify behaviour** - Check each success criterion against real output
   (run the generated code, render, inspect the result). Use only example or
   simulated data, such as `tests/testthat/fixtures/` or the package's
   example data, never real NEPS data. Not every check needs to become a
   test. Report which criteria were verified and which were not.
9. **Check** - Run `devtools::check(args = "--no-tests")` (skip tests since already run)
   - Ignorable pre-existing warnings: vignette warnings (Pandoc not installed locally); timestamp NOTE
10. **Review** - An independent subagent reviews the change. Give it the
    task, the success criteria and the diff, not your own conclusions. It
    checks:
    - Success criteria: met, re-checked independently where feasible
    - Correctness: bugs, edge cases, other places with the same problem
    - Simplicity: no unnecessary verbosity, duplication or
      over-engineering; reasonably efficient
    - Safety: no secrets, absolute paths or real NEPS data
11. **Commit & PR** - Commit changes and create a pull request. The PR
    description lists the success criteria and how each was verified.
12. **Learnings** - If problems occurred, note mistakes to avoid in
    `dev/01_claude_reference.md`

## Quick Commands

```bash
Rscript -e "devtools::test()"                       # Run tests
Rscript -e "devtools::check(args = '--no-tests')"   # R CMD check (skip tests)
Rscript -e "devtools::document()"                   # Regenerate docs
Rscript -e "devtools::load_all()"                   # Load for testing
```

## Reference

See `dev/01_claude_reference.md` for:
- Key source files and their purposes
- Core functions
- Development conventions
- Dependencies

See `dev/93_roadmap_2027.md` for the roadmap (releases, work packages,
working mode, decisions) and `dev/94_release_checklist.md` for the checks
before every release. `dev/91_improvement_plan.md` is the earlier
improvement plan.
