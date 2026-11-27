# Release Checklist

Run this checklist in the release window of every release (see the
[roadmap](93_roadmap_2027.md)), as part of "Checks and Tests" and before the
steps in "Create Release" in `CONTRIBUTING.md`. The release workflow in
`CONTRIBUTING.md` applies; this checklist adds the checks to it. Releases are
created by the admins, as `CONTRIBUTING.md` says.

**Proposed for `CONTRIBUTING.md`.** Some rules this checklist relies on are
not yet part of the release workflow in `CONTRIBUTING.md`. They are proposed
in a separate PR and apply once the admins have agreed to them:

- Copy this checklist into the release milestone or a release-prep issue and
  tick the items there.
- Code freeze: from the code freeze until the release, only fixes found by
  this checklist are merged into `main`; work for the next release waits on
  its branches.
- In step 1 of "Create Release", also add or update `Date:` in
  `DESCRIPTION`; new authors go into both `DESCRIPTION` and
  `inst/CITATION`. (Step 1 already edits these files, so the checklist items
  on them apply now; the proposal only writes this down in
  `CONTRIBUTING.md`.)
- The release notes of the GitHub release (step 5 of "Create Release") are
  copied from `NEWS.md`.

The items under "Release notes and version" are ticked while doing step 1 of
"Create Release", which is where the version is bumped.

There are three scopes:

- **Patch scope** (patch releases, vX.Y.Z with only Z changed): the section
  "Required for every release".
- **Full scope** (minor releases): "Required for every release" and "Also
  required for minor and major releases".
- **Major scope** (major releases): all three required sections.

## Required for every release

**Tests and checks**

- [ ] All issues in the milestone are closed or moved to a later milestone.
- [ ] The roadmap matches the milestones: the status lines of the released
      work packages say `done <date>`, and no issue of this release still
      carries the `decision needed` label.
- [ ] `devtools::document()`, `devtools::test()` and `devtools::check()`
      pass, as in "Checks and Tests" in `CONTRIBUTING.md`; `document()`
      produces no diff and `check()` shows no new warnings or notes.
- [ ] CI (`R-CMD-check.yaml`) is green on the last commit on `main` before
      step 1 of "Create Release".
- [ ] Results are reproduced against the previous release: manually with
      `dev/manual_test_scripts/` up to v1.3.2, with the pipeline tests from
      v1.3.3 or v1.4.0 on (see roadmap, WP 2.2). Runs on real NEPS data (the
      manual scripts, the local real-data tests) are done by the team; agents
      do not run them and do not see their output.
- [ ] Spelling: up to v1.3.2, run `spelling::spell_check_package()` once in
      the release window. From v1.3.3 or v1.4.0 on, the spell check runs on
      every PR (roadmap WP 2.1); read its report in the CI log of the same
      commit as above.
- [ ] The example scripts in `inst/examples/` are re-rendered after the code
      freeze, so the `.html` files show the output of this release. They use
      only the package's example data. Rendering needs Pandoc (bundled with
      RStudio). The scripts are not re-rendered in single PRs, because
      several PRs of a release change printed output and the large `.html`
      files would conflict.

**Release notes and version**

- [ ] `NEWS.md` lists all user-facing changes of this release. The text of
      the GitHub release is copied from it, once the admins have agreed (see
      above).
- [ ] The version is bumped in `DESCRIPTION` (`inst/CITATION` reads it from
      there) and matches the `NEWS.md` heading and the planned tag.
- [ ] `Date:` in `DESCRIPTION` is added or updated to the release date, so the
      year in the citation is filled in.
- [ ] `citation("NEPSroutines")` prints correctly, and the authors in
      `inst/CITATION` match the authors in `DESCRIPTION`.

**Further checks** (done by an agent, findings reviewed by a maintainer)

- [ ] `NEWS.md` covers every PR merged since the last tag
      (`git log <last tag>..HEAD`), and each entry is under the right version.
- [ ] The version bump matches the kind of change (patch, minor, major)
      described in `CONTRIBUTING.md`; a patch release contains no new
      features.
- [ ] Changed defaults and changed output are listed in `NEWS.md` even if the
      function signature did not change.
- [ ] Report templates and other files in `inst/` still match the functions
      that fill them (argument names, table and figure numbers).
- [ ] Examples marked `\dontrun{}` are still correct (the other examples run
      in `R CMD check`).
- [ ] No package in `Imports` is unused (undeclared packages are caught by
      `R CMD check`).

## Also required for minor and major releases

**User-facing documentation** (done by an agent, findings reviewed by a
maintainer)

- [ ] Every vignette in `vignettes/` is still up to date and relevant: code
      runs with the current version, described behaviour and output match,
      and vignettes about outdated workflows are revised or removed.
- [ ] `README.md` and the installation instructions are up to date.
- [ ] The agent reports its findings as a list with file and line, and says
      which vignettes it proposes to revise or remove. A maintainer decides on
      the findings; fixes go through the usual PRs.

**Documentation in sync with code** (done by an agent, findings reviewed by a
maintainer)

- [ ] The agent checks that all package documentation is in sync with the
      code: roxygen docs of every exported function (arguments, defaults,
      return value, examples), the vignettes, `README.md`, `CONTRIBUTING.md`,
      `NEWS.md` and the `dev/` documentation (in particular
      `dev/01_claude_reference.md`). While reading the code, the agent also
      flags `print()` calls left over from debugging (the other leftovers are
      caught by the lint check on every PR, see roadmap WP 2.1). The agent
      reports every mismatch as a list with file and line; fixes go through
      the usual PRs.

**Links**

- [ ] `urlchecker::url_check()` reports no new broken links. (Not in CI,
      because outside websites that are briefly down would fail unrelated
      PRs.)

**Compatibility** (done by an agent, findings reviewed by a maintainer)

- [ ] Compare the exported API with the previous tag (function names,
      arguments, defaults). A minor release adds but does not remove or
      change anything; any break means a major release.
- [ ] The old-results test passes: a result saved with v1.3.2 (`.rds`) still
      loads and renders (see roadmap WP 2.1). The fixture stays pinned to
      v1.3.2 until it is deliberately refreshed.
- [ ] New exported functions have tests, documentation and, where they
      change a workflow, an entry in the matching vignette.
- [ ] Deprecated functions and arguments carry a deprecation warning that
      names the version in which they will be removed.

## Also required for major releases

- [ ] `NEWS.md` contains a migration section for every breaking change, with
      the old call and the new call.
- [ ] Functions and arguments deprecated in earlier releases are removed as
      planned.
- [ ] The vignettes are read end to end as a new user would read them, and
      the overall structure (`package_introduction`, `getting_started`,
      `scaling_NEPS_data`) still fits the package.
- [ ] Dependencies are reviewed: minimum versions in `DESCRIPTION` and
      whether each dependency is still needed.
