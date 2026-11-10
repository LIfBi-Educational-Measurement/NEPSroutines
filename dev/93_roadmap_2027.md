# NEPSroutines Roadmap 2027

Overview of what each release should cover. One release per quarter; no
timeline inside a release; work is done as time allows. The plan assumes all
items of a release get done; if not, this roadmap is updated. Issue status lives in
the milestones on
[GitHub](https://github.com/LIfBi-Educational-Measurement/NEPSroutines/issues).
Issues are referenced as `#n`.

Base state: v1.3.0 released; milestones v1.3.1 and v1.4.0 exist without due dates.

## Q1 2027: v1.3.1 (patch: fixes and test health, no API changes)

**Fixture and test health** (do first, other fixes regenerate fixtures)
- #158 fixture hash manifest should hash contents, not paths
- #152 regenerate stale ex2 fixtures; fix `TblCode()` `tam.fit()` mismatch
- #159 test the dimension-naming branches of `conduct_dim_analysis()`

**Report output correctness**
- #131 Wright map footnote hardcodes "Table 5"
- #142 `TblCode()` does not define the Rasch model
- #154 sum-0 cell in `steps_analysis()` ignores `digits`

**Silent failures and input validation**
- #113 `Import()` `rename` validation
- #136 `prepare_facets()` with negative values
- #160 unnamed `position` vector with grouping in `mvi_analysis()`
- #161 warn when response codes are not covered by `mvs`

**DIF**
- #139 DIF with factor variables

**Docs and housekeeping**
- #162 data preparation in the example scripts
- #165 separate test data from example data
- #167 update README

**Need a domain answer or team decision first**
- #124 add SK and RS missing types
- #129 review `survey_paper.bib` template
- #168 author order (team decision)

**Open decision**
- #173 remove automatic birth-year replacement in `calculate_age`: it changes
  a default, so decide whether it ships here with a release-notes entry or
  belongs in v1.4.0.

## Q2 2027: v1.4.0 (minor: non-breaking groundwork)

Old `.rds` results must still render; existing exported functions keep working.

**Result objects**
- #119 lightweight S3 class layer for result objects (groundwork for #120)

**Reporting and output**
- #112 reimplement `wright_map()` with ggplot2, drop WrightMap dependency
- #117 vector graphics output for plots
- #116 add `item` argument to `GetMvi()`

**Data preparation and validation**
- #174 set collapsing rules on part of the sample
- #74 `check_dich()` and all-NA columns in booklet designs
- #169 confirmation messages in validation check functions

**Decisions to settle before starting**
- #117: opt-in `device` argument or new default output format
- #74: warning, `strict` parameter, or keep the error
- #119: which parts land in 1.4.0

## Q3 2027: v1.5.0 (minor: features)

- #61 automatic detection of needed missing values
- #96 kernel smoothing for ICC curves
- #11 linking support (after #119)
- #138 sample-size-robust fit indices (needs a methodological decision first)

## Q4 2027 and later

- #120 automate the full pipeline from scaling to a draft technical report
  (major-version goal, builds on #119)
