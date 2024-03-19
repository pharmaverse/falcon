adsl <- random.cdisc.data::cadsl %>%
  mutate(AGEGR1 = as.factor(case_when(
    AGE >= 17 & AGE < 65 ~ ">=17 to <65",
    AGE >= 65 ~ ">=65",
    AGE >= 65 & AGE < 75 ~ ">=65 to <75",
    AGE >= 75 ~ ">=75"
  )) %>%
    formatters::with_label("Age Group, years")) %>%
  formatters::var_relabel(
    AGE = "Age, years"
  )

adae <- random.cdisc.data::cadae

df <- left_join(adsl, adae, by = intersect(names(adsl), names(adae)))

test_that("Table 22 generation works with default values", {
  result <- make_table_22(df = df)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 22 generation works with custom values: N_s denominator and overall column", {
  result <- make_table_22(
    df = df,
    alt_counts_df = adsl,
    denom = "N_s",
    lbl_overall = "Total population",
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 22 generation works with custom values: N_col denominator and no overall column", {
  result <- make_table_22(
    df = df,
    alt_counts_df = adsl,
    denom = "N_col",
    lbl_overall = NULL,
    prune_0 = TRUE,
    annotations = list(
      title = paste(
        "Table 22. Overview of Adverse Events1 by Demographic Subgroup, Safety Population, Pooled Analysis",
        "(or Trial X)"
      ),
      main_footer = c(
        "Source: [include Applicant source, datasets and/or software tools used].",
        "(1) Treatment-emergent adverse event defined as [definition]. MedDRA version X."
      ),
      prov_footer = c(
        "Abbreviations: MedDRA, Medical Dictionary for Regulatory Activities.;",
        "N, number of patients in treatment arm; n, number of patients with adverse event;",
        "Ns, total number of patients for each specific subgroup"
      )
    )
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 22 generation works with some NA values", {
  set.seed(5)
  df[sample(seq_len(nrow(df)), 50), "SEX"] <- NA
  df[sample(seq_len(nrow(df)), 30), "AGEGR1"] <- NA

  df <- df %>% df_explicit_na()

  result <- make_table_22(
    df = df,
    alt_counts_df = adsl,
    denom = "n",
    lbl_overall = "Total population",
    vars = c("AGEGR1", "SEX"),
    lbl_vars = c("Age (group)", "Sex")
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})
