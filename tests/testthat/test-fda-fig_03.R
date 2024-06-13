adsl <- adsl_raw

test_that("Figure 03 generation works with default values", {
  fig_03_default <- withr::with_options(
    opts_partial_match_old,
    make_fig_03(adsl, dctreas_var = "DCSREAS")
  )

  expect_snapshot_ggplot("fig_03_default", fig_03_default, width = 8, height = 5)
})

test_that("Figure 03 generation works with no table", {
  fig_03_notbl <- withr::with_options(
    opts_partial_match_old,
    make_fig_03(adsl, dctreas_var = "DCSREAS", add_table = FALSE)
  )

  expect_snapshot_ggplot("fig_03_notbl", fig_03_notbl, width = 8, height = 3)
})

test_that("Figure 03 generation works with custom values", {
  fig_03_custom <- withr::with_options(
    opts_partial_match_old,
    make_fig_03(
      adsl,
      dctreas_var = "DCSREAS",
      u_trtdur = "years",
      annotations = list(
        title = "Figure 3. Time to Adverse Event Leading to Treatment Discontinuation, Safety Population, Trial X"
      ),
      xticks = c(0, 0.25, 0.5, 0.75, 1, 1.1)
    )
  )

  expect_snapshot_ggplot("fig_03_custom", fig_03_custom, width = 10, height = 5)
})

test_that("Figure 03 generation works with ggtheme argument specified", {
  fig_03_theme <- withr::with_options(
    opts_partial_match_old,
    make_fig_03(
      adsl,
      dctreas_var = "DCSREAS",
      ggtheme = theme_dark()
    )
  )

  expect_snapshot_ggplot("fig_03_theme", fig_03_theme, width = 10, height = 6)
})
