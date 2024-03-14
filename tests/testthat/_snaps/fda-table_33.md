# Table 33 generation works with default values

    Code
      res
    Output
      Blood Pressure    A: Drug X    B: Placebo   C: Combination
      (Pa)               (N=134)      (N=134)        (N=132)    
      ——————————————————————————————————————————————————————————
      SBP <90          85 (63.4%)    84 (62.7%)     90 (68.2%)  
      DBP <60          133 (99.3%)   134 (100%)     132 (100%)  

# Table 33 generation works with custom values

    Code
      res
    Output
      Table 33. Percentage of Patients Meeting Specific Hypotension Levels
       Postbaseline, Safety Population, Pooled Analysis
      
      ————————————————————————————————————————————————————————————————————————
                                                                      Total   
      Blood Pressure    A: Drug X    B: Placebo   C: Combination   Population 
      (Pa)               (N=134)      (N=134)        (N=132)         (N=400)  
      ————————————————————————————————————————————————————————————————————————
      SBP <90          85 (63.4%)    84 (62.7%)     90 (68.2%)     259 (64.8%)
      DBP <60          133 (99.3%)   134 (100%)     132 (100%)     399 (99.8%)
      ————————————————————————————————————————————————————————————————————————
      
      Source: [include Applicant source, datasets and/or software tools used].
      (1) Difference is shown between [treatment arms] (e.g., difference is shown
      between Drug Name dosage X vs. placebo).
      
      Abbreviations: CI, confidence interval; N, number of patients in treatment arm with
      available blood pressure data; n, number of patients with indicated blood pressure

# Table 33 generation works with pruned rows

    Code
      res
    Output
      Blood Pressure    A: Drug X    B: Placebo   C: Combination
      (Pa)               (N=134)      (N=134)        (N=132)    
      ——————————————————————————————————————————————————————————
      DBP <60          133 (99.3%)   134 (100%)     132 (100%)  

# Table 33 generation works with risk difference column

    Code
      res
    Output
      Blood Pressure    A: Drug X    B: Placebo   C: Combination   Risk Difference (%) (95% CI)
      (Pa)               (N=134)      (N=134)        (N=132)                 (N=268)           
      —————————————————————————————————————————————————————————————————————————————————————————
      SBP <90          85 (63.4%)    84 (62.7%)     90 (68.2%)         -0.7 (-12.3 - 10.8)     
      DBP <60          133 (99.3%)   134 (100%)     132 (100%)           0.7 (-0.7 - 2.2)      

# Table 33 (gtsum) generation works with default values

    Code
      res
    Output
      # A tibble: 2 x 8
        variable var_type    var_label  row_type label      stat_1      stat_2  stat_3
        <chr>    <chr>       <chr>      <chr>    <chr>      <chr>       <chr>   <chr> 
      1 SBP90    dichotomous SBP &lt;90 label    SBP &lt;90 85 (63.4%)  84 (62~ 90 (6~
      2 DBP60    dichotomous DBP &lt;60 label    DBP &lt;60 133 (99.3%) 134 (1~ 132 (~

# Table 33 (gtsum) generation works with custom values

    Code
      res
    Output
      # A tibble: 2 x 9
        variable var_type    var_label  row_type label     stat_1 stat_2 stat_3 stat_0
        <chr>    <chr>       <chr>      <chr>    <chr>     <chr>  <chr>  <chr>  <chr> 
      1 SBP90    dichotomous SBP &lt;90 label    SBP &lt;~ 85 (6~ 84 (6~ 90 (6~ 259 (~
      2 DBP60    dichotomous DBP &lt;60 label    DBP &lt;~ 133 (~ 134 (~ 132 (~ 399 (~

