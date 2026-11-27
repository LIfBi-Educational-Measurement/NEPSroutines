
test_that("conduct_dis_analysis() works", {

  # Temporary output directory
  path <- withr::local_tempdir()

  ####### Data example 2 #######

  # Run distractor analysis
  data(ex2)
  results <- try({
    dis_analysis(
      resp = ex2$resp,
      vars = ex2$vars,
      valid = "valid",
      select_raw = "raw",
      correct = "correct",
      mvs = c(OM = -97, NV = -95, NR = -94),
      print = FALSE,
      save = TRUE,
      overwrite = TRUE,
      path_results = path,
      path_table = path
    )
  })

  # Estimated without error
  expect_false(inherits(results, "try-error"))

  # All files created
  expect_true(file.exists(paste0(path, "/distractors_items.xlsx")))
  expect_true(file.exists(paste0(path, "/distractors_summary.xlsx")))
  expect_true(file.exists(paste0(path, "/distractors.rds")))

  # All generated files are identical to the precomputed files
  tabitem_fix <- Import(
    test_path("fixtures/ex2/tables"), "distractors_items.xlsx"
  )
  tabsum_fix <- Import(
    test_path("fixtures/ex2/tables"), "distractors_summary.xlsx"
  )
  res_fix <- readRDS(test_path("fixtures/ex2/results/distractors.rds"))
  tabitem <- Import(path, "distractors_items.xlsx")
  tabsum <- Import(path, "distractors_summary.xlsx")
  res <- readRDS(paste0(path, "/distractors.rds"))
  expect_true(identical(tabsum, tabsum_fix))
  expect_true(identical(tabitem, tabitem_fix))
  expect_true(identical(res, res_fix))

  ####### Data example 3 (use_wle = TRUE requires MASS via TAM) #######
  skip_if_not_installed("MASS")

  # Run distractor analysis
  data(ex3)
  results <- try({
    dis_analysis(
      resp = ex3$resp,
      vars = ex3$vars,
      valid = "valid",
      select_raw = "raw",
      select_score = "mixed",
      correct = "correct",
      use_wle = TRUE,
      scoring = "scoring",
      mvs = -999:-1,
      print = FALSE,
      save = TRUE,
      overwrite = TRUE,
      name_group = "ex3",
      path_results = path,
      path_table = path
    )
  })

  # Estimated without error
  expect_false(inherits(results, "try-error"))

  # All files created
  expect_true(file.exists(paste0(path, "/distractors_ex3_items.xlsx")))
  expect_true(file.exists(paste0(path, "/distractors_ex3_summary.xlsx")))
  expect_true(file.exists(paste0(path, "/distractors_ex3.rds")))

  # All generated files are identical to the precomputed files
  tabitem_fix <- Import(
    test_path("fixtures/ex3/tables"), "distractors_items.xlsx"
  )
  tabsum_fix <- Import(
    test_path("fixtures/ex3/tables"), "distractors_summary.xlsx"
  )
  res_fix <- readRDS(test_path("fixtures/ex3/results/distractors.rds"))
  tabitem <- Import(path, "distractors_ex3_items.xlsx")
  tabsum <- Import(path, "distractors_ex3_summary.xlsx")
  res <- readRDS(paste0(path, "/distractors_ex3.rds"))
  expect_true(identical(tabsum, tabsum_fix))
  expect_true(identical(tabitem, tabitem_fix))
  expect_true(identical(res, res_fix))

})

test_that("dis_summary() describes correct responses and distractors separately (#212)", {

  # Two items with different numbers of distractors (1 + 2 and 1 + 3 rows)
  distractors <- list(
    data.frame(name = c("*a", "b", "c"), N = c(10, 5, 5),
               rit = c(0.4, -0.1, -0.2)),
    data.frame(name = c("*a", "b", "c", "d"), N = c(10, 4, 3, 3),
               rit = c(0.3, -0.3, -0.1, -0.05))
  )

  expect_no_warning(res <- dis_summary(distractors, digits = 3, save = FALSE))

  corr <- c(0.4, 0.3)
  dist <- c(-0.1, -0.2, -0.3, -0.1, -0.05)
  expect_equal(dimnames(res$descriptives),
               list(c("mean", "sd", "median", "min", "max"),
                    c("correct", "distract")))
  expect_equal(res$descriptives[, "correct"],
               round(c(mean = mean(corr), sd = sd(corr), median = median(corr),
                       min = min(corr), max = max(corr)), 3))
  expect_equal(res$descriptives[, "distract"],
               round(c(mean = mean(dist), sd = sd(dist), median = median(dist),
                       min = min(dist), max = max(dist)), 3))

})

