#' Standard Arguments
#'
#' This documentation lists all the arguments in `falcon` that are used repeatedly by functions to output tables.
#'
#' @param show_colcounts (`flag`)\cr Whether column counts should be printed. Boolean.
#' @param arm_var (`character`)\cr Name of the treatment arm variable used to split table into columns.
#' @param id_var (`character`)\cr Name of the unique subject identifiers variable.
#' @param saffl_var (`character`)\cr Name of the safety flag variable which must contain at least "Y" for "Yes".
#' @param ser_var (`character`)\cr Name of the serious adverse event flag variable which must contain at least
#'   "Y" for "Yes".
#' @param lbl_overall (`character`)\cr Optional. If specified, an overall column will be added to the table with
#'   the given value as the column label.
#' @param vars (`vector` of `character`)\cr Variables from `df` to include in the table.
#' @param lbl_vars (`vector` of `character`)\cr Labels corresponding to variables in `vars` to print
#'   in the table. Labels should be ordered according to the order of variables in `vars`.
#' @param pref_var (`character`)\cr Name of the preferred term variable from `adae` to include in the table.
#' @param soc_var (`character`)\cr Name of the system organ class variable from `adae` to include in the table.
#' @param lbl_pref_var (`character`)\cr Label corresponding to preferred term variable `pref_var` to print in the table.
#' @param lbl_soc_var (`character`)\cr Label corresponding to system organ class variable `soc_var` to print in the
#'   table.
#' @param .stats (`character`)\cr Statistics to include in the table. Includes statistics for all variable
#'   types (only the statistics that are valid for a given variable's type will be printed).
#'   See [`tern::summarize_vars()`] for options.
#' @param .formats (named `list` of `character`)\cr List of formats corresponding to each value in `.stats`.
#'   Each name is a value in `.stats` and the corresponding value is the format that should be applied to
#'   that statistic. See [`formatters::list_valid_format_labels()`] for a list of valid formats.
#' @param na_rm (`flag`)\cr Whether `NA` levels should be removed from the table.
#' @param prune_0 (`flag`)\cr Whether all-zero rows should be removed from the table. Boolean.
#' @param annotations (named `list` of `character`)\cr List of annotations to add to the table. Valid
#'   annotation types are `title`, `subtitles`, `main_footer`, and `prov_footer`. Each name-value pair should
#'   use the annotation type as name and the desired string as value.
#' @param na_level (`character`)\cr String to represent missing values.
#' @param adae (`data.frame`)\cr dataset (typically ADAE) required to build table.
#' @param adex (`data.frame`)\cr dataset (typically ADEX) required to build table.
#' @param advs (`data.frame`)\cr dataset (typically ADVS) required to build table.
#' @param adsl (`data.frame`)\cr dataset (typically ADSL) required to build table.
#' @param alt_counts_df (`character`)\cr alternative dataset (typically ADSL) used only to calculate column counts.
#' @param annotations (named `list` of `character`)\cr list of annotations to add to the table. Valid
#'   annotation types are `title`, `subtitles`, `main_footer`, and `prov_footer`. Each name-value pair should
#'   use the annotation type as name and the desired string as value.
#' @param df (`data.frame`)\cr dataset required to build table.
#' @param eosdy_var (`character`)\cr variable denoting last recorded (relative) study day.
#' @param fmqsc_var (`character`)\cr FMQ scope variable to use in table.
#' @param fmqnam_var (`character`)\cr FMQ reference name variable to use in table.
#' @param fmq_scope (`character`)\cr FMQ scope ("NARROW" or "BROAD") to output in table.
#' @param ggtheme (`theme`)\cr a graphical theme as provided by `ggplot2` to control styling of the `ggplot` object.
#' @param id_var (`character`)\cr variable used as unique subject identifier.
#' @param lbl_overall (`character`)\cr if specified, an overall column will be added to the table with
#'   the given value as the column label.
#' @param lbl_pref_var (`character`)\cr label corresponding to preferred term variable `pref_var` to print in the table.
#' @param lbl_soc_var (`character`)\cr label corresponding to system organ class variable `soc_var` to print in the
#'   table.
#' @param lbl_vars (`vector` of `character`)\cr labels corresponding to variables in `vars` to print
#'   in the table. Labels should be ordered according to the order of variables in `vars`.
#' @param na_level (`character`)\cr string to represent missing values.
#' @param na_rm (`flag`)\cr whether `NA` levels should be removed from the table.
#' @param risk_diff (named `list`)\cr list of settings to apply to add one or more risk difference columns to the table.
#'   Defaults to `NULL` (no risk difference column added). See [tern::add_riskdiff()] for more details. List should
#'   contain the following elements:
#'    * `arm_x`: (required) the name of reference arm.
#'    * `arm_y`: (required) the names of the arms to compare to the reference arm. A new column will be added for each
#'      element of `arm_y`.
#'    * `col_label`: (optional) labels to use for the risk difference columns. Defaults to
#'      `"Risk Difference (%) (95% CI)"`. For more than one risk difference column, `"arm x vs. arm y"` text will also
#'      be included in the column labels by default. The length of `col_label` must be equal to the length of `arm_y`.
#'    * `pct`: (optional) whether the output should be returned as percentages. Defaults to `TRUE`.
#' @param saffl_var (`character`)\cr flag variable used to indicate inclusion in safety population.
#' @param sex_scope (`character`)\cr Level of `SEX` to output in table.
#' @param trtedtm_var (`character`)\cr treatment end datetime variable.
#' @param trtemfl_var (`character`)\cr flag variable used to identify Treatment-emergent AE.
#' @param trtsdtm_var (`character`)\cr treatment start datetime variable.
#' @param u_trtdur (`character`)\cr unit for duration of treatment. Options are `"days"`, `"weeks"`, `"months"`,
#'   and `"years"`.
#' @param xticks (`vector` of `numeric`)\cr x-axis tick positions. If `NA` (default), tick mark positions are
#'   automatically calculated.
#' @param x_lab (`character`)\cr x-axis label.
#' @param yticks (`vector` of `numeric`)\cr y-axis tick positions. If `NA` (default), tick mark positions are
#'   automatically calculated.
#' @param y_lab (`character`)\cr y-axis label.
#'
#' @name argument_convention
#' @keywords internal
NULL
