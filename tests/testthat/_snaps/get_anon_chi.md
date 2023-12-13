# Missing or blank CHIs match correctly

    Code
      get_anon_chi(data)
    Output
      # A tibble: 3 x 1
        anon_chi
        <chr>   
      1 <NA>    
      2 <NA>    
      3 <NA>    

---

    Code
      get_anon_chi(data, drop = FALSE)
    Output
      # A tibble: 3 x 2
        chi   anon_chi
        <chr> <chr>   
      1 ""    <NA>    
      2 ""    <NA>    
      3 <NA>  <NA>    

