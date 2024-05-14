#' FDA Table 10: Patients With Serious Adverse Events by System Organ Class and
#'   FDA Medical Query (Narrow), Safety Population, Pooled Analyses
#'
#' @details
#' * `adae` must contain the variables `AEBODSYS`, `AESER`, and the variables specified by
#'   `arm_var`, `id_var`, `saffl_var`, `fmqsc_var`, and `fmqnam_var`.
#' * If specified, `alt_counts_df` must contain `id_var` and the variables specified by `arm_var` and `saffl_var`.
#' * `fmqsc_var` must contain "BROAD" or "NARROW" values, one of which will be displayed in the table. Narrow is
#'   selected by default (see `fmq_scope` argument).
#' * Flag variables (i.e. `XXXFL`) are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'   flag variables are treated as `"N"`.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table represent the absolute numbers of patients and fraction of `N`.
#' * All-zero rows are removed by default (see `prune_0` argument).
#'
#' @inheritParams argument_convention
#'
#' @return An `rtable` object.
#'
#' @examples
#' library(dplyr)
#'
#' adsl <- random.cdisc.data::cadsl
#' adae <- random.cdisc.data::cadae
#'
#' set.seed(1)
#' adae <- adae %>%
#'   rename(FMQ01SC = SMQ01SC) %>%
#'   mutate(
#'     AESER = sample(c("Y", "N"), size = nrow(adae), replace = TRUE),
#'     FMQ01NAM = sample(c("FMQ1", "FMQ2", "FMQ3"), size = nrow(adae), replace = TRUE)
#'   )
#' adae$FMQ01SC[is.na(adae$FMQ01SC)] <- "NARROW"
#'
#' tbl <- make_table_10(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' @export
make_table_10 <- function(adae,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          id_var = "USUBJID",
                          arm_var = "ARM",
                          saffl_var = "SAFFL",
                          soc_var = "AEBODSYS",
                          fmqsc_var = "FMQ01SC",
                          fmqnam_var = "FMQ01NAM",
                          fmq_scope = "NARROW",
                          lbl_overall = NULL,
                          risk_diff = NULL,
                          prune_0 = TRUE,
                          na_level = "<Missing>",
                          annotations = NULL) {
  checkmate::assert_subset(c(
    id_var, soc_var, "AESER", arm_var, saffl_var, fmqsc_var, fmqnam_var
  ), names(adae))
  assert_flag_variables(adae, c(saffl_var, "AESER"))
  assert_subset(toupper(fmq_scope), c("NARROW", "BROAD"))

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y", AESER == "Y", .data[[fmqsc_var]] == fmq_scope) %>%
    df_explicit_na(na_level = na_level)
  adae[[fmqnam_var]] <- with_label(adae[[fmqnam_var]], paste0("FMQ (", tools::toTitleCase(tolower(fmq_scope)), ")"))

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df, id_var, arm_var, saffl_var)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by_arm(arm_var, lbl_overall, risk_diff) %>%
    split_rows_by(
      soc_var,
      label_pos = "topleft",
      split_label = obj_label(adae$AEBODSYS)
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


#' @describeIn make_table_10 Create FDA table 10 using functions from `gtsummary`.
#'
#' @inheritParams argument_convention
#' @param saffl_var (`character`)\cr safety population flag variable from `adae` to include in the table.
#' @param ser_var (`character`)\cr serious Event variable from `adae` to include in the table.
#' @param soc_var (`character`)\cr system organ class variable from `adae` to include in the table.
#' @param lbl_soc_var (`character`)\cr label corresponding to system organ class variable
#' `soc_var` to print in the table.
#' @param annotations (named `list` of `character`)\cr list of annotations to add to the table. Valid
#'   annotation types are `title`, `subtitles`, and a list of characters called `footnotes`.
#'   Each name-value pair should use the annotation type as name and the desired string as the value.
#' @param risk_diff (`list` of `character` vectors)\cr List of character vectors. Each vector must be
#'   of length 2 and contain the name of treatment arms to calculate risk difference and its 95% CI for. Those names
#'   must exist in the `arm_var` column of the dataset specified in `adae`.
#'
#' @return
#' * `make_table_10_gtsum` returns a `gt_tbl` object.
#'
#' @examples
#' tbl <- make_table_10_gtsum(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' annotations <- list(
#'   title = "Table 10. Patients With Serious Adverse Events ",
#'   subtitle = "by System Organ Class and FDA Medical Query (Narrow),
#'   Safety Population, Pooled Analyses",
#'   footnotes = list(
#'     "Duration = [e.g., X week double-blind treatment period or median and a range
#'     indicating pooled trial durations]."
#'   )
#' )
#' tbl <- make_table_10_gtsum(adae,
#'   alt_counts_df = adsl,
#'   annotations = annotations
#' )
#' tbl
#'
#' @export
make_table_10_gtsum <- function(adae,
                                alt_counts_df = NULL,
                                show_colcounts = TRUE,
                                saffl_var = "SAFFL",
                                ser_var = "AESER",
                                arm_var = "ARM",
                                id_var = "USUBJID",
                                soc_var = "AEBODSYS",
                                fmqsc_var = "FMQ01SC",
                                fmqnam_var = "FMQ01NAM",
                                fmq_scope = "NARROW",
                                lbl_soc_var = formatters::var_labels(adae, fill = TRUE)[soc_var],
                                lbl_overall = NULL,
                                annotations = NULL) {
  checkmate::assert_data_frame(adae)
  checkmate::assert_subset(c(saffl_var, id_var, soc_var, fmqnam_var, arm_var), names(adae))
  assert_flag_variables(adae, saffl_var)
  checkmate::assert_factor(adae[[arm_var]])
  checkmate::assert_logical(show_colcounts)
  if (!is.null(alt_counts_df)) {
    checkmate::assert_data_frame(alt_counts_df)
    checkmate::assert_subset(c(id_var, arm_var), names(alt_counts_df))
  }

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y", .data[[ser_var]] == "Y", .data[[fmqsc_var]] == fmq_scope)

  gt_table <-
    # build primary table
    gtsummary::tbl_strata2(
      data = adae,
      strata = soc_var,
      ~ gtreg::tbl_ae(
        data = .x |> dplyr::mutate(!!soc_var := .y),
        strata = arm_var,
        id = id_var,
        soc = soc_var,
        ae = fmqnam_var,
        statistic = "{n} ({p}%)",
        id_df = alt_counts_df
      ) %>%
        {
          if (!is.null(lbl_overall)) gtreg::add_overall(., across = "strata") else .
        },
      .combine_with = "tbl_stack",
      .combine_args = list(group_header = NULL)
    ) |> # remove stats from SOC row
    gtsummary::modify_table_body(
      ~ .x |>
        dplyr::mutate(
          dplyr::across(
            gtsummary::all_stat_cols(),
            function(x) ifelse(.data$variable %in% "soc", "", x)
          )
        )
    ) |>
    gtsummary::modify_spanning_header(gtreg::all_ae_cols() ~ NA) |>
    # bold SOC rows
    gtsummary::modify_table_styling(
      columns = "label",
      rows = variable %in% "soc",
      text_format = "bold"
    )

  # update column headers
  if (show_colcounts) {
    gt_table <- gt_table |> gtsummary::modify_header(gtreg::all_ae_cols() ~ "**{strata}**  \nN = {n}")
  } else {
    gt_table <- gt_table |> gtsummary::modify_header(gtreg::all_ae_cols() ~ "**{strata}**")
  }

  # update overall column headers
  if (!is.null(lbl_overall)) {
    gt_table$table_styling$header <- gt_table$table_styling$header %>%
      mutate(label = ifelse(stringr::str_detect(column, "^stat_1") &
        stringr::str_detect(label, "\\*\\*Overall\\*\\*"),
      stringr::str_replace(label, "Overall", lbl_overall), label
      ))
  }

  # update column headers and annotations
  gt_table <- gt_table %>%
    gtsummary::as_gt() %>%
    gt::cols_label(label = gt::md(paste0(
      "**System Organ Class** <br>",
      "FMQ (", tools::toTitleCase(tolower(fmq_scope)), ")"
    )))

  if (!is.null(annotations)) {
    if (!is.null(annotations[["title"]])) {
      gt_table <- gt_table %>%
        gt::tab_header(annotations[["title"]])
    }
    if (!is.null(annotations[["subtitle"]])) {
      gt_table <- gt_table %>%
        gt::tab_header(annotations[["title"]], subtitle = annotations[["subtitle"]])
    }
    if (!is.null(annotations[["footnotes"]])) {
      lapply(annotations[["footnotes"]], function(x) {
        gt_table <<- gt_table %>%
          gt::tab_footnote(x)
      })
    }
  }

  gt_table
}
