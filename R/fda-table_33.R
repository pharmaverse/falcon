#' FDA Table 33: Percentage of Patients Meeting Specific Hypotension Levels Postbaseline,
#'   Safety Population, Pooled Analysis
#'
#' @details
#' * `advs` must contain `AVISITN`, `PARAMCD`, `AVAL`, `AVALU`, and the variables specified by `arm_var`, `id_var`,
#'   and `saffl_var`.
#' * If specified, `alt_counts_df` must contain the variables specified by `arm_var`, `id_var`, and `saffl_var`.
#' * Flag variables (i.e. `XXXFL`) are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'   flag variables are treated as `"N"`.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table for non-numeric variables represent the absolute numbers of patients and fraction of `N`.
#' * All-zero rows are not removed by default (see `prune_0` argument).
#'
#' @inheritParams argument_convention
#'
#' @return An `rtable` object.
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' advs <- random.cdisc.data::cadvs
#' advs$AVAL <- advs$AVAL - 100
#'
#' tbl <- make_table_33(advs = advs, alt_counts_df = adsl)
#' tbl
#'
#' @export
make_table_33 <- function(advs,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          id_var = "USUBJID",
                          arm_var = "ARM",
                          saffl_var = "SAFFL",
                          lbl_overall = NULL,
                          risk_diff = NULL,
                          prune_0 = FALSE,
                          annotations = NULL) {
  checkmate::assert_subset(c("AVISITN", "PARAMCD", "AVAL", "AVALU", arm_var, id_var, saffl_var), names(advs))
  assert_flag_variables(advs, saffl_var)

  advs <- advs %>%
    filter(
      .data[[saffl_var]] == "Y",
      AVISITN >= 1,
      PARAMCD %in% c("DIABP", "SYSBP")
    ) %>%
    group_by(.data[[id_var]], PARAMCD) %>%
    mutate(
      MAX_DIABP = if_else(PARAMCD == "DIABP", max(AVAL), NA_real_),
      MAX_SYSBP = if_else(PARAMCD == "SYSBP", max(AVAL), NA_real_)
    ) %>%
    ungroup() %>%
    mutate(
      SBP90 = formatters::with_label(PARAMCD == "SYSBP" & MAX_SYSBP < 90, "SBP <90"),
      DBP60 = formatters::with_label(PARAMCD == "DIABP" & MAX_DIABP < 60, "DBP <60")
    )

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df, id_var, arm_var, saffl_var)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by_arm(arm_var, lbl_overall, risk_diff) %>%
    count_patients_with_flags(
      var = id_var,
      flag_variables = c("SBP90", "DBP60"),
      riskdiff = !is.null(risk_diff)
    ) %>%
    append_topleft(c("Blood Pressure", paste0("(", unique(advs$AVALU)[1], ")")))

  tbl <- build_table(lyt, df = advs, alt_counts_df = alt_counts_df)
  if (prune_0) tbl <- prune_table(tbl)

  tbl
}

#' @describeIn make_table_33 Create FDA table 33 using functions from `gtsummary`.
#'
#' @return
#' * `make_table_33_gtsum` returns a `gt` object
#'
#' @examples
#' tbl <- make_table_33_gtsum(advs = advs)
#' tbl
#'
#' @export
make_table_33_gtsum <- function(advs,
                                adsl,
                                id_var = "USUBJID",
                                arm_var = "ARM",
                                saffl_var = "SAFFL",
                                lbl_overall = NULL) {
  checkmate::assert_subset(c(
    saffl_var, "AVISITN", "PARAMCD", "AVAL", "AVALU", arm_var, id_var
  ), names(advs))
  assert_flag_variables(advs, saffl_var)

  advs_all <- advs %>%
    filter(
      .data[[saffl_var]] == "Y",
      AVISITN >= 1,
      PARAMCD %in% c("DIABP", "SYSBP")
    ) %>%
    group_by(.data[[id_var]], PARAMCD) %>%
    mutate(
      MAX_DIABP = if_else(PARAMCD == "DIABP", max(AVAL), NA_real_),
      MAX_SYSBP = if_else(PARAMCD == "SYSBP", max(AVAL), NA_real_)
    ) %>%
    ungroup() %>%
    mutate(
      SBP90 = formatters::with_label(PARAMCD == "SYSBP" & MAX_SYSBP < 90, "SBP <90"),
      DBP60 = formatters::with_label(PARAMCD == "DIABP" & MAX_DIABP < 60, "DBP <60")
    )

  advs_diabp <- advs_all %>%
    filter(PARAMCD == "DIABP") %>%
    distinct(.data[[id_var]], .keep_all = TRUE) %>%
    select(all_of(id_var), DBP60, ARM, AVALU)

  advs_sysbp <- advs_all %>%
    filter(PARAMCD == "SYSBP") %>%
    distinct(.data[[id_var]], .keep_all = TRUE) %>%
    select(all_of(id_var), SBP90)

  advs_combined <-
    full_join(advs_diabp, advs_sysbp, by = "USUBJID") %>%
    select(SBP90, DBP60, ARM, AVALU)

  avalu <- unique(advs_combined$AVALU)[1]
  advs_combined <- advs_combined %>% select(-AVALU)

  tbl <- advs_combined %>%
    tbl_summary(
      by = arm_var,
      statistic = list(all_categorical() ~ "{n} ({p}%)"),
      digits = everything() ~ c(0, 1)
    ) %>%
    modify_header(label ~ paste0("**Blood Pressure (", avalu, ")**")) %>%
    modify_header(all_stat_cols() ~ "**{level}**  \nN = {n}") %>%
    gtsummary::modify_column_alignment(columns = all_stat_cols(), align = "right")

  if (!is.null(lbl_overall)) {
    tbl <- tbl %>%
      add_overall(last = TRUE, col_label = paste0("**", lbl_overall, "**  \n N = {n}"))
  }

  tbl <- tbl %>% modify_footnote(update = everything() ~ NA)

  gtsummary::with_gtsummary_theme(
    x = gtsummary::theme_gtsummary_compact(),
    expr = as_gt(tbl)
  )
}
