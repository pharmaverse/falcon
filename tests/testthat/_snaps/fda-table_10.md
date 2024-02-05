# Table 10 generation works with default values

    Code
      res
    Output
      Body System or Organ Class   A: Drug X    B: Placebo   C: Combination
        FMQ (Narrow)                (N=134)      (N=134)        (N=132)    
      —————————————————————————————————————————————————————————————————————
      cl A.1                                                               
        FMQ1                       17 (12.7%)   14 (10.4%)     29 (22.0%)  
        FMQ2                       23 (17.2%)   20 (14.9%)     20 (15.2%)  
        FMQ3                       20 (14.9%)   19 (14.2%)     23 (17.4%)  
      cl B.1                                                               
        FMQ1                        8 (6.0%)    11 (8.2%)       7 (5.3%)   
        FMQ2                        5 (3.7%)    12 (9.0%)      16 (12.1%)  
        FMQ3                       10 (7.5%)     7 (5.2%)       5 (3.8%)   
      cl B.2                                                               
        FMQ1                       13 (9.7%)    15 (11.2%)      9 (6.8%)   
        FMQ2                       12 (9.0%)     9 (6.7%)      10 (7.6%)   
        FMQ3                        6 (4.5%)     7 (5.2%)       9 (6.8%)   
      cl C.2                                                               
        FMQ1                        9 (6.7%)     9 (6.7%)      12 (9.1%)   
        FMQ2                        6 (4.5%)     8 (6.0%)       8 (6.1%)   
        FMQ3                        6 (4.5%)     9 (6.7%)      10 (7.6%)   
      cl D.1                                                               
        FMQ1                       23 (17.2%)   17 (12.7%)     27 (20.5%)  
        FMQ2                       22 (16.4%)   20 (14.9%)     25 (18.9%)  
        FMQ3                       15 (11.2%)   19 (14.2%)     21 (15.9%)  
      cl D.2                                                               
        FMQ1                        8 (6.0%)    11 (8.2%)       9 (6.8%)   
        FMQ2                       14 (10.4%)   15 (11.2%)     14 (10.6%)  
        FMQ3                       11 (8.2%)     9 (6.7%)      11 (8.3%)   

# Table 10 generation works with custom values

    Code
      res
    Output
      Table 10. Patients With Serious Adverse Events(1) by System Organ Class and FDA Medical Query
       (Broad), Safety Population, Pooled Analyses(2)
      
      ———————————————————————————————————————————————————————————————————————
      Body System or Organ Class(3)   A: Drug X   B: Placebo   C: Combination
        FMQ (Broad)                    (N=134)     (N=134)        (N=132)    
      ———————————————————————————————————————————————————————————————————————
      cl B.2                                                                 
        FMQ1                          8 (6.0%)    10 (7.5%)       8 (6.1%)   
        FMQ2                          12 (9.0%)   12 (9.0%)      13 (9.8%)   
        FMQ3                          8 (6.0%)    16 (11.9%)      6 (4.5%)   
      cl C.1                                                                 
        FMQ1                          7 (5.2%)    11 (8.2%)      14 (10.6%)  
        FMQ2                          10 (7.5%)   16 (11.9%)      7 (5.3%)   
        FMQ3                          8 (6.0%)     5 (3.7%)      12 (9.1%)   
      ———————————————————————————————————————————————————————————————————————
      
      Source: [include Applicant source, datasets and/or software tools used].
       (1) Defined as any untoward medical occurrence that, at any dose that results in death, is life-threatening,
       requires hospitalization or prolongation of existing hospitalization, results in persistent incapacity or substantial
       disruption of the ability to conduct normal life functions, or is a congenital anomaly or birth defect.
       (2) Duration = [e.g., X-week double-blind treatment period or, median and a range indicating pooled trial
       durations].
       (3) Each FMQ is aligned to a single SOC based on clinical judgement. However, please be aware that some FMQs
       may contain PTs from more than one SOC.
      
      Abbreviations: CI, confidence interval; FMQ, FDA Medical Query;
      MedDRA, Medical Dictionary for Regulatory Activities; N, number of patients in treatment arm;
      n, number of patients with adverse event; SOC, System Organ Class

# Table 10 generation works with risk difference column

    Code
      res
    Output
      Body System or Organ Class   A: Drug X    B: Placebo   C: Combination   Risk Difference (%) (95% CI)
        FMQ (Narrow)                (N=134)      (N=134)        (N=132)                 (N=268)           
      ————————————————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                              
        FMQ1                       17 (12.7%)   14 (10.4%)     29 (22.0%)          -2.2 (-9.9 - 5.4)      
        FMQ2                       23 (17.2%)   20 (14.9%)     20 (15.2%)          -2.2 (-11.0 - 6.5)     
        FMQ3                       20 (14.9%)   19 (14.2%)     23 (17.4%)          -0.7 (-9.2 - 7.7)      
      cl B.1                                                                                              
        FMQ1                        8 (6.0%)    11 (8.2%)       7 (5.3%)            2.2 (-3.9 - 8.4)      
        FMQ2                        5 (3.7%)    12 (9.0%)      16 (12.1%)          5.2 (-0.6 - 11.0)      
        FMQ3                       10 (7.5%)     7 (5.2%)       5 (3.8%)           -2.2 (-8.1 - 3.6)      
      cl B.2                                                                                              
        FMQ1                       13 (9.7%)    15 (11.2%)      9 (6.8%)            1.5 (-5.8 - 8.8)      
        FMQ2                       12 (9.0%)     9 (6.7%)      10 (7.6%)           -2.2 (-8.7 - 4.2)      
        FMQ3                        6 (4.5%)     7 (5.2%)       9 (6.8%)            0.7 (-4.4 - 5.9)      
      cl C.2                                                                                              
        FMQ1                        9 (6.7%)     9 (6.7%)      12 (9.1%)            0.0 (-6.0 - 6.0)      
        FMQ2                        6 (4.5%)     8 (6.0%)       8 (6.1%)            1.5 (-3.8 - 6.8)      
        FMQ3                        6 (4.5%)     9 (6.7%)      10 (7.6%)            2.2 (-3.3 - 7.7)      
      cl D.1                                                                                              
        FMQ1                       23 (17.2%)   17 (12.7%)     27 (20.5%)          -4.5 (-13.0 - 4.0)     
        FMQ2                       22 (16.4%)   20 (14.9%)     25 (18.9%)          -1.5 (-10.2 - 7.2)     
        FMQ3                       15 (11.2%)   19 (14.2%)     21 (15.9%)          3.0 (-5.0 - 10.9)      
      cl D.2                                                                                              
        FMQ1                        8 (6.0%)    11 (8.2%)       9 (6.8%)            2.2 (-3.9 - 8.4)      
        FMQ2                       14 (10.4%)   15 (11.2%)     14 (10.6%)           0.7 (-6.7 - 8.2)      
        FMQ3                       11 (8.2%)     9 (6.7%)      11 (8.3%)           -1.5 (-7.8 - 4.8)      

# Table 10 (gt) generation works

    Code
      res
    Output
      $data
      # A tibble: 24 x 14
         tbl_id1 variable var_label row_type label  var_type_1  stat_1_1    stat_2_1  
           <int> <chr>    <lgl>     <chr>    <chr>  <chr>       <chr>       <chr>     
       1       1 soc      NA        label    cl A.1 categorical ""          ""        
       2       1 ae       NA        level    FMQ1   categorical "17 (13%)"  "117 (87%~
       3       1 ae       NA        level    FMQ2   categorical "23 (17%)"  "111 (83%~
       4       1 ae       NA        level    FMQ3   categorical "20 (15%)"  "114 (85%~
       5       2 soc      NA        label    cl B.1 categorical ""          ""        
       6       2 ae       NA        level    FMQ1   categorical "8 (6.0%)"  "126 (94%~
       7       2 ae       NA        level    FMQ2   categorical "5 (3.7%)"  "129 (96%~
       8       2 ae       NA        level    FMQ3   categorical "10 (7.5%)" "124 (93%~
       9       3 soc      NA        label    cl B.2 categorical ""          ""        
      10       3 ae       NA        level    FMQ1   categorical "13 (9.7%)" "121 (90%~
      11       3 ae       NA        level    FMQ2   categorical "12 (9.0%)" "122 (91%~
      12       3 ae       NA        level    FMQ3   categorical "6 (4.5%)"  "128 (96%~
      13       4 soc      NA        label    cl C.2 categorical ""          ""        
      14       4 ae       NA        level    FMQ1   categorical "9 (6.7%)"  "125 (93%~
      15       4 ae       NA        level    FMQ2   categorical "6 (4.5%)"  "128 (96%~
      16       4 ae       NA        level    FMQ3   categorical "6 (4.5%)"  "128 (96%~
      17       5 soc      NA        label    cl D.1 categorical ""          ""        
      18       5 ae       NA        level    FMQ1   categorical "23 (17%)"  "111 (83%~
      19       5 ae       NA        level    FMQ2   categorical "22 (16%)"  "112 (84%~
      20       5 ae       NA        level    FMQ3   categorical "15 (11%)"  "119 (89%~
      21       6 soc      NA        label    cl D.2 categorical ""          ""        
      22       6 ae       NA        level    FMQ1   categorical "8 (6.0%)"  "126 (94%~
      23       6 ae       NA        level    FMQ2   categorical "14 (10%)"  "120 (90%~
      24       6 ae       NA        level    FMQ3   categorical "11 (8.2%)" "123 (92%~
      # i 6 more variables: var_type_2 <chr>, stat_1_2 <chr>, stat_2_2 <chr>,
      #   var_type_3 <chr>, stat_1_3 <chr>, stat_2_3 <chr>
      
      $column_label
      $column_label[[1]]
      [1] "tbl_id1"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[2]]
      [1] "variable"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[3]]
      [1] "var_label"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[4]]
      [1] "row_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[5]]
      [1] "**System Organ Class** <br>FMQ (Narrow)"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[6]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[7]]
      [1] "**A: Drug X**  \nN = 134"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[8]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[9]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[10]]
      [1] "**B: Placebo**  \nN = 134"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[11]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[12]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[13]]
      [1] "**C: Combination**  \nN = 132"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[14]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      
      $header
      $header$title
      NULL
      
      $header$subtitle
      NULL
      
      $header$preheader
      NULL
      
      
      $footnotes
      list()
      

# Table 10 (gt) generation works with custom values

    Code
      res
    Output
      $data
      # A tibble: 8 x 17
        tbl_id1 variable row_type label  var_label var_type_1_1 stat_1_1_1  stat_2_1_1
          <int> <chr>    <chr>    <chr>  <chr>     <chr>        <chr>       <chr>     
      1       1 soc      label    cl B.2 cl B.2    categorical  ""          ""        
      2       1 ae       level    FMQ1   <NA>      categorical  "8 (6.0%)"  "126 (94%~
      3       1 ae       level    FMQ2   <NA>      categorical  "12 (9.0%)" "122 (91%~
      4       1 ae       level    FMQ3   <NA>      categorical  "8 (6.0%)"  "126 (94%~
      5       2 soc      label    cl C.1 cl C.1    categorical  ""          ""        
      6       2 ae       level    FMQ1   <NA>      categorical  "7 (5.2%)"  "127 (95%~
      7       2 ae       level    FMQ2   <NA>      categorical  "10 (7.5%)" "124 (93%~
      8       2 ae       level    FMQ3   <NA>      categorical  "8 (6.0%)"  "126 (94%~
      # i 9 more variables: var_type_2_1 <chr>, stat_1_2_1 <chr>, stat_2_2_1 <chr>,
      #   var_type_3_1 <chr>, stat_1_3_1 <chr>, stat_2_3_1 <chr>, var_type_1_2 <chr>,
      #   stat_1_1_2 <chr>, stat_2_1_2 <chr>
      
      $column_label
      $column_label[[1]]
      [1] "tbl_id1"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[2]]
      [1] "variable"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[3]]
      [1] "row_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[4]]
      [1] "**System Organ Class** <br>FMQ (Broad)"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[5]]
      [1] "var_label"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[6]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[7]]
      [1] "**A: Drug X**  \nN = 134"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[8]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[9]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[10]]
      [1] "**B: Placebo**  \nN = 134"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[11]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[12]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[13]]
      [1] "**C: Combination**  \nN = 132"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[14]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[15]]
      [1] "var_type"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[16]]
      [1] "**Overall**  \nN = 400"
      attr(,"class")
      [1] "from_markdown"
      
      $column_label[[17]]
      [1] "**NOT OBSERVED**"
      attr(,"class")
      [1] "from_markdown"
      
      
      $header
      $header$title
      [1] "Table 10. Patients With Serious Adverse Events "
      
      $header$subtitle
      [1] "by System Organ Class and FDA Medical Query (Narrow),\n  Safety Population, Pooled Analyses"
      
      $header$preheader
      NULL
      
      
      $footnotes
      $footnotes[[1]]
      [1] "Duration = [e.g., X week double-blind treatment period or median and a range\n    indicating pooled trial durations]."
      
      

