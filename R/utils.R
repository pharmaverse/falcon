#' Initialize Table Layout with Annotations
#'
#' Initializes a table layout via [`rtables::basic_table()`] and applies `show_colcounts`
#' argument. Adds any annotations supplied via the `annotations` argument.
#'
#' @inheritParams argument_convention
#'
#' @return An `rtables` `PreDataTableLayouts` object suitable for passing to further layout functions, and
#'   to `build_table`.
#'
#' @examples
#' lyt <- basic_table_annot(annotations = list(title = "Title", main_footer = "Main Footer"))
#' rtables::build_table(lyt, df = data.frame())
#'
#' @export
basic_table_annot <- function(show_colcounts = TRUE, annotations = NULL) {
  basic_table(
    show_colcounts = show_colcounts,
    title = if (!is.null(annotations$title)) annotations$title else "",
    subtitles = if (!is.null(annotations$subtitles)) annotations$subtitles else character(),
    main_footer = if (!is.null(annotations$main_footer)) annotations$main_footer else character(),
    prov_footer = if (!is.null(annotations$prov_footer)) annotations$prov_footer else character()
  )
}

#' Split Columns by Arm Variable
#'
#' Splits `rtables` layout into columns by arm variable. Appends an "overall" column as the
#' rightmost column if `lbl_overall` is supplied.
#'
#' @inheritParams argument_convention
#' @param lyt (`rtables` layout object)\cr Layout object pre-data used for tabulation.
#'
#' @return An `rtables` `PreDataTableLayouts` object suitable for passing to further layout functions, and
#'   to `build_table`.
#'
#' @examples
#' library(magrittr)
#'
#' adsl <- random.cdisc.data::cadsl
#'
#' lyt <- rtables::basic_table() %>% split_cols_by_arm(lbl_overall = "All Arms")
#' rtables::build_table(lyt, df = adsl)
#'
#' @export
split_cols_by_arm <- function(lyt, arm_var = "ARM", lbl_overall = NULL, risk_diff = NULL) {
  if (is.null(risk_diff)) {
    spl_fun <- NULL
  } else {
    arm_x <- risk_diff$arm_x
    arm_y <- risk_diff$arm_y
    col_label <- if ("col_label" %in% names(risk_diff)) risk_diff$col_label else eval(formals(add_riskdiff)$col_label)
    pct <- if ("pct" %in% names(risk_diff)) risk_diff$pct else TRUE

    spl_fun <- add_riskdiff(arm_x = arm_x, arm_y = arm_y, col_label = col_label, pct = pct)
  }

  lyt <- lyt %>% split_cols_by(arm_var, split_fun = spl_fun)
  if (!is.null(lbl_overall)) lyt %>% add_overall_col(lbl_overall) else lyt
}

#' Pre-Process `alt_counts_df` for Safety Population
#'
#' If `alt_counts_df` is not `NULL`, will check for required variables (`arm_var`) and filter
#' to include only safety population (`saffl_var`, if specified), then apply [`tern::df_explicit_na()`].
#'
#' @inheritParams argument_convention
#'
#' @return A `data.frame` (modified `alt_counts_df`) or `NULL`.
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' alt_counts_df_preproc(adsl)
#'
#' @export
alt_counts_df_preproc <- function(alt_counts_df, id_var = "USUBJID", arm_var = "ARM", saffl_var = NULL) {
  if (!is.null(alt_counts_df)) {
    assert_subset(c(id_var, arm_var, saffl_var), names(alt_counts_df))
    if (!is.null(saffl_var)) {
      assert_flag_variables(alt_counts_df, saffl_var)
      alt_counts_df <- alt_counts_df %>% filter(.data[[saffl_var]] == "Y")
    }
    alt_counts_df %>% df_explicit_na()
  }
}

#' Check Values of Flag Variables
#'
#' Flag variables are expected to take one of two values: `"Y"` (yes/true) or
#' `"N"` (no/false). Missing values are also accepted and treated as `"N"`.
#'
#' @inheritParams argument_convention
#' @param flag_vars (`vector` of `character`)\cr names of flag variables within `df` to check.
#'
#' @return A `logical` indicating whether the given flag variables (`flag_vars`) in `df` are formatted correctly.
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' cardinal:::assert_flag_variables(adsl, c("SAFFL", "ITTFL"))
#'
#' @keywords internal
assert_flag_variables <- function(df, flag_vars, na_level = "<Missing>") {
  all(sapply(flag_vars, function(x) {
    expect_subset(
      as.character(unique(df[[x]])), c("Y", "N", "", NA, na_level),
      label = paste0("unique(df$", x, ")")
    )
  }) == "Y")
}
