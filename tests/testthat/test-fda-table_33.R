adsl <- adsl_raw
advs <- advs_raw %>%
  mutate(AVAL = AVAL - 100)

test_that("Table 33 generation works with default values", {
  result <- make_table_33(advs, adsl)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 33 generation works with custom values", {
  result <- make_table_33(
    advs,
    adsl,
    lbl_overall = "Total\nPopulation",
    annotations = list(
      title = paste(
        "Table 33. Percentage of Patients Meeting Specific Hypotension Levels\n",
        "Postbaseline, Safety Population, Pooled Analysis"
      ),
      main_footer = c(
        "Source: [include Applicant source, datasets and/or software tools used].",
        "(1) Difference is shown between [treatment arms] (e.g., difference is shown",
        "between Drug Name dosage X vs. placebo)."
      ),
      prov_footer = c(
        "Abbreviations: CI, confidence interval; N, number of patients in treatment arm with",
        "available blood pressure data; n, number of patients with indicated blood pressure"
      )
    )
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 33 generation works with pruned rows", {
  advs$AVAL[advs$PARAMCD == "SYSBP"] <- 100
  result <- make_table_33(advs, adsl, prune_0 = TRUE)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 33 generation works with risk difference column", {
  risk_diff <- list(arm_x = "B: Placebo", arm_y = "A: Drug X")
  result <- make_table_33(advs, adsl, risk_diff = risk_diff)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 33 (gtsum) generation works with default values", {
  result <- suppressWarnings(make_table_33_gtsum(advs = advs) %>% gt::extract_body())
  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 33 (gtsum) generation works with custom values", {
  result <- suppressWarnings(
    make_table_33_gtsum(advs = advs, lbl_overall = "Total Population") %>% gt::extract_body()
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})
