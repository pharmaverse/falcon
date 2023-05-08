#' FDA Table 6: Overview of Adverse Events, Safety Population, Pooled Analyses
#'
#' @details
#' * `adae` must contain the variables `SAFFL`, `USUBJID`, `TRTEMFL`, `AESEV`, `AESER`, `AESDTH`, `AESLIFE`,
#'   `AESHOSP`, `AESDISAB`, `AESCONG`, `AESMIE`, `AEACN`, and the variable specified by `arm_var`.
#' * `alt_counts_df` is typically ADSL.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table represent the absolute numbers of patients and fraction of `N`.
#' * All-zero rows are not removed by default (see `prune_0` argument).
#'
#' @inheritParams argument_convention
#'
#' @examples
#' adsl <- scda::synthetic_cdisc_dataset("rcd_2022_10_13", "adsl")
#' adae <- scda::synthetic_cdisc_dataset("rcd_2022_10_13", "adae")
#'
#' tbl <- make_table_06(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' @export
make_table_06 <- function(adae,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          arm_var = "ARM",
                          lbl_overall = NULL,
                          prune_0 = FALSE,
                          annotations = NULL) {
  checkmate::assert_subset(c(
    "SAFFL", "USUBJID", "TRTEMFL", "AESEV", "AESER", "AESDTH", "AESLIFE",
    "AESHOSP", "AESDISAB", "AESCONG", "AESMIE", "AEACN", arm_var
  ), names(adae))

  adae <- adae %>%
    filter(SAFFL == "Y", TRTEMFL == "Y") %>%
    df_explicit_na() %>%
    mutate(
      SER = with_label(AESER == "Y", "SAE"),
      SERFATAL = with_label(AESER == "Y" & AESDTH == "Y", "SAEs with fatal outcome"),
      SERLIFE = with_label(AESER == "Y" & AESLIFE == "Y", "Life-threatening SAEs"),
      SERHOSP = with_label(AESER == "Y" & AESHOSP == "Y", "SAEs requiring hospitalization"),
      SERDISAB = with_label(
        AESER == "Y" & AESDISAB == "Y",
        "SAEs resulting in substantial disruption of normal life functions"
      ),
      SERCONG = with_label(AESER == "Y" & AESCONG == "Y", "Congenital anomaly or birth defect"),
      SERMIE = with_label(AESER == "Y" & AESMIE == "Y", "Other"),
      WD = with_label(AEACN == "DRUG WITHDRAWN", "AE leading to permanent discontinuation of study drug"),
      DSM = with_label(
        AEACN %in% c("DOSE INCREASED", "DOSE REDUCED", "DOSE RATE REDUCED", "DRUG INTERRUPTED"),
        "AE leading to dose modification of study drug"
      ),
      DSINT = with_label(AEACN == "DRUG INTERRUPTED", "AE leading to interruption of study drug"),
      DSRED = with_label(AEACN == "DOSE REDUCED", "AE leading to reduction of study drug"),
      DSD = with_label(AEACN == "DOSE RATE REDUCED", "AE leading to dose delay of study drug"),
      DSMIE = with_label(AEACN == "DOSE INCREASED", "Other")
    )

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by_arm(arm_var, lbl_overall) %>%
    count_patients_with_flags(
      var = "USUBJID",
      flag_variables = var_labels(adae[, "SER"]),
      table_names = "ser"
    ) %>%
    count_patients_with_flags(
      var = "USUBJID",
      flag_variables = var_labels(adae[, c("SERFATAL", "SERLIFE", "SERHOSP", "SERDISAB", "SERCONG", "SERMIE")]),
      .indent_mods = 1L,
      table_names = "ser_fl"
    ) %>%
    count_patients_with_flags(
      var = "USUBJID",
      flag_variables = var_labels(adae[, c("WD", "DSM")]),
      table_names = "ae"
    ) %>%
    count_patients_with_flags(
      var = "USUBJID",
      flag_variables = var_labels(adae[, c("DSINT", "DSRED", "DSD", "DSMIE")]),
      .indent_mods = 1L,
      table_names = "ds"
    ) %>%
    analyze_num_patients(
      vars = "USUBJID",
      .stats = "unique",
      .labels = c(unique = "Any AE"),
      show_labels = "hidden"
    ) %>%
    count_occurrences_by_grade(
      var = "AESEV",
      show_labels = "hidden",
      .indent_mods = 1L
    )

  tbl <- build_table(lyt, df = adae, alt_counts_df = alt_counts_df)
  if (prune_0) tbl <- prune_table(tbl)

  tbl
}