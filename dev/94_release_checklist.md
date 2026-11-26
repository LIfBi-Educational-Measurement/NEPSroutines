# Release Checklist

Run this checklist in the release window of every release (see the
[roadmap](93_roadmap_2027.md)), after the code freeze and before the steps in
"Create Release" in `CONTRIBUTING.md`. Copy the checklist into the release PR
or milestone and tick the items there.

There are two scopes:
- **Patch scope** (patch releases, vX.Y.Z with only Z changed): the section
  "Required for every release".
- **Full scope** (minor and major releases): both required sections.

## Required for every release

**Tests and checks**
- [ ] All issues in the milestone are closed or moved to a later milestone.
- [ ] `devtools::document()` produces no diff.
- [ ] `devtools::test()` passes.
- [ ] `devtools::check()` passes with no new warnings or notes.
- [ ] Results are reproduced against the previous release: manually with
      `dev/manual_test_scripts/` up to v1.3.x, with the pipeline tests from
      v1.4.0 on (see roadmap, WP 2.2).

**Release notes and version**
- [ ] `NEWS.md` lists all user-facing changes of this release.
- [ ] Version number is updated in `DESCRIPTION` and `CITATION` and matches
      the `NEWS.md` heading and the planned tag.

## Also required for minor and major releases

**User-facing documentation** (done by a team member)
- [ ] Every vignette in `vignettes/` is still up to date and relevant: code
      runs with the current version, described behaviour and output match,
      and vignettes about outdated workflows are revised or removed.
- [ ] `README.md` and the installation instructions are up to date.

**Documentation in sync with code** (done by Claude)
- [ ] Claude checks that all package documentation is in sync with the code:
      roxygen docs of every exported function (arguments, defaults, return
      value, examples), the vignettes, `README.md`, `CONTRIBUTING.md` and the
      `dev/` documentation (in particular `dev/01_claude_reference.md`).
      Claude reports every mismatch as a list with file and line; fixes go
      through the usual PRs.

## Proposed additional checks by Claude

Proposals to accept or reject. Accepted items move into the required section.

### Every release
- [ ] `NEWS.md` covers every PR merged since the last tag
      (`git log <last tag>..HEAD`), and each entry is under the right version.
- [ ] The version bump matches the kind of change (patch, minor, major)
      described in `CONTRIBUTING.md`; a patch release contains no new
      features.
- [ ] Changed defaults and changed output are listed in `NEWS.md` even if the
      function signature did not change.
- [ ] No leftover debugging code in `R/`: `browser()`, `print()` used for
      debugging, hardcoded local paths, commented-out code blocks.
- [ ] The built tarball contains no NEPS data or other confidential files:
      check `.Rbuildignore` and list the contents of the tarball.
- [ ] Report templates and other files in `inst/` still match the functions
      that fill them (argument names, table and figure numbers).
- [ ] Every `@examples` block runs, and examples marked `\dontrun{}` are still
      correct.
- [ ] All packages used in `R/` are declared in `DESCRIPTION`, and no package
      in `Imports` is unused.
- [ ] Spelling and links: `spelling::spell_check_package()` and
      `urlchecker::url_check()` report nothing new.

### Minor and major releases
- [ ] Compare the exported API with the previous tag (function names,
      arguments, defaults). A minor release adds but does not remove or
      change anything; any break means a major release.
- [ ] Results saved with the previous release (`.rds`) still load and render.
- [ ] New exported functions have tests, documentation and, where they
      change a workflow, an entry in the matching vignette.
- [ ] Deprecated functions and arguments carry a deprecation warning and a
      planned removal version.

### Major releases
- [ ] `NEWS.md` contains a migration section for every breaking change, with
      the old call and the new call.
- [ ] Functions and arguments deprecated in earlier releases are removed as
      planned.
- [ ] The vignettes are read end to end as a new user would read them, and
      the overall structure (`package_introduction`, `getting_started`,
      `scaling_NEPS_data`) still fits the package.
- [ ] Dependencies are reviewed: minimum versions in `DESCRIPTION` and
      whether each dependency is still needed.
