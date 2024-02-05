adsl <- adsl_raw
adae <- adae_raw

set.seed(1)
adae <- adae %>%
  dplyr::rename(FMQ01SC = SMQ01SC) %>%
  dplyr::mutate(
    AESER = sample(c("Y", "N"), size = nrow(adae), replace = TRUE),
    FMQ01NAM = sample(c("FMQ1", "FMQ2", "FMQ3"), size = nrow(adae), replace = TRUE)
  )
adae$FMQ01SC[is.na(adae$FMQ01SC)] <- "NARROW"

test_that("Table 10 generation works with default values", {
  result <- make_table_10(adae = adae, alt_counts_df = adsl)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 10 generation works with custom values", {
  adae <- formatters::var_relabel(adae, AEBODSYS = "Body System or Organ Class(3)")
  result <- make_table_10(
    adae = adae,
    alt_counts_df = adsl,
    fmq_scope = "BROAD",
    annotations = list(
      title = paste(
        "Table 10. Patients With Serious Adverse Events(1) by System Organ Class and FDA Medical Query\n",
        "(Broad), Safety Population, Pooled Analyses(2)"
      ),
      main_footer = paste(
        "Source: [include Applicant source, datasets and/or software tools used].\n",
        "(1) Defined as any untoward medical occurrence that, at any dose that results in death,",
        "is life-threatening,\n requires hospitalization or prolongation of existing hospitalization, results in",
        "persistent incapacity or substantial\n",
        "disruption of the ability to conduct normal life functions, or is a congenital anomaly or birth defect.\n",
        "(2) Duration = [e.g., X-week double-blind treatment period or, median and a range indicating pooled trial\n",
        "durations].\n",
        "(3) Each FMQ is aligned to a single SOC based on clinical judgement.",
        "However, please be aware that some FMQs\n",
        "may contain PTs from more than one SOC."
      ),
      prov_footer = c(
        "Abbreviations: CI, confidence interval; FMQ, FDA Medical Query;",
        "MedDRA, Medical Dictionary for Regulatory Activities; N, number of patients in treatment arm;",
        "n, number of patients with adverse event; SOC, System Organ Class"
      )
    )
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 10 generation works with risk difference column", {
  risk_diff <- list(arm_x = "B: Placebo", arm_y = "A: Drug X")
  result <- make_table_10(adae, adsl, risk_diff = risk_diff)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 10 (gt) generation works", {
  result <- make_table_10_gtsum(adae = adae, alt_counts_df = adsl)
  res <- list(
    "data" = result[["_data"]],
    "column_label" = result[["_boxhead"]][["column_label"]],
    "header" = result[["_heading"]],
    "footnotes" = result[["_footnotes"]][["footnotes"]]
  )
  expect_snapshot(res)
})

test_that("Table 10 (gt) generation works with custom values", {
  adae <- formatters::var_relabel(adae, AEBODSYS = "Body System or Organ Class(3)")
  annotations <- list(
    title = "Table 10. Patients With Serious Adverse Events ",
    subtitle = "by System Organ Class and FDA Medical Query (Narrow),
  Safety Population, Pooled Analyses",
    footnotes = list(
      "Duration = [e.g., X week double-blind treatment period or median and a range
    indicating pooled trial durations]."
    )
  )
  result <- make_table_10_gtsum(
    adae = adae,
    alt_counts_df = adsl,
    lbl_overall = "Overall",
    fmq_scope = "BROAD",
    annotations = annotations,
  )

  res <- list(
    "data" = result[["_data"]],
    "column_label" = result[["_boxhead"]][["column_label"]],
    "header" = result[["_heading"]],
    "footnotes" = result[["_footnotes"]][["footnotes"]]
  )
  expect_snapshot(res)
})
