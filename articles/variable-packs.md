# Using variable packs

## Selecting only specified variables

It is recommended to only choose the variables you need when reading in
a Source Linkage File. This can be achieved by specifying a `col_select`
argument to the relevant `read_slf_` function.

This will result in the data being read in much faster as well as being
easy to work with. The full episode and individual files have 200+ and
100+ variables respectively!

``` r
library(slfhelper)

ep_data <- read_slf_episode(year = 1920, col_select = c("year", "anon_chi", "recid"))

indiv_data <- read_slf_individual(year = 1920, col_select = c("year", "anon_chi", "nsu"))
```

## Selecting variables using `tidyselect` functions

It is now allowed to use `tidyselect` functions, such as
[`contains()`](https://tidyselect.r-lib.org/reference/starts_with.html)
and `start_with()`, to select variables in relevant `read_slf_`
function. One can also mix `tidyselect` functions with specified
variables when selecting.

``` r
library(slfhelper)
ep_data <-
  read_slf_episode(
    year = 1920,
    col_select = !tidyselect::contains("keytime")
  )

indiv_data <-
  read_slf_individual(
    year = 1920,
    col_select = c("year", "anon_chi", "nsu", tidyselect::starts_with("sds"))
  )
```

## Looking up variable names

To help with the task of picking which variables you might need for your
analysis, as well as getting the spelling correct, we provide lists of
the variable names in the package.

``` r
# Show the first few variables from the episode file
head(ep_file_vars)
#> [1] "year"            "recid"           "record_keydate1" "record_keydate2"
#> [5] "keytime1"        "keytime2"

# Do the same for the individual file
head(indiv_file_vars)
#> [1] "anon_chi" "gender"   "postcode" "dob"      "gpprac"   "year"
```

## Variable packs

This is great but it can still be a lot of effort and copy/pasting every
time, especially if you need quite a few variables for your analysis.

To assist with this, there are a number of ‘variable packs’, these are
groups of variables which would commonly be needed together which can be
accessed with a simple name. Currently there are four packs;
`demog_vars`, `ltc_vars`, `ep_file_bedday_vars` and `ep_file_cost_vars`.
Let’s see what they contain.

### Demographic variables

These are demographic variables which are specific to CHI and can be
used with episode or individual file.

``` r
demog_vars
#>  [1] "anon_chi"                     "gender"                      
#>  [3] "dob"                          "age"                         
#>  [5] "gpprac"                       "hbpraccode"                  
#>  [7] "postcode"                     "hbrescode"                   
#>  [9] "hscp2018"                     "lca"                         
#> [11] "ca2018"                       "locality"                    
#> [13] "datazone2011"                 "hb2019"                      
#> [15] "hscp2019"                     "ca2019"                      
#> [17] "simd2020v2_rank"              "simd2020v2_sc_decile"        
#> [19] "simd2020v2_sc_quintile"       "simd2020v2_hb2019_decile"    
#> [21] "simd2020v2_hb2019_quintile"   "simd2020v2_hscp2019_decile"  
#> [23] "simd2020v2_hscp2019_quintile" "ur8_2016"                    
#> [25] "ur6_2016"                     "ur3_2016"                    
#> [27] "ur2_2016"                     "cluster"                     
#> [29] "demographic_cohort"           "service_use_cohort"
```

### Long Term Condition (LTC) variables

These are the Long Term Condition flag variables which are specific to
CHI and can be used with episode or individual file.

``` r
ltc_vars
#>  [1] "arth"       "asthma"     "atrialfib"  "cancer"     "cvd"       
#>  [6] "liver"      "copd"       "dementia"   "diabetes"   "epilepsy"  
#> [11] "chd"        "hefailure"  "ms"         "parkinsons" "refailure" 
#> [16] "congen"     "bloodbfo"   "endomet"    "digestive"
```

### Bedday variables

These are variables detailing beddays, they are specific to an episode
and can only be used with the episode file.

``` r
ep_file_bedday_vars
#>  [1] "yearstay"    "stay"        "apr_beddays" "may_beddays" "jun_beddays"
#>  [6] "jul_beddays" "aug_beddays" "sep_beddays" "oct_beddays" "nov_beddays"
#> [11] "dec_beddays" "jan_beddays" "feb_beddays" "mar_beddays"
```

### Cost variables

These are variables detailing costs, they are specific to an episode and
can only be used with the episode file.

``` r
ep_file_cost_vars
#>  [1] "cost_total_net"          "cost_total_net_inc_dnas"
#>  [3] "apr_cost"                "may_cost"               
#>  [5] "jun_cost"                "jul_cost"               
#>  [7] "aug_cost"                "sep_cost"               
#>  [9] "oct_cost"                "nov_cost"               
#> [11] "dec_cost"                "jan_cost"               
#> [13] "feb_cost"                "mar_cost"
```

## Using variable packs

These variable packs can be used in the column selection to simplify
your code substantially.

For example to take some demographic data and LTC flags from the
individual file.

``` r
library(slfhelper)

indiv_ltc_data <- read_slf_individual(year = 1920, col_select = c("year", demog_vars, ltc_vars))
```

Or to get bedday information about Acute records from the episode file.

``` r
library(slfhelper)

acute_beddays <- read_slf_episode(
  year = 1920,
  col_select = c("year", "anon_chi", "hbtreatcode", "recid", ep_file_bedday_vars, "cij_pattype"),
  recid = c("01B", "GLS")
)
```

## Conclusion

You should be using the `column` argument when reading in data to
increase the read speed, and reduce the amount of data you are loading
into R. `slfhelper` provides a number of helpers to make picking and
using the variables you need easier.

If you would like any changes made to any existing packs, please [open
an issue on
GitHub](https://github.com/Public-Health-Scotland/slfhelper/issues).

If you would like to suggest any additional variable packs, either [open
an issue](https://github.com/Public-Health-Scotland/slfhelper/issues),
or even [submit a pull
request](https://usethis.r-lib.org/articles/pr-functions.html)!
