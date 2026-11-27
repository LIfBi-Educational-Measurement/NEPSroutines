# NEPSroutines Roadmap 2027

Overview of the releases planned up to the end of July 2027; everything after
that is to be decided later. The work is split into dated work packages (WP),
planned month by month, so it is spread out rather than done just before a
release. All dates are target dates (Fridays for work packages). If a work
package slips, this roadmap is updated. Issue status lives in the milestones
on [GitHub](https://github.com/LIfBi-Educational-Measurement/NEPSroutines/issues);
the release dates below are mirrored onto the milestone due dates.
Issues are referenced as `#n`.

Base state: v1.3.0 released; milestones v1.3.1, v1.3.2 and v1.4.0 exist.

Every release ends with a release window: code freeze, then the
[release checklist](94_release_checklist.md), then tag and GitHub release.
A work package is done when its PRs are merged into `main`.

| Release | Type  | Content       | Code freeze | Release date |
|---------|-------|---------------|-------------|--------------|
| v1.3.1  | patch | WP 1.1        | 2027-01-15  | 2027-01-29   |
| v1.3.2  | patch | WP 1.2, 1.3   | 2027-03-05  | 2027-03-19   |
| v1.4.0  | minor | WP 2.1 to 2.4 | 2027-07-16  | 2027-07-30   |

| Period              | Work                                              | Due        |
|---------------------|---------------------------------------------------|------------|
| Dec 2026 – early Jan| Decisions (see below)                             | 2027-01-08 |
| Dec 2026 – mid Jan  | WP 1.1 report output correctness                  | 2027-01-15 |
| mid Jan – end Jan   | v1.3.1 release window                             | 2027-01-29 |
| mid Jan – mid Feb   | WP 1.2 silent failures, input validation, DIF     | 2027-02-12 |
| mid Feb – early Mar | WP 1.3 docs and housekeeping                      | 2027-03-05 |
| early Mar – mid Mar | v1.3.2 release window                             | 2027-03-19 |
| Mar – mid Apr       | WP 2.1 fixtures and test health                   | 2027-04-16 |
| mid Apr – late May  | WP 2.2 pipeline tests                             | 2027-05-21 |
| late May – mid Jun  | WP 2.4 data preparation and validation            | 2027-06-11 |
| late May – mid Jun  | WP 2.3a Wright map (parallel to WP 2.4)           | 2027-06-18 |
| late Jun – early Jul| WP 2.3b plot output and small additions           | 2027-07-09 |
| mid Jul – end Jul   | v1.4.0 release window                             | 2027-07-30 |

**Patch releases.** A work package gets its own patch release when it ships
bug fixes users benefit from and contains no new features. Work packages that
change only tests, or that add features, do not. Until the pipeline tests
(WP 2.2) exist, each release needs the manual result comparison, so patch
releases are bundled rather than cut after every work package (v1.3.1 is
the exception, because its report fixes are urgent). From v1.4.0
on, the pipeline tests make patch releases cheap, and fixes can ship when
they are ready instead of waiting for the next minor release. Patch releases
use the shorter patch scope of the
[release checklist](94_release_checklist.md).

## Working mode

Most of the coding is done by agents, and a maintainer reviews every PR. The
plan is therefore limited by review time and by decisions, not by coding time.

- One issue per PR. Small fixes in the same work package may share one PR.
- Before a PR goes to review, the agent runs `devtools::test()`,
  `devtools::check()` and, once it exists (WP 2.1), the lint check, verifies
  the success criteria against real output, and has the change checked by an
  independent review subagent (see `CLAUDE.md`).
- The PR description says what the reviewer has to check by hand, for example
  a plot comparison or a changed value in a table.
- A PR that regenerates fixtures summarises which values changed, instead of
  leaving the reviewer with binary diffs only.
- A work package is done when its PRs are reviewed and merged, not when the
  code is written.
- Agents never work with real NEPS data or with output computed from it.
  Every run on real NEPS data (the manual comparison up to v1.3.2, the local
  real-data tests from v1.4.0 on) is done by the team.

Review effort is uneven: the pipeline tests (WP 2.2), the regenerated fixtures
(WP 2.1) and the rewrite of `wright_map()` (#112) need the most review
time; most fixes in WP 1.1 and 1.2 are small reviews.

### Logging progress and decisions

- **Decisions are recorded on the issue.** Each decision is posted as a
  comment on its issue with the date, the outcome, who decided and the reason
  in one or two sentences. Whoever implements it finds it there.
- **Open decisions carry the `decision needed` label.** The label comes off
  when the decision comment is posted, so the issue list filtered by that
  label always shows what is still undecided.
- **The roadmap shows only the result.** Each entry in the decision list
  below is marked `open` or `decided <date>`; the reasons stay on the issue.
- **Each work package has a status line:** `planned`, `in progress`,
  `done <date>`, or `moved, new due date <date>`. Earlier dates stay visible
  in the git history of this file.
- **An agent can do the bookkeeping** (decision comments, labels, status
  lines) from what a maintainer tells it. The decisions themselves stay with
  the maintainers, and the updates are reviewed like any other change.

## Decisions (due 2027-01-08)

Settled before coding starts, so no work package waits for them. #96 and
#194 are the exceptions: their design decisions are taken at the start of
WP 2.3b.

- #124 add SK and RS missing types: domain answer (open)
- #129 review `survey_paper.bib` template: domain answer (open)
- #168 author order: decided 2026-11-26 (keep the current order; see issue comment)
- #173 birth-year replacement in `calculate_age`: it changes a default, so
  decide whether it ships in v1.3.2 with a clear `NEWS.md` entry or belongs
  in v1.4.0. It is the least patch-like item in v1.3.2. (open)
- #11 linking: decide whether linking returns to the package as a
  reimplementation (from `dev/linking/linking.R`, with the tests from the
  closed PR #59 as the spec) or stays out of scope. The implementation itself
  comes after July 2027. (open)
- #117: opt-in `device` argument or new default output format (open)
- #74: warning, `strict` parameter, or keep the error (open)
- #96: kernel and bandwidth choice, due at the start of WP 2.3b (open)
- #195: remove the outdated `TblPars()` footnote on percent correct for
  polytomous items, or rewrite it, which changes the table in every report
  with polytomous items (open)
- #194: fixed cut-offs for the aQ3 and rit flags or arguments, due at the
  start of WP 2.3b (open)
- #112: reimplement `wright_map()` directly with ggplot2, or via
  `ShinyItemAnalysis::ggWrightMap` as the issue title says; this decides
  which dependency replaces WrightMap (open)

## v1.3.1 and v1.3.2 (patch: bugs and code health, no API changes)

No systematic test work in these releases; new test infrastructure, fixture
work and pipeline tests are part of v1.4.0. A fix may add a small regression
test for the behaviour it changes. Each fix must still leave
`devtools::test()` green: a fix regenerates only the fixtures it breaks, and
the systematic fixture work follows in WP 2.1.

**WP 1.1: Report output correctness** (due 2027-01-15)

Status: planned

- #131 Wright map footnote hardcodes "Table 5"
- #142 `TblCode()` does not define the Rasch model
- #154 sum-0 cell in `steps_analysis()` ignores `digits`
- #189 `TblDif()` and `TblCode()` misread numbers of 10 or more (found in
  the audit after #154)
- #152 `TblCode()` `tam.fit()` mismatch, plus the "Monte Carlo" wording in
  `vignettes/dimensionality_analyses.Rmd`; regenerating the stale ex2
  fixtures is split out as #179 (WP 2.1)
- #177 printed IRT summary still says "within dichotomous items" for the
  percentage of correct responses, which also covers polytomous items since
  v1.3.0
- Add a `NEWS.md`, with earlier versions taken from the existing GitHub
  release notes. Needed for the v1.3.1 release checklist. Copying the GitHub
  release text from it is part of the proposed `CONTRIBUTING` changes (see
  below), which the admins agree on before v1.3.1.
- Restore the `Date:` field in `DESCRIPTION` (removed in #141) and add the
  missing author to `inst/CITATION`, which lists only four of the five
  authors in `DESCRIPTION`. Without `Date:`, `citation("NEPSroutines")`
  prints no year.

**Proposed changes to `CONTRIBUTING`** (separate PR, due before v1.3.1)

- The release workflow in `CONTRIBUTING.Rmd` and `CONTRIBUTING.md` is
  maintained by the admins. The changes the release checklist relies on are
  proposed in a separate PR for the admins to review: a link to the
  checklist and copying it into the milestone or a release-prep issue, a
  code freeze, adding or updating `Date:` and adding new authors to both
  `DESCRIPTION` and `inst/CITATION` in step 1, and release notes copied from
  `NEWS.md` in step 5. Until it is merged, `CONTRIBUTING.md` applies.

**Release v1.3.1** (2027-01-15 to 2027-01-29)

- Ships the report output fixes from WP 1.1 early, because they affect the
  technical reports users produce now.
- Run the patch scope of the [release checklist](94_release_checklist.md),
  with the manual comparison in `dev/manual_test_scripts/`, run by the team.

**WP 1.2: Silent failures, input validation, DIF** (due 2027-02-12)

Status: planned

- #113 `Import()` `rename` validation
- #136 `prepare_facets()` with negative values
- #160 unnamed `position` vector with grouping in `mvi_analysis()`
- #161 warn when response codes are not covered by `mvs`
- #139 DIF with factor variables

**WP 1.3: Docs and housekeeping** (due 2027-03-05)

Status: planned

- #162 data preparation in the example scripts (j-welling is working on it)
- #185 how to prepare the school variable, in the `prepare_data` vignette
  and the example scripts `dat1` and `dat2` (tgnambs)
- #167 update README
- #124 add SK and RS missing types (as decided)
- #129 fix the `survey_paper.bib` template (as decided)
- #173 birth-year replacement in `calculate_age`, if decided for v1.3.2
- #195 outdated `TblPars()` footnote on percent correct for polytomous
  items, which never prints (as decided; found in the review of #177)

**Release v1.3.2** (2027-03-05 to 2027-03-19)

- Run the patch scope of the [release checklist](94_release_checklist.md).
  Results are still compared manually with `dev/manual_test_scripts/`; this
  is the last planned release that does so.

## v1.4.0 (minor: tests, then non-breaking features)

Non-breaking means:

1. Previously saved results (`.rds`) still load and render. New code
   tolerates objects that lack whatever it adds, with a fallback rather than
   a failure.
2. Printed and console output is unchanged unless the change is deliberate
   and listed in `NEWS.md`; the report template relies on auto-printing.
3. Class vectors are extended, not replaced, so existing `inherits()` and
   `class()` checks in scaling scripts keep passing.
4. Existing exported functions stay exported and keep working.

Tests come first so the feature work is covered by them: WP 2.3 and 2.4 start
once the pipeline tests are in place. WP 2.3a and WP 2.4 then run in parallel:
the plot code and the data-preparation code are separate, so agents can work
on one while the other is in review. Review itself stays sequential: WP 2.4
is reviewed first, because it is smaller and its issues are independent.

**WP 2.1: Fixtures and test health** (due 2027-04-16)

Status: planned

- #158 fixture hash manifest should hash contents, not paths
- #179 regenerate the stale ex2 fixture tables in one pass (split out of #152)
- #165 separate test data from example data
- #159 test the dimension-naming branches of `conduct_dim_analysis()`
- Lint check on every PR: a GitHub Actions workflow runs lintr with only
  `undesirable_function_linter()` (for `browser()`), `absolute_path_linter()`
  and `commented_code_linter()`. Clean up the existing code first so the
  check starts green. Debugging `print()` calls cannot be linted; they are
  part of the docs-sync check in the release checklist.
- Spell check during `R CMD check`: set up with
  `usethis::use_spell_check()`, seed `inst/WORDLIST` with the package's own
  terms (NEPS, WLE, DIF, function names), and keep it report-only so a typo
  does not fail a PR.
- Old-results test: keep a small `.rds` result saved with v1.3.2 as a test
  fixture (from example data) and test that it still loads and renders, so
  "old `.rds` results must still render" is checked automatically.

**WP 2.2: Pipeline tests** (due 2027-05-21)

Status: planned

Automate the manual comparison in `dev/manual_test_scripts/` (A12, A14, B129)
so it no longer has to be run by hand before each release.

- Turn each script into a testthat pipeline test that runs the full chain
  (import, data preparation, scaling, report tables and figures) and compares
  the results with stored reference results from the previous release.
- CI runs the pipeline tests on simulated or example data, which can live in
  the repository.
- Real NEPS data cannot go into the repository or CI, and agents do not work
  with it. Local real-data tests read the data path from an environment
  variable and skip otherwise (`skip_if()`). They run only before a release,
  started by the team. Agents build and check these tests against simulated
  data only.
- Reference results for the real-data tests are computed from NEPS data, so
  they are kept outside the repository, next to the data, and read from the
  same environment-variable path. Only references from simulated or example
  data go into `tests/testthat/fixtures/`.
- Long runs go into a separate GitHub Actions workflow started by hand
  (`workflow_dispatch`) before a release, not into the per-push
  `R-CMD-check.yaml`.
- Update the [release checklist](94_release_checklist.md) to use the
  pipeline tests, and propose the matching change to "Checks and Tests" in
  `CONTRIBUTING.Rmd` (and the knitted `CONTRIBUTING.md`) to the admins in a
  PR.
- If the pipeline tests turn up real bugs, fix them and cut a v1.3.3 patch
  release right after WP 2.2. This works only before WP 2.3 and 2.4 features
  reach `main`, so a release can still be made from `main` without a separate
  release branch. v1.3.3 is compared with the new pipeline tests plus the
  team's real-data run. It also ships the test work of WP 2.1 and 2.2, which
  does not change the package for users. Its two-week release window moves
  WP 2.4 and 2.3a back by two weeks; WP 2.3b keeps its date by dropping #96
  first, and the v1.4.0 dates stay. v1.3.3 then gets its own milestone and a
  row in the tables above.

**WP 2.4: Data preparation and validation** (due 2027-06-11)

Status: planned

- #174 set collapsing rules on part of the sample
- #74 `check_dich()` and all-NA columns in booklet designs
- #178 helper that lists the missing codes found in the data and suggests
  `mvs` and `labels_mvs` from the known NEPS codes (split out of #61; the
  joint format for codes and labels stays in #61)

**WP 2.3a: Wright map** (due 2027-06-18, parallel to WP 2.4)

Status: planned

- #112 reimplement `wright_map()` and drop the WrightMap dependency (approach
  per the decision list)
- #176 set the Wright map size in `irt_analysis()` (do together with #112)

**WP 2.3b: Plot output and small additions** (due 2027-07-09)

Status: planned

- #117 vector graphics output for plots
- #116 add `item` argument to `GetMvi()`
- #169 confirmation messages in validation check functions (moved from
  WP 2.4 to spread the review load)
- #194 printed IRT summary: aQ3 summary and items flagged by aQ3 > .20 or
  rit < .20 (split out of #177)
- #96 opt-in kernel smoothing for empirical ICC curves; first decide the
  kernel and how the bandwidth is chosen, then build it on the reworked plot
  code. If the schedule slips, #96 moves after July 2027 first.

**Release v1.4.0** (2027-07-16 to 2027-07-30)

- Run the full [release checklist](94_release_checklist.md), with the pipeline
  tests from WP 2.2 replacing the manual comparison. The team runs the local
  real-data tests.

## After July 2027 (to be decided)

Not yet planned: releases, versions and dates are decided later. All
restructuring of the package (such as #119) comes after July 2027.

- #119 lightweight S3 class layer for result objects (groundwork for #11 and
  #120)
- #61 joint format for missing codes and labels (the detection helper is #178
  in WP 2.4)
- #11 linking implementation, if the decision brings linking back;
  whether it has to wait for #119 is part of that decision
- #138 sample-size-robust fit indices (needs a methodological decision first)
- #120 automate the full pipeline from scaling to a draft technical report
  (major-version goal, builds on #119)
- Report template: regenerate tables and figures at render time from the
  stored model objects, instead of embedding pre-computed `.xlsx`, `.png` and
  `.tiff` files (no re-fitting). This would remove the kind of fixture drift
  behind #158 and #152, but it changes the shipped template, so it belongs in
  a major version. No issue yet.
- #188 store unrounded numbers in the `.xlsx` output and round once, at
  display time, in the `Tbl*()` functions. This removes double rounding and
  parsing numbers back out of text (worked around in #187 and #190). It
  changes the saved output format, so it needs a decision with the
  co-authors first. Placed here provisionally; it is closely related to the
  report template item above.
