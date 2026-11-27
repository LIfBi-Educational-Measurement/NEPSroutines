# NEPSroutines 1.3.1 (development version)

## Changes to printed output

* `irt_analysis()` now prints a clearer summary (via `print_irt_summary()`):
  it adds a table with summary statistics for item fit, also flags items as
  problematic based on aQ3 and rit, and orders the statistics under bold
  headings and subheadings (#193).
* `dis_analysis()` now prints a clearer distractor summary (via
  `print_dis_summary()`), with additional headings, bold (sub)headings and
  better spacing (#198).

## Bug fixes

* `TblCode()` now prints `irtmodel = "1PL"` instead of `irtmodel = "PCM2"` in
  the appendix syntax for tests with only dichotomous items (Rasch model). The
  estimates were not affected, only the printed model name (#186, closes
  #142).
* The technical report skeleton now passes the number of the item-parameter
  table to `FigWrightMap()` for each domain. Reports for mathematics and
  digital competence previously cited Table 5 instead of Table 4 in the Wright
  map note. Reports created before this fix are not updated: change the
  `FigWrightMap()` call in existing mathematics and digital competence reports
  to `tbl = 4` by hand (#182, closes #131).

## Documentation

* Added example scripts for data preparation (`dat1` to `dat4`) as R Markdown
  files with rendered HTML output (#184).
* The README now describes only the installation option that builds the
  vignettes (#171).

## Internal

* Updated CONTRIBUTING with the release step that builds a package with
  vignettes (#172).
* Rearranged the DESCRIPTION file (#170).
* Changed the author order.
* Added the 2027 roadmap, the release checklist and changes to the agent
  workflow (#175, #183, #191).

# NEPSroutines 1.3.0

## License

* Changed the license from GPL-2 to MIT.
* Added a LICENSE file.

## Documentation

* Added a README file.
* Added package documentation (`?NEPSroutines`).
* Added vignettes that guide users through the scaling process.
* Added example data and scripts.

## Functionality

* Added a function to score highlighting items.
* Response categories can now be collapsed with user-supplied rules.
* The percentage correct is now also calculated for polytomous items.
* Fixed a bug in the steps analysis of polytomous IRT analyses (the SE was
  reported slightly wrong).
* Improved error and warning messages.
* Improved the printed output of functions.
* Changed the default color palette in the missing value functions.
* Fixed bugs in and improved the output of the technical report functions.
* Removed unnecessary package dependencies (WrightMap, sfsmisc, colormap,
  tibble, Hmisc, psych, rlang, tidyr).

## Internal

* Added a CONTRIBUTING file.
* Cleaned the repository (e.g., removed stale files and moved other files in
  line with package best practices).
* Added simulated data to improve automatic testing.
* Added comprehensive unit tests.
* Added internal helper functions.
* Deprecated `NEPSroutines:::` calls throughout the package.
* Removed stale linking code.
* Incorporated Claude and Copilot in the development process.
* New package author: Matthias Kloft.
* New contributor: Rachael Kyalo.

# NEPSroutines 1.2.1

* Implemented imputation for missing subitems in `pc_scoring()`.
* Improved the Wright map in the IRT analysis.
* Fixed bugs in the technical report scripts and in the distractor analysis.

# NEPSroutines 1.2.0

* Renamed the package from "scaling" to "NEPSroutines".
* Extended the package to also accommodate multistage tests.
* Added Quarto scripts for creating technical reports with the package.
* Minor bug fixes and improvements.

# NEPSroutines 1.1.1

Minor bug fixes and changes to:

* function arguments in `grouped_irt_analysis()`,
* output in `mvi_analysis()` and `collapse_response_categories()`,
* fixed IRT parameters in `irt_analysis()` and `create_scores()` and the
  corresponding function arguments.

# NEPSroutines 1.1.0

* Minor bug fixes and some improvements in data preparation, missing value
  plots, IRT analysis, DIF analysis, and score and SUF creation.
* Added a color argument to the missing value plots.
* Adjusted the correction for position effects in score creation.
* Minor changes to the output of the IRT and DIF analyses.

# NEPSroutines 1.0.1

* Small bug fixes and improvements in data preparation, descriptives, missing
  value analysis, and IRT analysis.

# NEPSroutines 1.0.0

* First version of the NEPSroutines package for users.
