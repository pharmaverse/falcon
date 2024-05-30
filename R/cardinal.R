#' cardinal Package
#'
#' Implementation of FDA Safety Tables and Figures
#'
#' @keywords internal
"_PACKAGE"

#' @import dplyr ggplot2 checkmate gt gtsummary rtables tern tfrmt Tplyr
#' @importFrom rlang .data :=
#' @importFrom magrittr %>%
#' @importFrom purrr walk
#' @importFrom stats median sd quantile prop.test qt setNames
#' @importFrom tidyr pivot_longer separate_rows pivot_wider
#' @importFrom formatters with_label var_labels var_relabel
#' @importFrom rlistings as_listing
#' @importFrom cowplot plot_grid get_legend
NULL

# Fix R CMD check warning for missing global definitions
utils::globalVariables(c(
  ".", "AEACN", "AESCONG", "AESDISAB", "AESDTH", "AESER", "AESHOSP", "AESIFL", "AESLIFE", "AESMIE", "AGE",
  "AGESEX", "AVAL", "AVALU", "AVISITN", "DOSAGE", "DOSDUR", "DTHADY", "DTHCAT", "DTHCAUS", "DTHFL", "DCSREAS",
  "MAX_DIABP", "MAX_SYSBP", "PARAMCD", "SEX", "TRTDUR", "TRTDUR_MONTHS", "TRTEDT", "ASER", "DCTREAS",
  "EOSSTT", "EOTSTT", "ITTFL", "PPROTFL", "RANDFL", "TRTEMFL", "TRTSDT", "USUBJID", "column", "median", "ord_layer_1",
  "ord_layer_2", "ord_layer_index", "param", "pct", "row_label1", "row_label2", "sd", "tbl_lbl", "value",
  "ENRLDT", "RANDDT", "G110", "G60", "G90", "GE120", "L60", "N", "val", "id_var", "PT_PCT", "arm", "x", "TLSTFU",
  "se", "lower_ci", "upper_ci", "SBP90", "DBP60"
))
