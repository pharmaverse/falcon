#' FDA Table 14: Patients With Adverse Events by System Organ Class and FDA Medical Query, Safety Population,
#'   Pooled Analyses
#'
#' @details
#' * `adae` must contain the variables specified by `arm_var`, `saffl_var`, `id_var`, `soc_var`,
#'   `fmqsc_var`, and `fmqnam_var`.
#' * If specified, `alt_counts_df` must contain the variables specified by `arm_var`, `id_var`, and `saffl_var`.
#' * Flag variables (i.e. `XXXFL`) are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'   flag variables are treated as `"N"`.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table represent the absolute numbers of patients and fraction of `N`.
#' * All-zero rows are not removed by default (see `prune_0` argument).
#'
#' @inheritParams argument_convention
#'
#' @return An `rtable` object.
#'
#' @examples
#' adae <- random.cdisc.data::cadae
#' adae <- dplyr::rename(adae, FMQ01SC = SMQ01SC, FMQ01NAM = SMQ01NAM)
#' levels(adae$FMQ01SC) <- c("BROAD", "NARROW")
#' adae$FMQ01SC[is.na(adae$FMQ01SC)] <- "NARROW"
#'
#' tbl <- make_table_14(adae = adae)
#' tbl
#'
#' @export
make_table_14 <- function(adae,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          id_var = "USUBJID",
                          soc_var = "AEBODSYS",
                          arm_var = "ARM",
                          saffl_var = "SAFFL",
                          fmqsc_var = "FMQ01SC",
                          fmqnam_var = "FMQ01NAM",
                          lbl_overall = NULL,
                          risk_diff = NULL,
                          prune_0 = FALSE,
                          na_level = "<Missing>",
                          annotations = NULL) {
  assert_subset(c(
    id_var, soc_var, arm_var, saffl_var, fmqsc_var, fmqnam_var
  ), names(adae))
  assert_flag_variables(adae, saffl_var)

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y") %>%
    df_explicit_na(na_level = na_level)
  adae[[fmqnam_var]] <- with_label(adae[[fmqnam_var]], "FMQ")

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df, id_var, arm_var, saffl_var)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by(fmqsc_var) %>%
    split_cols_by_arm(arm_var, lbl_overall, risk_diff) %>%
    split_rows_by(
      soc_var,
      child_labels = "visible",
      label_pos = "topleft",
      split_label = obj_label(adae[[soc_var]])
    ) %>%
    count_occurrences(
      vars = fmqnam_var,
      drop = FALSE,
      riskdiff = !is.null(risk_diff)
    ) %>%
    append_varlabels(adae, fmqnam_var, indent = 1L)

  tbl <- build_table(lyt, df = adae, alt_counts_df = alt_counts_df)
  if (prune_0) tbl <- prune_table(tbl)

  tbl
}
