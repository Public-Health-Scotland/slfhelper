# Can get CHI numbers for an arbitrary set of anon_chi numbers

    Code
      get_chi(data)
    Output
      # A tibble: 12 x 1
         chi         
         <chr>       
       1 "2601211618"
       2 "2210680631"
       3 "1410920754"
       4 "3112358158"
       5 "0112418156"
       6 "0612732243"
       7 "2310474015"
       8 "2411063698"
       9 "3801112374"
      10 "2311161233"
      11 ""          
      12  <NA>       

---

    Code
      get_chi(data, drop = FALSE)
    Output
      # A tibble: 12 x 2
         anon_chi           chi         
         <chr>              <chr>       
       1 "MjYwMTIxMTYxOA==" "2601211618"
       2 "MjIxMDY4MDYzMQ==" "2210680631"
       3 "MTQxMDkyMDc1NA==" "1410920754"
       4 "MzExMjM1ODE1OA==" "3112358158"
       5 "MDExMjQxODE1Ng==" "0112418156"
       6 "MDYxMjczMjI0Mw==" "0612732243"
       7 "MjMxMDQ3NDAxNQ==" "2310474015"
       8 "MjQxMTA2MzY5OA==" "2411063698"
       9 "MzgwMTExMjM3NA==" "3801112374"
      10 "MjMxMTE2MTIzMw==" "2311161233"
      11 ""                 ""          
      12  <NA>               <NA>       

