# falcon 0.1.0.9053

### New Features
* Added new functions for creating standard FDA tables: `make_table_02`, `make_table_03`, `make_table_04`, `make_table_05`, 
  `make_table_06`, `make_table_07`, `make_table_08`, `make_table_09`, `make_table_10`, `make_table_11`, `make_table_12`, 
  `make_table_13`, `make_table_14`, `make_table_15`, `make_table_16`, `make_table_17`, `make_table_18`, `make_table_20`, 
  `make_table_21`, `make_table_22`, `make_table_32`, `make_table_33`, `make_table_34`, `make_table_35`, `make_table_36`.
* Added new functions for creating standard FDA figures: `make_fig_01`, `make_fig_02`, `make_fig_14`.
* Added helper functions used within table functions:
  * `basic_table_annot` for adding basic table annotations (titles, footnotes, column counts).
  * `split_cols_by_arm` for splitting columns by arm with option to add total column.
  * `alt_counts_df_preproc` for pre-processing the `alt_counts_df` dataset.
  * `assert_flag_variables` (internal) for checking that formatting is correct for flag variables in the data.
* Added new functions for creating standard FDA tables using additional packages: `make_table_02_tplyr`, `make_table_02_gtsum`,
  `make_table_09_gtsum`, `make_table_32_gtsum`.
* Added option to include risk difference columns in tables using the `split_cols_by_arm` function via the `risk_diff` argument.
* Added risk difference functionality into relevant table-generating functions via the `risk_diff` argument.
* Added new function for creating standard FDA tables using additional packages:  
`make_table_33_gtsum`.

### Miscellaneous
* Initialized the package.
* Developed Quarto website.
