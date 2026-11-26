# NEPSroutines Roadmap 2027

Overview of what each release should cover. One release per quarter for Q1
and Q2; everything after that is to be decided later. Each
quarter is split into dated work packages (WP) so the work is spread over the
quarter rather than done at the end. All dates are target dates (Fridays for
work packages). If a work package slips, this roadmap is updated. Issue status
lives in the milestones on
[GitHub](https://github.com/LIfBi-Educational-Measurement/NEPSroutines/issues);
the release dates below should be mirrored onto the milestone due dates.
Issues are referenced as `#n`.

Base state: v1.3.0 released; milestones v1.3.1 and v1.4.0 exist.

Every release ends with a release window: code freeze, then the
[release checklist](94_release_checklist.md), then tag and GitHub release.
A work package is done when its PRs are merged into `main`.

| Release | Quarter | Code freeze | Release date |
|---------|---------|-------------|--------------|
| v1.3.1  | Q1 2027 | 2027-03-19  | 2027-03-31   |
| v1.4.0  | Q2 2027 | 2027-06-18  | 2027-06-30   |

## Q1 2027: v1.3.1 (patch: bugs and code health, no API changes)

No test work in this release; tests, fixtures and pipeline tests are Q2. Each
fix must still leave `devtools::test()` green: a fix regenerates only the
fixtures it breaks, and the systematic fixture work follows in WP 2.1.

**WP 1.1: Report output correctness** (due 2027-01-29)
- #131 Wright map footnote hardcodes "Table 5"
- #142 `TblCode()` does not define the Rasch model
- #154 sum-0 cell in `steps_analysis()` ignores `digits`
- #152 (fix part) `TblCode()` `tam.fit()` mismatch; regenerating the stale
  ex2 fixtures is WP 2.1

**WP 1.2: Silent failures, input validation, DIF** (due 2027-02-26)
- #113 `Import()` `rename` validation
- #136 `prepare_facets()` with negative values
- #160 unnamed `position` vector with grouping in `mvi_analysis()`
- #161 warn when response codes are not covered by `mvs`
- #139 DIF with factor variables

**WP 1.3: Docs, housekeeping, open decisions** (due 2027-03-12)
- #162 data preparation in the example scripts
- #167 update README
- #124 add SK and RS missing types (needs a domain answer first)
- #129 review `survey_paper.bib` template (needs a domain answer first)
- #168 author order (team decision)
- #173 remove automatic birth-year replacement in `calculate_age`: it changes
  a default, so decide whether it ships here with a release-notes entry or
  belongs in v1.4.0.
- Settle the v1.4.0 decisions listed under Q2 so WP 2.3 and 2.4 can start.

**Release window** (2027-03-19 to 2027-03-31)
- Run the [release checklist](94_release_checklist.md). Results are still
  compared manually with `dev/manual_test_scripts/`; this is the last release
  that does so.

## Q2 2027: v1.4.0 (minor: tests, then non-breaking groundwork)

Old `.rds` results must still render; existing exported functions keep working.
Tests come first so the feature work in WP 2.3 and 2.4 is covered by them.

**WP 2.1: Fixtures and test health** (due 2027-04-16)
- #158 fixture hash manifest should hash contents, not paths
- #152 (fixture part) regenerate stale ex2 fixtures
- #165 separate test data from example data
- #159 test the dimension-naming branches of `conduct_dim_analysis()`

**WP 2.2: Pipeline tests** (due 2027-05-07)

Automate the manual comparison in `dev/manual_test_scripts/` (A12, A14, B129)
so it no longer has to be run by hand before each release.
- Turn each script into a testthat pipeline test that runs the full chain
  (import, data preparation, scaling, report tables and figures) and compares
  the results with stored reference results from the previous release.
- CI runs the pipeline tests on simulated or example data, which can live in
  the repository.
- Real NEPS data cannot go into the repository or CI. An opt-in local run
  reads the data path from an environment variable and skips otherwise
  (`skip_if()`).
- Long runs go into a separate GitHub Actions workflow started by hand
  (`workflow_dispatch`) before a release, not into the per-push
  `R-CMD-check.yaml`.
- Update the "Checks and Tests" section of `CONTRIBUTING.md` and the
  [release checklist](94_release_checklist.md) to use the pipeline tests.

**WP 2.3: Result objects and reporting** (due 2027-05-28)
- #119 lightweight S3 class layer for result objects (groundwork for #120)
- #112 reimplement `wright_map()` with ggplot2, drop WrightMap dependency
- #117 vector graphics output for plots
- #116 add `item` argument to `GetMvi()`

**WP 2.4: Data preparation and validation** (due 2027-06-11)
- #174 set collapsing rules on part of the sample
- #74 `check_dich()` and all-NA columns in booklet designs
- #169 confirmation messages in validation check functions

**Decisions to settle in WP 1.3**
- #117: opt-in `device` argument or new default output format
- #74: warning, `strict` parameter, or keep the error
- #119: which parts land in 1.4.0

**Release window** (2027-06-18 to 2027-06-30)
- Run the [release checklist](94_release_checklist.md), with the pipeline
  tests from WP 2.2 replacing the manual comparison.

## Q3 2027 and later (to be decided)

Not yet planned: releases, versions and dates are decided later.

- #61 automatic detection of needed missing values
- #96 kernel smoothing for ICC curves
- #11 linking support (after #119)
- #138 sample-size-robust fit indices (needs a methodological decision first)
- #120 automate the full pipeline from scaling to a draft technical report
  (major-version goal, builds on #119)
