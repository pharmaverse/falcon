adsl <- adsl_raw
adae <- adae_raw

test_that("Table 09 generation works with default values", {
  result <- make_table_09(adae, adsl)

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 09 generation works with custom values", {
  result <- make_table_09(
    adae,
    adsl,
    lbl_overall = "Total",
    annotations = list(
      title = paste(
        "Table 9. Patients With Serious Adverse Events(1) by System Organ Class and",
        "Preferred Term, Safety Population, Pooled Analyses(2)"
      ),
      main_footer = c(
        "Source: [include Applicant source, datasets and/or software tools used].",
        "(1) Defined as any untoward medical occurrence that, at any dose that results in death, is life-threatening,",
        "requires hospitalization or prolongation of existing hospitalization, results in persistent incapacity or",
        "substantial disruption of the ability to conduct normal life functions, or is a congenital anomaly or",
        "birth defect.",
        "(2) Duration = [e.g., X week double-blind treatment period or median and",
        "a range indicating pooled trial durations]."
      ),
      prov_footer = c(
        "Abbreviations: AE, adverse event; CI, confidence interval; N, number of patients in treatment arm;",
        "n, number of patients with adverse event; PT, preferred term; SAE, serious adverse event;",
        "SOC, System Organ Class"
      )
    )
  )

  res <- expect_silent(result)
  expect_snapshot(res)
})

test_that("Table 09 (gt) generation works with risk difference column", {
  risk_diff <- list(arm_x = "B: Placebo", arm_y = "A: Drug X")
  result <- make_table_09(adae, adsl, risk_diff = risk_diff)

  res <- expect_silent(result)
  expect_snapshot(res)
})


test_that("Table 09 (gt) generation works with default values", {
  result <- make_table_09_gtsum(adae)

  res <- list(
    "data" = result[["_data"]],
    "column_label" = result[["_boxhead"]][["column_label"]],
    "header" = result[["_heading"]],
    "footnotes" = result[["_footnotes"]][["footnotes"]]
  )
  expect_snapshot(res)
})

test_that("Table 09 (gt) generation works with custom values", {
  annotations <- list(
    title = "Table 9. Patients With Serious Adverse Events",
    subtitle = "by System Organ Class and Preferred Term, Safety Population, Pooled Analyses",
    footnotes = list(
      "Duration = [e.g., X week double-blind treatment period or median and a range indicating
      pooled trial durations].",
      "Difference is shown between [treatment arms] (e.g., difference is shown between Drug Name dosage X vs. placebo)."
    )
  )
  risk_diff <- list(c("A: Drug X", "C: Combination"), c("A: Drug X", "B: Placebo"))

  result <- make_table_09_gtsum(adae,
    alt_counts_df = adsl,
    lbl_overall = "Total",
    annotations = annotations,
    risk_diff = risk_diff
  )

  res <- list(
    "data" = result[["_data"]],
    "column_label" = result[["_boxhead"]][["column_label"]],
    "header" = result[["_heading"]],
    "footnotes" = result[["_footnotes"]][["footnotes"]]
  )
  expect_snapshot(res)
})

# Test make_table_09_tplyr() ----

test_that("make_table_09_tplyr() returns a tibble when tplyr_raw = TRUE", {
  tbl_out <- make_table_09_tplyr(adae = adae, tplyr_raw = TRUE)
  expect_tibble(tbl_out) # verify expected type

  expect_silent(tbl_out) # expect no messages or warnings
  expect_snapshot(tbl_out) # verify that the content didn't change compared to the last run
})

test_that("make_table_09_tplyr() returns a gt object when tplyr_raw = FALSE", {
  tbl_out <- make_table_09_tplyr(adae = adae, tplyr_raw = FALSE)
  expect_class(tbl_out, "gt_tbl") # verify expected type

  expect_silent(tbl_out) # expect no messages or warnings
  expect_snapshot(tbl_out) # verify that the content didn't change compared to the last run
})

# As we have now verified visually (due to the snapshots) that tplyr table and gt table are the same content-wise,
# we can use the tplyr data.frame to verify the content. However, the cell content is not tested, since
# we trust that {tplyr} functionality works as expected
test_that("make_table_09_tplyr() provides total column counts based on the alt_count_df parameter", {
  # Use adsl for alternative column counts
  tbl_out <- make_table_09_tplyr(adae = adae, alt_counts_df = adsl, tplyr_raw = TRUE)

  # Extract column counts
  counts_row <- tbl_out[1, ][2:ncol(tbl_out)]
  counts_out <- data.frame(
    arm = gsub("var1_", "", names(counts_row)),
    n_out = as.numeric(gsub("[^0-9]", "", counts_row))
  )

  # Compare expected counts to actual counts
  counts_exp <- adsl %>%
    dplyr::group_by(ARM) %>%
    dplyr::summarize(n_exp = n()) %>%
    dplyr::full_join(counts_out, by = c("ARM" = "arm")) %>%
    dplyr::mutate(equal = (n_exp == n_out))

  expect_true(all(counts_exp[["equal"]]))

  # Repeat procedure for the case that no alt_counts_df is specified
  tbl_out_n <- make_table_09_tplyr(adae = adae, tplyr_raw = TRUE)
  counts_row_n <- tbl_out_n[1, ][2:ncol(tbl_out_n)]
  counts_out_n <- data.frame(
    arm = gsub("var1_", "", names(counts_row_n)),
    n_out = as.numeric(gsub("[^0-9]", "", counts_row_n))
  )

  counts_exp <- adae %>%
    dplyr::group_by(ARM) %>%
    dplyr::filter(AESER == "Y", SAFFL == "Y") %>%
    dplyr::summarize(n_exp = n()) %>%
    dplyr::full_join(counts_out_n, by = c("ARM" = "arm")) %>%
    dplyr::mutate(equal = (n_exp == n_out))

  expect_true(all(counts_exp[["equal"]]))
})

test_that("make_table_09_tplyr() assigns column headers correctly to the arm groups", {
  tbl_out <- make_table_09_tplyr(adae, tplyr_raw = TRUE)
  arm_col_names <- colnames(tbl_out)[-1] |> sub(pattern = "var1_", replacement = "")
  arm_headers <- unlist(tbl_out[1, -1])
  position_valid <- sapply(seq_along(length(arm_col_names)), function(i) grepl(arm_col_names[i], arm_headers[i]))
  expect_true(all(position_valid))

  # Alternate levels order
  adae_alt <- adae %>%
    dplyr::mutate(ARM = factor(ARM, levels = unique(adae[["ARM"]])))
  tbl_out <- make_table_09_tplyr(adae_alt, tplyr_raw = TRUE)
  arm_col_names <- colnames(tbl_out)[-1] |> sub(pattern = "var1_", replacement = "")
  arm_headers <- unlist(tbl_out[1, -1])
  position_valid <- sapply(seq_along(length(arm_col_names)), function(i) grepl(arm_col_names[i], arm_headers[i]))
  expect_true(all(position_valid))

  # Test with character column instead factor column
  adae_chr <- adae %>%
    dplyr::mutate(ARM = as.character(ARM))
  tbl_out <- make_table_09_tplyr(adae_chr, tplyr_raw = TRUE)
  arm_col_names <- colnames(tbl_out)[-1] |> sub(pattern = "var1_", replacement = "")
  arm_headers <- unlist(tbl_out[1, -1])
  position_valid <- sapply(seq_along(length(arm_col_names)), function(i) grepl(arm_col_names[i], arm_headers[i]))
  expect_true(all(position_valid))
})

test_that("make_table_09_tplyr() provides risk difference columns based on the risk_diff_pairs parameter", {
  # Test for display of one comparison
  rd <- list(c("A: Drug X", "B: Placebo"))
  tbl_out <- make_table_09_tplyr(adae = adae, alt_counts_df = adsl, risk_diff_pairs = rd, tplyr_raw = TRUE)
  rdiff_index <- grep("rdiff_", colnames(tbl_out))
  expect_length(rdiff_index, length(rd))

  # Test for display of multiple comparisons
  rd_pairs <- list(c("A: Drug X", "B: Placebo"), c("A: Drug X", "C: Combination"))
  tbl_out <- make_table_09_tplyr(adae = adae, alt_counts_df = adsl, risk_diff_pairs = rd_pairs, tplyr_raw = TRUE)
  rdiff_index <- grep("rdiff_", colnames(tbl_out))
  expect_length(rdiff_index, length(rd_pairs))

  # Check correct assignment of header_string
  rd_tbl <- tbl_out %>%
    dplyr::select(tidyr::starts_with("rdiff_"))

  names_out <- colnames(rd_tbl) |>
    sub(pattern = "rdiff_", replacement = "RD: ") |>
    sub(pattern = "_", replacement = " - ")

  expect_equal(names_out, unlist(rd_tbl[1, ]), ignore_attr = TRUE)
})

test_that("make_table_09_tplyr() provides a total column based on the lbl_overall parameter", {
  # Check that overall column exists and the header string is assigned correctly to it
  lbl <- "Total Pat."
  tbl_out <- make_table_09_tplyr(adae = adae, alt_counts_df = adsl, lbl_overall = lbl, tplyr_raw = TRUE) %>%
    dplyr::select(tidyr::ends_with(lbl))

  lbl_out <- sub("var1_", "", colnames(tbl_out))
  expect_equal(lbl_out, lbl)
  expect_true(grepl(lbl_out, unlist(tbl_out[1, ])))

  # Check that no overall column is presented, if lbl_overall parameter is NULL
  tbl_out <- make_table_09_tplyr(adae = adae, alt_counts_df = adsl, lbl_overall = NULL, tplyr_raw = TRUE) %>%
    dplyr::select(tidyr::ends_with(lbl))
  expect_equal(ncol(tbl_out), 0)
})

test_that("make_table_09_tplyr() prunes all-zero-rows based on the prune_0 parameter", {
  # Check that zeros are pruned if prune_0 = TRUE
  tbl_out <- make_table_09_tplyr(adae = adae, prune_0 = TRUE, tplyr_raw = TRUE) %>%
    dplyr::mutate(
      is_zero_a = dplyr::if_else(`var1_A: Drug X` == "  0 (  0.0%)", TRUE, FALSE),
      is_zero_b = dplyr::if_else(`var1_B: Placebo` == "  0 (  0.0%)", TRUE, FALSE),
      is_zero_c = dplyr::if_else(`var1_C: Combination` == "  0 (  0.0%)", TRUE, FALSE),
      all_zero = is_zero_a & is_zero_b & is_zero_c
    )

  expect_false(any(tbl_out[["all_zero"]]))

  # Check that zeros are pruned if prune_0 = FALSE
  tbl_out <- make_table_09_tplyr(adae = adae, prune_0 = FALSE, tplyr_raw = TRUE) %>%
    dplyr::mutate(
      is_zero_a = dplyr::if_else(`var1_A: Drug X` == "  0 (  0.0%)", TRUE, FALSE),
      is_zero_b = dplyr::if_else(`var1_B: Placebo` == "  0 (  0.0%)", TRUE, FALSE),
      is_zero_c = dplyr::if_else(`var1_C: Combination` == "  0 (  0.0%)", TRUE, FALSE),
      all_zero = is_zero_a & is_zero_b & is_zero_c
    )

  expect_true(any(tbl_out[["all_zero"]]))
})

test_that("make_table_09_tplyr() shows column counts based on the show_colcounts parameter", {
  # Check that column counts are visible if specified such
  tbl_out <- make_table_09_tplyr(adae = adae, show_colcounts = TRUE, tplyr_raw = TRUE)
  header_row <- unlist(tbl_out[1, 2:ncol(tbl_out)])
  expect_true(all(grepl("\\(N=", header_row)))

  # Check that column counts are omitted if specified such
  tbl_out <- make_table_09_tplyr(adae = adae, show_colcounts = FALSE, tplyr_raw = TRUE)
  header_row <- unlist(tbl_out[1, 2:ncol(tbl_out)])
  expect_false(all(grepl("\\(N=", header_row)))
})

test_that("make_table_09_tplyr() considers lbl_soc_var and lbl_pref_var parameters", {
  soc_lbl <- "SOC label"
  pt_lbl <- "PT label"

  # Check labels for Tplyr output
  tbl_out <- make_table_09_tplyr(adae = adae, lbl_soc_var = soc_lbl, lbl_pref_var = pt_lbl, tplyr_raw = TRUE)
  lbl_out <- tbl_out[[1, 1]]
  expect_true(grepl(soc_lbl, lbl_out))
  expect_true(grepl(pt_lbl, lbl_out))

  # Check labels for gt output
  tbl_out <- make_table_09_tplyr(adae = adae, lbl_soc_var = soc_lbl, lbl_pref_var = pt_lbl, tplyr_raw = FALSE)
  lbl_out <- tbl_out[["_stubhead"]][["label"]]
  expect_true(grepl(soc_lbl, lbl_out))
  expect_true(grepl(pt_lbl, lbl_out))
})

test_that("make_table_09_tplyr() considers annotations if tplyr_raw = FALSE", {
  # Add titles and footnotes
  annot <- list(
    title = "Table 9. Patients with Serious Adverse Events by SOC and PT, Safety Population, Pooled Analyses",
    subtitles = c("Only one title, but", "multiple subtitles possible"),
    main_footer = c("Main footer 1", "Main footer 2"),
    prov_footer = c("Some more information", "E.g. a source note")
  )
  tbl_out <- make_table_09_tplyr(adae = adae, annotations = annot)
  title_out <- tbl_out[["_heading"]][["title"]]
  subtitle_out <- tbl_out[["_heading"]][["subtitle"]]
  main_footer_out <- tbl_out[["_footnotes"]][["footnotes"]][[1]]
  prov_footer_out <- tbl_out[["_source_notes"]][[1]]

  expect_true(grepl(annot[["title"]], title_out))
  expect_true(grepl(annot[["subtitles"]][[1]], subtitle_out))
  expect_true(grepl(annot[["subtitles"]][[2]], subtitle_out))
  expect_true(grepl(annot[["main_footer"]][[1]], main_footer_out))
  expect_true(grepl(annot[["main_footer"]][[2]], main_footer_out))
  expect_true(grepl(annot[["prov_footer"]][[1]], prov_footer_out))
  expect_true(grepl(annot[["prov_footer"]][[2]], prov_footer_out))
})
