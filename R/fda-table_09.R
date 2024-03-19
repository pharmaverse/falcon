#' FDA Table 9: Patients With Serious Adverse Events by System Organ Class and Preferred Term,
#'   Safety Population, Pooled Analyses
#'
#' @inheritParams argument_convention
#'
#' @name make_table_09
NULL


#' @describeIn make_table_09 Create FDA table 9 using functions from `rtables` and `tern`.
#'
#' @details
#' * `adae` must contain `AESER`, `AESOC`, and the variables specified by `pref_var`, `id_var`, `arm_var`,
#'   and `saffl_var`.
#' * If specified, `alt_counts_df` must contain the variables specified by `arm_var`, `id_var`, and `saffl_var`.
#' * Flag variables (i.e. `XXXFL`) are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'   flag variables are treated as `"N"`.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table represent the absolute numbers of patients and fraction of `N`.
#' * All-zero rows are removed by default (see `prune_0` argument).
#'
#' @return
#' * `make_table_09` returns an `rtables` table object.
#'
#' @return An `rtable` object.
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' adae <- random.cdisc.data::cadae
#'
#' tbl <- make_table_09(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' @export
make_table_09 <- function(adae,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          id_var = "USUBJID",
                          arm_var = "ARM",
                          saffl_var = "SAFFL",
                          pref_var = "AEDECOD",
                          lbl_pref_var = formatters::var_labels(adae, fill = TRUE)[pref_var],
                          lbl_overall = NULL,
                          risk_diff = NULL,
                          prune_0 = TRUE,
                          annotations = NULL) {
  checkmate::assert_subset(c("AESER", "AESOC", arm_var, id_var, saffl_var, pref_var), names(adae))
  assert_flag_variables(adae, saffl_var)

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y", AESER == "Y") %>%
    df_explicit_na()

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df, id_var, arm_var, saffl_var)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by_arm(arm_var, lbl_overall, risk_diff) %>%
    analyze_num_patients(
      vars = id_var,
      .stats = "unique",
      .labels = c(unique = "Any SAE"),
      riskdiff = !is.null(risk_diff)
    ) %>%
    split_rows_by(
      var = "AESOC",
      split_fun = drop_split_levels,
      split_label = "System Organ Class",
      label_pos = "topleft"
    ) %>%
    summarize_num_patients(
      var = id_var,
      .stats = "unique",
      .labels = c(unique = NULL),
      riskdiff = !is.null(risk_diff)
    ) %>%
    count_occurrences(
      vars = pref_var,
      riskdiff = !is.null(risk_diff)
    ) %>%
    append_topleft(paste(" ", lbl_pref_var))

  tbl <- build_table(lyt, df = adae, alt_counts_df = alt_counts_df)
  if (prune_0) tbl <- prune_table(tbl)

  tbl
}

#' @describeIn make_table_09 Create FDA table 9 using functions from `Tplyr`.
#'
#' @param risk_diff_pairs (`list` of `character` vectors)\cr Optional. List of character vectors. Each vector must be
#'   of length 2 and contain the name of treatment arms to calculate risk difference and its 95% CI for. Those names
#'   must exist in the `arm_var` column of the dataset specified in `adae`.
#' @param tplyr_raw (`flag`)\cr Boolean. Indicates whether the raw `tibble` created using `Tplyr` functions should be
#' returned or a presentation ready `gt_table` (default).
#'
#' @details
#' For `make_table_09_tplyr()`
#' * `adae` must contain the variables specified by `id_var`, `arm_var`, `saffl_var`, `ser_var`, `soc_var`, and
#'   `pref_var`.
#' * If specified, `alt_counts_df` must contain the variables specified by `id_var`, `saffl_var`, and `arm_var`.
#' * Flag variables are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'     flag variables are treated as `"N"`.
#' * Columns are split by the variable specified in `arm_var`. Overall population column is excluded by default
#'   (see `lbl_overall` argument).
#' * Numbers in the table represent the absolute numbers of patients and fraction of `N` (total number of patient in
#'   the safety population.
#' * All-zero rows are removed by default (see `prune_0` argument).
#' * Risk difference is calculated by using the default functionality of `Tplyr::add_risk_diff()`
#'
#'
#' @note
#' * `make_table_09_tplyr()` does not support annotations in case `tplyr_raw = TRUE`.
#' * `make_table_09_tplyr()` raises a warning in case `pref_var` or `soc_var` is a factor. Those can safely be ignored.
#' * `make_table_09_tplyr()` does not explicitly handle missings.
#'
#' @return
#' * `make_table_09_tplyr()` returns a `gt_tbl` object when `tplyr_raw = FALSE` (default) and
#'   a `tibble` object when `tplyr_raw = TRUE`.
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' adae <- random.cdisc.data::cadae
#'
#' # Basic table
#' make_table_09_tplyr(adae = adae, alt_counts_df = adsl)
#'
#' # Activate risk difference column
#' rd_pairs <- list(c("A: Drug X", "B: Placebo"), c("A: Drug X", "C: Combination"))
#' make_table_09_tplyr(adae = adae, alt_counts_df = adsl, risk_diff_pairs = rd_pairs)
#'
#' # Add overall column
#' make_table_09_tplyr(adae = adae, alt_counts_df = adsl, lbl_overall = "Total patients")
#'
#' # Add titles and footnotes
#' annot <- list(
#'   title = "Table 9. Patients with Serious Adverse Events by SOC and PT, Safety Population,
#'     Pooled Analyses",
#'   subtitles = c("Only one title, but", "multiple subtitles possible"),
#'   main_footer = c("Main footer 1", "Main footer 2"),
#'   prov_footer = c("Some more information", "E.g. a source note")
#' )
#' make_table_09_tplyr(adae = adae, alt_counts_df = adsl, annotations = annot)
#'
#' @import gt
#' @import checkmate
#' @export
make_table_09_tplyr <- function(
    adae,
    alt_counts_df = NULL,
    id_var = "USUBJID",
    arm_var = "ARM",
    saffl_var = "SAFFL",
    ser_var = "AESER",
    soc_var = "AESOC",
    pref_var = "AEDECOD",
    lbl_soc_var = "System Organ Class",
    lbl_pref_var = "Reported Term for Adverse Event",
    risk_diff_pairs = NULL,
    show_colcounts = TRUE,
    lbl_overall = NULL,
    prune_0 = TRUE,
    tplyr_raw = FALSE,
    annotations = NULL) {
  # Set instructions to activate/deactivate table components
  add_alt_counts <- ifelse(!is.null(alt_counts_df), TRUE, FALSE)
  add_overall_col <- ifelse(!is.null(lbl_overall), TRUE, FALSE)
  add_rd_col <- ifelse(!is.null(risk_diff_pairs), TRUE, FALSE)
  add_title <- ifelse(!is.null(annotations[["title"]]), TRUE, FALSE)
  add_subtitles <- ifelse(!is.null(annotations[["subtitles"]]), TRUE, FALSE)
  add_footnotes <- ifelse(!is.null(annotations[["main_footer"]]), TRUE, FALSE)
  add_source_notes <- ifelse(!is.null(annotations[["prov_footer"]]), TRUE, FALSE)

  # Check validity of input parameters
  assert_data_frame(adae)
  assert_string(id_var)
  assert_string(arm_var)
  assert_string(saffl_var)
  assert_string(ser_var)
  assert_string(soc_var)
  assert_string(pref_var)
  assert_subset(c(id_var, arm_var, saffl_var, ser_var, soc_var, pref_var), names(adae))
  assert_data_frame(alt_counts_df, null.ok = TRUE)
  if (add_alt_counts) assert_subset(c(id_var, arm_var), names(alt_counts_df))
  assert_string(lbl_overall, null.ok = TRUE)
  assert_string(lbl_pref_var, null.ok = TRUE)
  assert_string(lbl_soc_var, null.ok = TRUE)
  assert_list(risk_diff_pairs, types = "character", null.ok = TRUE)
  if (add_rd_col) {
    lapply(risk_diff_pairs, assert_vector, len = 2, any.missing = FALSE)
    lapply(risk_diff_pairs, function(vec) assert_true(all(vec %in% adae[[arm_var]])))
  }
  assert_logical(show_colcounts, len = 1)
  assert_logical(prune_0, len = 1)
  assert_logical(tplyr_raw, len = 1)
  assert_list(annotations, types = "character", null.ok = TRUE)
  if (!is.null(annotations)) {
    assert_names(names(annotations), subset.of = c("title", "subtitles", "main_footer", "prov_footer"))
  }

  # Initialize column headers -
  # Allow for both, character and factor. The advantage of the latter is that users have control about the order
  arm_names <- if (is.factor(adae[[arm_var]])) levels(adae[[arm_var]]) else unique(as.character(adae[[arm_var]]))

  header_string <- paste0(
    paste0(lbl_soc_var, " \n ", lbl_pref_var, "|"), # \\line
    paste0(
      if (show_colcounts) { # paste total counts to arm names
        paste(arm_names, "\n(N=**", arm_names, "**)", sep = "")
      } else { # use only arm names
        arm_names
      },
      collapse = "|"
    ) # \\line
  )

  # Initiate table structure
  structure <- Tplyr::tplyr_table(
    adae,
    treat_var = !!rlang::sym(arm_var),
    where = (!!rlang::sym(saffl_var) == "Y" & !!rlang::sym(ser_var) == "Y")
  )

  # Use alternative counts if specified
  if (add_alt_counts) {
    structure <- structure %>%
      Tplyr::set_pop_data(alt_counts_df) %>%
      Tplyr::set_pop_where(TRUE) # takes all subjects as basis, not only those where !!rlang::sym(ser_var) == "Y"!
  }

  # Add total column if specified
  if (add_overall_col) {
    structure <- structure %>%
      Tplyr::add_total_group(group_name = lbl_overall)

    header_string <- paste0(
      header_string, "|", lbl_overall,
      if (show_colcounts) paste0("\n(N=**", lbl_overall, "**)")
    )
  }

  # Create table layers
  layer1 <- structure %>%
    Tplyr::group_count("Any SAE") %>%
    Tplyr::set_distinct_by(!!rlang::sym(id_var))

  layer2 <- structure %>%
    Tplyr::group_count(vars(!!sym(soc_var), !!sym(pref_var))) %>%
    Tplyr::set_distinct_by(!!rlang::sym(id_var)) %>%
    Tplyr::set_nest_count(TRUE)

  # Add risk difference column(s) if specified
  if (add_rd_col) {
    layer1 <- do.call(Tplyr::add_risk_diff, args = append(list(layer = layer1), risk_diff_pairs))
    layer2 <- do.call(Tplyr::add_risk_diff, args = append(list(layer = layer2), risk_diff_pairs))

    rd_part <- sapply(risk_diff_pairs, function(pair) paste("|RD:", paste0(pair, collapse = " - ")))
    header_string <- paste0(header_string, paste0(rd_part, collapse = ""))
  }

  # Build table
  table <- structure %>%
    Tplyr::add_layers(layer1, layer2) %>%
    Tplyr::build() %>%
    suppressWarnings() # Artificially suppress Tplyr warning for nested factor variables

  # Remove "all zero"-rows if specified
  if (prune_0) {
    table <- table %>%
      mutate(across(starts_with("var"), ~ gsub("[0()\\%\\. ]", "", .x), .names = "detect_0_{.col}")) %>%
      filter(if_any(starts_with("detect_0"), ~ .x != ""))
  }

  # Adapt column order to arm order
  col_names <- names(table)
  arm_col_names <- paste0("var1_", arm_names)
  other_col_names <- col_names[!col_names %in% c(arm_col_names, "row_label1")]

  table <- table %>%
    select(all_of(c("row_label1", arm_col_names, other_col_names))) %>%
    mutate(ord_layer_2 = if_else(ord_layer_2 == Inf, 0, ord_layer_2)) # To avoid sorting of Inf in the next step

  # Clean-up table
  table <- table %>%
    arrange(ord_layer_index, ord_layer_1, ord_layer_2) %>% # refer to
    # https://atorus-research.github.io/Tplyr/articles/post_processing.html#highly-customized-sort-variables
    # for sorting according to occurrence in case this is required later
    select(starts_with(c("row_label", "var", "rdiff"))) %>%
    Tplyr::add_column_headers(s = header_string, header_n = Tplyr::header_n(structure))

  if (tplyr_raw) {
    return(table)
  }
  # else generate and return gt_tbl object as follows

  # Prepare for header row
  lbl_stubhead <- paste(lbl_soc_var, "<br/> &nbsp;&nbsp;", lbl_pref_var)
  lbl_cols <- gsub("\n", "<br/>", as.character(table[1, -1]))
  names(lbl_cols) <- colnames(table)[-1]

  # Trim prepending blank spaces from preferred term variable values
  pref_var_lvls <- unique(adae[[pref_var]])
  ind_prep_blank <- which(substr(pref_var_lvls, 1, 1) == " ")
  trmd_pref_var_lvls <- pref_var_lvls
  trmd_pref_var_lvls[ind_prep_blank] <- sub(" +", "", trmd_pref_var_lvls[ind_prep_blank])

  gt_tbl <- table[-1, ] %>% # drop header row
    mutate(
      # remove prepending blank spaces since they are ignored by gt
      row_label1 = if_else(substr(row_label1, 1, 1) == " ", sub(" +", "", row_label1), row_label1),
      # remove blank space between opening bracket and percentage number
      across(!row_label1, ~ sub("\\( +", "(", .x))
    ) %>%
    gt(rowname_col = "row_label1") %>%
    tab_stub_indent(any_of(trmd_pref_var_lvls), indent = 2) %>%
    tab_stubhead(md(lbl_stubhead)) %>%
    cols_label(.list = as.list(lbl_cols), .fn = md) %>%
    tab_header(
      title = if (add_title) md(annotations[["title"]]) else NULL,
      subtitle = if (add_subtitles) md(paste(annotations[["subtitles"]], collapse = "<br/>")) else NULL
    ) %>%
    tab_footnote(
      if (add_footnotes) md(paste(annotations[["main_footer"]], collapse = "<br/>")) else NULL
    ) %>%
    tab_source_note(
      if (add_source_notes) md(paste(annotations[["prov_footer"]], collapse = "<br/>")) else NULL
    )

  gt_tbl
}


#' Function to create FDA Table 9: Patients With Serious Adverse Events
#' by System Organ Class and Preferred Term,
#' Safety Population, Pooled Analyses with /code{gt}
#'
#' @describeIn make_table_09 Create FDA table 9 using functions from `gt`.
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
#' * `make_table_32_gtsum` returns a `gt` object
#'
#' @examples
#' adsl <- random.cdisc.data::cadsl
#' adae <- random.cdisc.data::cadae
#'
#' tbl <- make_table_09_gtsum(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' annotations <- list(
#'   title = "Table 9. Patients With Serious Adverse Events",
#'   subtitle = "by System Organ Class and Preferred Term, Safety Population, Pooled Analyses",
#'   footnotes = list(
#'     "Duration = [e.g., X week double-blind treatment period or median and a range
#'     indicating pooled trial durations].",
#'     "Difference is shown between [treatment arms] (e.g., difference is shown
#'     between Drug Name dosage X vs. placebo)."
#'   )
#' )
#' risk_diff <- list(c("A: Drug X", "C: Combination"), c("A: Drug X", "B: Placebo"))
#' tbl <- make_table_09_gtsum(
#'   adae = adae, alt_counts_df = adsl, annotations = annotations,
#'   risk_diff = risk_diff
#' )
#' tbl
#' @export
make_table_09_gtsum <- function(adae,
                                alt_counts_df = NULL,
                                show_colcounts = TRUE,
                                saffl_var = "SAFFL",
                                ser_var = "AESER",
                                arm_var = "ARM",
                                pref_var = "AEDECOD",
                                id_var = "USUBJID",
                                soc_var = "AESOC",
                                lbl_pref_var = formatters::var_labels(adae, fill = TRUE)[pref_var],
                                lbl_soc_var = formatters::var_labels(adae, fill = TRUE)[soc_var],
                                lbl_overall = NULL,
                                annotations = NULL,
                                risk_diff = NULL) {
  checkmate::assert_data_frame(adae)
  checkmate::assert_subset(c(saffl_var, id_var, ser_var, soc_var, arm_var, pref_var), names(adae))
  assert_flag_variables(adae, saffl_var)
  checkmate::assert_factor(adae[[arm_var]])

  if (!is.null(alt_counts_df)) {
    checkmate::assert_data_frame(alt_counts_df)
    checkmate::assert_subset(c(id_var, arm_var), names(alt_counts_df))
  }

  checkmate::assert_list(risk_diff, types = "character", null.ok = TRUE)

  checkmate::assert_logical(show_colcounts)

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y", .data[[ser_var]] == "Y")

  # create data for table 09
  # lbl_overall must be NULL to get the data for all columns besides the overall column
  result_list <- create_table_09_data(
    adae = adae,
    alt_counts_df = alt_counts_df,
    arm_var = arm_var,
    id_var = id_var,
    soc_var = soc_var,
    pref_var = pref_var,
    lbl_overall = NULL,
    risk_diff = risk_diff
  )

  # create data for overall column
  if (!is.null(lbl_overall)) {
    overall_list <- create_table_09_data(
      adae = adae,
      alt_counts_df = alt_counts_df,
      arm_var = arm_var,
      id_var = id_var,
      soc_var = soc_var,
      pref_var = pref_var,
      lbl_overall = lbl_overall,
      risk_diff = NULL
    )

    result_list$data <- result_list[["data"]] %>%
      left_join(overall_list[["data"]], by = join_by(!!sym(soc_var), !!sym(pref_var)))

    result_list$total_N <- result_list[["total_N"]] %>%
      cross_join(overall_list[["total_N"]])
  }

  result_data <- result_list[["data"]]

  rows_to_indent <- which(!is.na(result_data[[pref_var]]))

  result_data <- result_data %>%
    mutate(
      !!soc_var := if_else(is.na(.data[[soc_var]]), "Any SAE", .data[[soc_var]]),
      !!pref_var := if_else(is.na(.data[[pref_var]]), .data[[soc_var]], .data[[pref_var]])
    ) %>%
    select(-any_of(soc_var))

  gt_table <- result_data %>%
    gt(
      rowname_col = pref_var
    ) %>%
    tab_stub_indent(rows = rows_to_indent, indent = 2)


  if (show_colcounts) {
    total_N <- result_list[["total_N"]] # nolint

    set_col_labels <- function(x) {
      if (startsWith(x, "rd_")) {
        html(paste0("Risk Difference <br/>", substr(x, 4, nchar(x)), "<br/> (%) (95% CI)"))
      } else {
        html(paste0(x, "<br/>(N=", total_N[[x]], ")"))
      }
    }

    gt_table <- gt_table %>%
      cols_label_with(fn = set_col_labels)
  }


  label <- paste(lbl_soc_var, "<br/> &nbsp;&nbsp;", lbl_pref_var)

  gt_table <- gt_table %>%
    tab_stubhead(label = md(label)) %>%
    cols_align(align = "center", columns = -1) # center all columns besides the first

  if (!is.null(annotations)) {
    if (!is.null(annotations[["title"]])) {
      gt_table <- gt_table %>%
        tab_header(annotations[["title"]])
    }
    if (!is.null(annotations[["subtitle"]])) {
      gt_table <- gt_table %>%
        tab_header(annotations[["title"]], subtitle = annotations[["subtitle"]])
    }
    if (!is.null(annotations[["footnotes"]])) {
      lapply(annotations[["footnotes"]], function(x) {
        gt_table <<- gt_table %>%
          tab_footnote(x)
      })
    }
  }

  gt_table
}


#' Helper function to create the data for `make_table09_gtsum()`
#'
#' @details If `lbl_overall` is not `NULL` only the data for the overall column will be generated
#'
#' @inheritParams argument_convention
#' @inheritParams make_table_09_gtsum
#'
#' @return list containing the counted data to be displayed for table 9 and
#' a `data.frame` containing information about the total N for each group
create_table_09_data <- function(
    adae,
    alt_counts_df,
    arm_var,
    id_var,
    soc_var,
    pref_var,
    lbl_overall = NULL,
    risk_diff = NULL) {
  basis_df <- if (!is.null(alt_counts_df)) alt_counts_df else adae
  N_data <- basis_df %>% # nolint
    {
      if (is.null(lbl_overall)) group_by(., .data[[arm_var]]) else .
    } %>%
    mutate(N = n()) %>% # count observations
    ungroup() %>%
    select(all_of(c(id_var, arm_var, "N")))

  # get total N
  total_N <- N_data %>% # nolint
    {
      if (is.null(lbl_overall)) group_by(., .data[[arm_var]]) else .
    } %>%
    distinct(N) %>%
    {
      if (is.null(lbl_overall)) {
        pivot_wider(.,
          names_from = all_of(arm_var),
          values_from = N
        )
      } else {
        rename(., !!lbl_overall := "N")
      }
    }

  adae <- adae %>%
    left_join(N_data, by = c(id_var, arm_var), relationship = "many-to-many")

  input_list <- list(NULL, soc_var, c(soc_var, pref_var))

  data_list <- lapply(input_list, function(x) {
    count_subjects(
      adae = adae,
      arm_var = arm_var,
      id_var = id_var,
      sub_level_vars = x,
      lbl_overall = lbl_overall,
      risk_diff = risk_diff
    )
  })

  sel_cols <- if (is.null(lbl_overall)) levels(N_data[[arm_var]]) else lbl_overall
  if (!is.null(risk_diff)) {
    risk_diff_cols <- sapply(risk_diff, function(x) {
      paste0("rd_", x[[1]], "-", x[[2]])
    })
    sel_cols <- c(sel_cols, risk_diff_cols)
  }

  result_data <- data_list %>%
    bind_rows() %>%
    select(all_of(c(soc_var, pref_var, sel_cols))) %>%
    arrange(desc(is.na(.data[[soc_var]])), .data[[soc_var]], desc(is.na(.data[[pref_var]])))

  list(data = result_data, total_N = total_N)
}

#' Helper function for `create_table_09_data()`
#' Used for counting subjects per group
#'
#' @inheritParams argument_convention
#' @param sub_level_vars (`NULL` or `character`) specifying the sub group for counted subjects
#'
#' @return A `data.frame` containing the number of subjects with `sub_level_vars` events
count_subjects <- function(adae, arm_var, id_var, sub_level_vars = NULL, lbl_overall = NULL, risk_diff = NULL) {
  grouping <- is.null(lbl_overall)
  if (grouping) {
    if (!is.null(sub_level_vars)) {
      grouping_vars <- c(arm_var, sub_level_vars)
    } else {
      grouping_vars <- arm_var
    }
  } else {
    if (!is.null(sub_level_vars)) {
      grouping_vars <- sub_level_vars
    }
  }

  count_data <- adae %>%
    {
      if (grouping || !is.null(sub_level_vars)) group_by(., across(all_of(grouping_vars))) else .
    } %>%
    summarize(
      val = n_distinct(.data[[id_var]]), # count on patient level
      N = unique(N),
      pct = format(val / mean(N) * 100, digits = 1, nsmall = 1),
      combined = paste0(val, " (", pct, "%)"),
      .groups = "drop"
    ) %>%
    {
      if (grouping) {
        pivot_wider(.,
          id_cols = all_of(sub_level_vars),
          names_from = all_of(arm_var),
          values_from = all_of(c("val", "N", "combined"))
        )
      } else {
        rename(., !!lbl_overall := "combined") %>%
          select(-c("val", "pct"))
      }
    }

  if (!is.null(risk_diff)) {
    purrr::walk(risk_diff, function(x) {
      count_data <<- count_data %>%
        mutate(
          !!paste0("rd_", x[[1]], "-", x[[2]]) := calculate_riskdiff(
            .data[[paste0("val_", x[[1]])]],
            .data[[paste0("val_", x[[2]])]],
            .data[[paste0("N_", x[[1]])]],
            .data[[paste0("N_", x[[2]])]]
          )
        )
    })
  }
  if (grouping) {
    count_data <- count_data %>%
      rename_with(renaming_function, dplyr::starts_with("combined")) %>%
      select(-any_of(c(starts_with("val_"), starts_with("N_"))))
  }
  count_data
}


#' Helper function to rename the combined columns
#'
#' @param x character vector containing all column names which start with "combined"
#'
renaming_function <- function(x) {
  sapply(x, function(y) {
    substr(y, 10, nchar(y))
  }, simplify = TRUE)
}


#' helper function to calculate the risk difference for table 9
#'
#' @param x character vector containing all value for the first treatment
#' @param y character vector containing all value for the second treatment
#' @param n_x character vector containing for all values of x the corresponding N
#' @param n_y character vector containing for all values of y the corresponding N
#'
#' @return vector of characters containing the value for risk difference and
#' the corresponding 95% Confidence interval in Brackets
calculate_riskdiff <- function(x, y, n_x, n_y) {
  sapply(seq_along(x), function(i) {
    pt <- stats::prop.test(c(x[[i]], y[[i]]), c(n_x[[i]], n_y[[i]]))
    val <- format(pt$estimate[[1]] - pt$estimate[[2]], digits = 2, nsmall = 2)
    conf_int <- format(pt$conf.int, digits = 2, nsmall = 2)
    paste0(val, " (", conf_int[[1]], ", ", conf_int[[2]], ")")
  })
}
