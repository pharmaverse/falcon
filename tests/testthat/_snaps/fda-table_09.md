# Table 09 generation works with default values

    Code
      res
    Output
      System Organ Class           A: Drug X    B: Placebo    C: Combination
        Dictionary-Derived Term     (N=134)       (N=134)        (N=132)    
      ——————————————————————————————————————————————————————————————————————
      Any SAE                     104 (77.6%)   101 (75.4%)     99 (75.0%)  
      cl A                        48 (35.8%)    48 (35.8%)      50 (37.9%)  
        dcd A.1.1.1.2             48 (35.8%)    48 (35.8%)      50 (37.9%)  
      cl B                        79 (59.0%)    78 (58.2%)      76 (57.6%)  
        dcd B.1.1.1.1             47 (35.1%)    49 (36.6%)      43 (32.6%)  
        dcd B.2.2.3.1             48 (35.8%)    54 (40.3%)      51 (38.6%)  
      cl D                        50 (37.3%)    42 (31.3%)      51 (38.6%)  
        dcd D.1.1.1.1             50 (37.3%)    42 (31.3%)      51 (38.6%)  

# Table 09 generation works with custom values

    Code
      res
    Output
      Table 9. Patients With Serious Adverse Events(1) by System Organ Class and Preferred Term, Safety Population, Pooled Analyses(2)
      
      ————————————————————————————————————————————————————————————————————————————————————
      System Organ Class           A: Drug X    B: Placebo    C: Combination      Total   
        Dictionary-Derived Term     (N=134)       (N=134)        (N=132)         (N=400)  
      ————————————————————————————————————————————————————————————————————————————————————
      Any SAE                     104 (77.6%)   101 (75.4%)     99 (75.0%)     304 (76.0%)
      cl A                        48 (35.8%)    48 (35.8%)      50 (37.9%)     146 (36.5%)
        dcd A.1.1.1.2             48 (35.8%)    48 (35.8%)      50 (37.9%)     146 (36.5%)
      cl B                        79 (59.0%)    78 (58.2%)      76 (57.6%)     233 (58.2%)
        dcd B.1.1.1.1             47 (35.1%)    49 (36.6%)      43 (32.6%)     139 (34.8%)
        dcd B.2.2.3.1             48 (35.8%)    54 (40.3%)      51 (38.6%)     153 (38.2%)
      cl D                        50 (37.3%)    42 (31.3%)      51 (38.6%)     143 (35.8%)
        dcd D.1.1.1.1             50 (37.3%)    42 (31.3%)      51 (38.6%)     143 (35.8%)
      ————————————————————————————————————————————————————————————————————————————————————
      
      Source: [include Applicant source, datasets and/or software tools used].
      (1) Defined as any untoward medical occurrence that, at any dose that results in death, is life-threatening,
      requires hospitalization or prolongation of existing hospitalization, results in persistent incapacity or
      substantial disruption of the ability to conduct normal life functions, or is a congenital anomaly or
      birth defect.
      (2) Duration = [e.g., X week double-blind treatment period or median and
      a range indicating pooled trial durations].
      
      Abbreviations: AE, adverse event; CI, confidence interval; N, number of patients in treatment arm;
      n, number of patients with adverse event; PT, preferred term; SAE, serious adverse event;
      SOC, System Organ Class

# Table 09 (gt) generation works with risk difference column

    Code
      res
    Output
      System Organ Class           A: Drug X    B: Placebo    C: Combination   Risk Difference (%) (95% CI)
        Dictionary-Derived Term     (N=134)       (N=134)        (N=132)                 (N=268)           
      —————————————————————————————————————————————————————————————————————————————————————————————————————
      Any SAE                     104 (77.6%)   101 (75.4%)     99 (75.0%)          -2.2 (-12.4 - 7.9)     
      cl A                        48 (35.8%)    48 (35.8%)      50 (37.9%)          0.0 (-11.5 - 11.5)     
        dcd A.1.1.1.2             48 (35.8%)    48 (35.8%)      50 (37.9%)          0.0 (-11.5 - 11.5)     
      cl B                        79 (59.0%)    78 (58.2%)      76 (57.6%)         -0.7 (-12.5 - 11.0)     
        dcd B.1.1.1.1             47 (35.1%)    49 (36.6%)      43 (32.6%)          1.5 (-10.0 - 13.0)     
        dcd B.2.2.3.1             48 (35.8%)    54 (40.3%)      51 (38.6%)          4.5 (-7.1 - 16.1)      
      cl D                        50 (37.3%)    42 (31.3%)      51 (38.6%)          -6.0 (-17.3 - 5.4)     
        dcd D.1.1.1.1             50 (37.3%)    42 (31.3%)      51 (38.6%)          -6.0 (-17.3 - 5.4)     

# Table 09 (gt) generation works with default values

    Code
      res
    Output
      $data
      # A tibble: 8 x 4
        AEDECOD       `A: Drug X` `B: Placebo` `C: Combination`
        <chr>         <chr>       <chr>        <chr>           
      1 Any SAE       104 (41.8%) 101 (39.6%)  99 (35.1%)      
      2 cl A          48 (19.3%)  48 (18.8%)   50 (17.7%)      
      3 dcd A.1.1.1.2 48 (19.3%)  48 (18.8%)   50 (17.7%)      
      4 cl B          79 (31.7%)  78 (30.6%)   76 (27.0%)      
      5 dcd B.1.1.1.1 47 (18.9%)  49 (19.2%)   43 (15.2%)      
      6 dcd B.2.2.3.1 48 (19.3%)  54 (21.2%)   51 (18.1%)      
      7 cl D          50 (20.1%)  42 (16.5%)   51 (18.1%)      
      8 dcd D.1.1.1.1 50 (20.1%)  42 (16.5%)   51 (18.1%)      
      
      $column_label
      $column_label[[1]]
      [1] "AEDECOD"
      
      $column_label[[2]]
      A: Drug X<br/>(N=249)
      
      $column_label[[3]]
      B: Placebo<br/>(N=255)
      
      $column_label[[4]]
      C: Combination<br/>(N=282)
      
      
      $header
      $header$title
      NULL
      
      $header$subtitle
      NULL
      
      $header$preheader
      NULL
      
      
      $footnotes
      list()
      

# Table 09 (gt) generation works with custom values

    Code
      res
    Output
      $data
      # A tibble: 8 x 7
        AEDECOD       `A: Drug X` `B: Placebo` `C: Combination` rd_A: Drug X-C: Comb~1
        <chr>         <chr>       <chr>        <chr>            <chr>                 
      1 Any SAE       104 (77.6%) 101 (75.4%)  99 (75.0%)       0.026 (-0.084,  0.136)
      2 cl A          48 (35.8%)  48 (35.8%)   50 (37.9%)       -0.021 (-0.14,  0.10) 
      3 dcd A.1.1.1.2 48 (35.8%)  48 (35.8%)   50 (37.9%)       -0.021 (-0.14,  0.10) 
      4 cl B          79 (59.0%)  78 (58.2%)   76 (57.6%)       0.014 (-0.11,  0.14)  
      5 dcd B.1.1.1.1 47 (35.1%)  49 (36.6%)   43 (32.6%)       0.025 (-0.096,  0.146)
      6 dcd B.2.2.3.1 48 (35.8%)  54 (40.3%)   51 (38.6%)       -0.028 (-0.152,  0.09~
      7 cl D          50 (37.3%)  42 (31.3%)   51 (38.6%)       -0.013 (-0.14,  0.11) 
      8 dcd D.1.1.1.1 50 (37.3%)  42 (31.3%)   51 (38.6%)       -0.013 (-0.14,  0.11) 
      # i abbreviated name: 1: `rd_A: Drug X-C: Combination`
      # i 2 more variables: `rd_A: Drug X-B: Placebo` <chr>, Total <chr>
      
      $column_label
      $column_label[[1]]
      [1] "AEDECOD"
      
      $column_label[[2]]
      A: Drug X<br/>(N=134)
      
      $column_label[[3]]
      B: Placebo<br/>(N=134)
      
      $column_label[[4]]
      C: Combination<br/>(N=132)
      
      $column_label[[5]]
      Risk Difference <br/>A: Drug X-C: Combination<br/> (%) (95% CI)
      
      $column_label[[6]]
      Risk Difference <br/>A: Drug X-B: Placebo<br/> (%) (95% CI)
      
      $column_label[[7]]
      Total<br/>(N=400)
      
      
      $header
      $header$title
      [1] "Table 9. Patients With Serious Adverse Events"
      
      $header$subtitle
      [1] "by System Organ Class and Preferred Term, Safety Population, Pooled Analyses"
      
      $header$preheader
      NULL
      
      
      $footnotes
      $footnotes[[1]]
      [1] "Duration = [e.g., X week double-blind treatment period or median and a range indicating\n      pooled trial durations]."
      
      $footnotes[[2]]
      [1] "Difference is shown between [treatment arms] (e.g., difference is shown between Drug Name dosage X vs. placebo)."
      
      

# make_table_09_tplyr() returns a tibble when tplyr_raw = TRUE

    Code
      tbl_out
    Output
      # A tibble: 9 x 4
        row_label1            `var1_A: Drug X` `var1_B: Placebo` `var1_C: Combination`
        <chr>                 <chr>            <chr>             <chr>                
      1 "System Organ Class ~ "A: Drug X\n(N=~ "B: Placebo\n(N=~ "C: Combination\n(N=~
      2 "Any SAE"             "104 (100.0%)"   "101 (100.0%)"    " 99 (100.0%)"       
      3 "cl A"                " 48 ( 46.2%)"   " 48 ( 47.5%)"    " 50 ( 50.5%)"       
      4 "   dcd A.1.1.1.2"    " 48 ( 46.2%)"   " 48 ( 47.5%)"    " 50 ( 50.5%)"       
      5 "cl B"                " 79 ( 76.0%)"   " 78 ( 77.2%)"    " 76 ( 76.8%)"       
      6 "   dcd B.1.1.1.1"    " 47 ( 45.2%)"   " 49 ( 48.5%)"    " 43 ( 43.4%)"       
      7 "   dcd B.2.2.3.1"    " 48 ( 46.2%)"   " 54 ( 53.5%)"    " 51 ( 51.5%)"       
      8 "cl D"                " 50 ( 48.1%)"   " 42 ( 41.6%)"    " 51 ( 51.5%)"       
      9 "   dcd D.1.1.1.1"    " 50 ( 48.1%)"   " 42 ( 41.6%)"    " 51 ( 51.5%)"       

# make_table_09_tplyr() returns a gt object when tplyr_raw = FALSE

    Code
      tbl_out
    Output
      <div id="igwsvrzpkj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
        <style>#igwsvrzpkj table {
        font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }
      
      #igwsvrzpkj thead, #igwsvrzpkj tbody, #igwsvrzpkj tfoot, #igwsvrzpkj tr, #igwsvrzpkj td, #igwsvrzpkj th {
        border-style: none;
      }
      
      #igwsvrzpkj p {
        margin: 0;
        padding: 0;
      }
      
      #igwsvrzpkj .gt_table {
        display: table;
        border-collapse: collapse;
        line-height: normal;
        margin-left: auto;
        margin-right: auto;
        color: #333333;
        font-size: 16px;
        font-weight: normal;
        font-style: normal;
        background-color: #FFFFFF;
        width: auto;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #A8A8A8;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #A8A8A8;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_caption {
        padding-top: 4px;
        padding-bottom: 4px;
      }
      
      #igwsvrzpkj .gt_title {
        color: #333333;
        font-size: 125%;
        font-weight: initial;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 5px;
        border-bottom-color: #FFFFFF;
        border-bottom-width: 0;
      }
      
      #igwsvrzpkj .gt_subtitle {
        color: #333333;
        font-size: 85%;
        font-weight: initial;
        padding-top: 3px;
        padding-bottom: 5px;
        padding-left: 5px;
        padding-right: 5px;
        border-top-color: #FFFFFF;
        border-top-width: 0;
      }
      
      #igwsvrzpkj .gt_heading {
        background-color: #FFFFFF;
        text-align: center;
        border-bottom-color: #FFFFFF;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_bottom_border {
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_col_headings {
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_col_heading {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: normal;
        text-transform: inherit;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: bottom;
        padding-top: 5px;
        padding-bottom: 6px;
        padding-left: 5px;
        padding-right: 5px;
        overflow-x: hidden;
      }
      
      #igwsvrzpkj .gt_column_spanner_outer {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: normal;
        text-transform: inherit;
        padding-top: 0;
        padding-bottom: 0;
        padding-left: 4px;
        padding-right: 4px;
      }
      
      #igwsvrzpkj .gt_column_spanner_outer:first-child {
        padding-left: 0;
      }
      
      #igwsvrzpkj .gt_column_spanner_outer:last-child {
        padding-right: 0;
      }
      
      #igwsvrzpkj .gt_column_spanner {
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        vertical-align: bottom;
        padding-top: 5px;
        padding-bottom: 5px;
        overflow-x: hidden;
        display: inline-block;
        width: 100%;
      }
      
      #igwsvrzpkj .gt_spanner_row {
        border-bottom-style: hidden;
      }
      
      #igwsvrzpkj .gt_group_heading {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: middle;
        text-align: left;
      }
      
      #igwsvrzpkj .gt_empty_group_heading {
        padding: 0.5px;
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        vertical-align: middle;
      }
      
      #igwsvrzpkj .gt_from_md > :first-child {
        margin-top: 0;
      }
      
      #igwsvrzpkj .gt_from_md > :last-child {
        margin-bottom: 0;
      }
      
      #igwsvrzpkj .gt_row {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        margin: 10px;
        border-top-style: solid;
        border-top-width: 1px;
        border-top-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 1px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 1px;
        border-right-color: #D3D3D3;
        vertical-align: middle;
        overflow-x: hidden;
      }
      
      #igwsvrzpkj .gt_stub {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-right-style: solid;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #igwsvrzpkj .gt_stub_row_group {
        color: #333333;
        background-color: #FFFFFF;
        font-size: 100%;
        font-weight: initial;
        text-transform: inherit;
        border-right-style: solid;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
        padding-left: 5px;
        padding-right: 5px;
        vertical-align: top;
      }
      
      #igwsvrzpkj .gt_row_group_first td {
        border-top-width: 2px;
      }
      
      #igwsvrzpkj .gt_row_group_first th {
        border-top-width: 2px;
      }
      
      #igwsvrzpkj .gt_summary_row {
        color: #333333;
        background-color: #FFFFFF;
        text-transform: inherit;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #igwsvrzpkj .gt_first_summary_row {
        border-top-style: solid;
        border-top-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_first_summary_row.thick {
        border-top-width: 2px;
      }
      
      #igwsvrzpkj .gt_last_summary_row {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_grand_summary_row {
        color: #333333;
        background-color: #FFFFFF;
        text-transform: inherit;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #igwsvrzpkj .gt_first_grand_summary_row {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        border-top-style: double;
        border-top-width: 6px;
        border-top-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_last_grand_summary_row_top {
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 5px;
        padding-right: 5px;
        border-bottom-style: double;
        border-bottom-width: 6px;
        border-bottom-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_striped {
        background-color: rgba(128, 128, 128, 0.05);
      }
      
      #igwsvrzpkj .gt_table_body {
        border-top-style: solid;
        border-top-width: 2px;
        border-top-color: #D3D3D3;
        border-bottom-style: solid;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_footnotes {
        color: #333333;
        background-color: #FFFFFF;
        border-bottom-style: none;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_footnote {
        margin: 0px;
        font-size: 90%;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #igwsvrzpkj .gt_sourcenotes {
        color: #333333;
        background-color: #FFFFFF;
        border-bottom-style: none;
        border-bottom-width: 2px;
        border-bottom-color: #D3D3D3;
        border-left-style: none;
        border-left-width: 2px;
        border-left-color: #D3D3D3;
        border-right-style: none;
        border-right-width: 2px;
        border-right-color: #D3D3D3;
      }
      
      #igwsvrzpkj .gt_sourcenote {
        font-size: 90%;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-left: 5px;
        padding-right: 5px;
      }
      
      #igwsvrzpkj .gt_left {
        text-align: left;
      }
      
      #igwsvrzpkj .gt_center {
        text-align: center;
      }
      
      #igwsvrzpkj .gt_right {
        text-align: right;
        font-variant-numeric: tabular-nums;
      }
      
      #igwsvrzpkj .gt_font_normal {
        font-weight: normal;
      }
      
      #igwsvrzpkj .gt_font_bold {
        font-weight: bold;
      }
      
      #igwsvrzpkj .gt_font_italic {
        font-style: italic;
      }
      
      #igwsvrzpkj .gt_super {
        font-size: 65%;
      }
      
      #igwsvrzpkj .gt_footnote_marks {
        font-size: 75%;
        vertical-align: 0.4em;
        position: initial;
      }
      
      #igwsvrzpkj .gt_asterisk {
        font-size: 100%;
        vertical-align: 0;
      }
      
      #igwsvrzpkj .gt_indent_1 {
        text-indent: 5px;
      }
      
      #igwsvrzpkj .gt_indent_2 {
        text-indent: 10px;
      }
      
      #igwsvrzpkj .gt_indent_3 {
        text-indent: 15px;
      }
      
      #igwsvrzpkj .gt_indent_4 {
        text-indent: 20px;
      }
      
      #igwsvrzpkj .gt_indent_5 {
        text-indent: 25px;
      }
      </style>
        <table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
        <thead>
          
          <tr class="gt_col_headings">
            <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="System Organ Class &lt;br/&gt;    Reported Term for Adverse Event">System Organ Class <br/>    Reported Term for Adverse Event</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="A: Drug X&lt;br/&gt;(N=249)">A: Drug X<br/>(N=249)</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="B: Placebo&lt;br/&gt;(N=255)">B: Placebo<br/>(N=255)</th>
            <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="C: Combination&lt;br/&gt;(N=282)">C: Combination<br/>(N=282)</th>
          </tr>
        </thead>
        <tbody class="gt_table_body">
          <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">Any SAE</th>
      <td headers="stub_1_1 var1_A: Drug X" class="gt_row gt_right">104 (100.0%)</td>
      <td headers="stub_1_1 var1_B: Placebo" class="gt_row gt_right">101 (100.0%)</td>
      <td headers="stub_1_1 var1_C: Combination" class="gt_row gt_right"> 99 (100.0%)</td></tr>
          <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub">cl A</th>
      <td headers="stub_1_2 var1_A: Drug X" class="gt_row gt_right"> 48 (46.2%)</td>
      <td headers="stub_1_2 var1_B: Placebo" class="gt_row gt_right"> 48 (47.5%)</td>
      <td headers="stub_1_2 var1_C: Combination" class="gt_row gt_right"> 50 (50.5%)</td></tr>
          <tr><td headers="stub_1_3 stub_1" class="gt_row gt_left gt_stub gt_indent_2">dcd A.1.1.1.2</td>
      <td headers="stub_1_3 var1_A: Drug X" class="gt_row gt_right"> 48 (46.2%)</td>
      <td headers="stub_1_3 var1_B: Placebo" class="gt_row gt_right"> 48 (47.5%)</td>
      <td headers="stub_1_3 var1_C: Combination" class="gt_row gt_right"> 50 (50.5%)</td></tr>
          <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub">cl B</th>
      <td headers="stub_1_4 var1_A: Drug X" class="gt_row gt_right"> 79 (76.0%)</td>
      <td headers="stub_1_4 var1_B: Placebo" class="gt_row gt_right"> 78 (77.2%)</td>
      <td headers="stub_1_4 var1_C: Combination" class="gt_row gt_right"> 76 (76.8%)</td></tr>
          <tr><td headers="stub_1_5 stub_1" class="gt_row gt_left gt_stub gt_indent_2">dcd B.1.1.1.1</td>
      <td headers="stub_1_5 var1_A: Drug X" class="gt_row gt_right"> 47 (45.2%)</td>
      <td headers="stub_1_5 var1_B: Placebo" class="gt_row gt_right"> 49 (48.5%)</td>
      <td headers="stub_1_5 var1_C: Combination" class="gt_row gt_right"> 43 (43.4%)</td></tr>
          <tr><td headers="stub_1_6 stub_1" class="gt_row gt_left gt_stub gt_indent_2">dcd B.2.2.3.1</td>
      <td headers="stub_1_6 var1_A: Drug X" class="gt_row gt_right"> 48 (46.2%)</td>
      <td headers="stub_1_6 var1_B: Placebo" class="gt_row gt_right"> 54 (53.5%)</td>
      <td headers="stub_1_6 var1_C: Combination" class="gt_row gt_right"> 51 (51.5%)</td></tr>
          <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">cl D</th>
      <td headers="stub_1_7 var1_A: Drug X" class="gt_row gt_right"> 50 (48.1%)</td>
      <td headers="stub_1_7 var1_B: Placebo" class="gt_row gt_right"> 42 (41.6%)</td>
      <td headers="stub_1_7 var1_C: Combination" class="gt_row gt_right"> 51 (51.5%)</td></tr>
          <tr><td headers="stub_1_8 stub_1" class="gt_row gt_left gt_stub gt_indent_2">dcd D.1.1.1.1</td>
      <td headers="stub_1_8 var1_A: Drug X" class="gt_row gt_right"> 50 (48.1%)</td>
      <td headers="stub_1_8 var1_B: Placebo" class="gt_row gt_right"> 42 (41.6%)</td>
      <td headers="stub_1_8 var1_C: Combination" class="gt_row gt_right"> 51 (51.5%)</td></tr>
        </tbody>
        <tfoot class="gt_sourcenotes"></tfoot>
        <tfoot class="gt_footnotes">
          <tr>
            <td class="gt_footnote" colspan="4"> </td>
          </tr>
        </tfoot>
      </table>
      </div>

