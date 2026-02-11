# Match on anon_chi to a dataset using CHI numbers

Match on anon_chi to a dataset using CHI numbers

## Usage

``` r
get_anon_chi(chi_cohort, chi_var = "chi", drop = TRUE, check = TRUE)
```

## Arguments

- chi_cohort:

  a [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
  or data frame.

- chi_var:

  CHI variable: the name of the variable containing CHI (default is
  chi).

- drop:

  Optional boolean indicating whether the existing `chi_var` should be
  dropped - default is TRUE.

- check:

  Optional boolean, should the CHIs be checked using
  [`phsmethods::chi_check()`](https://public-health-scotland.github.io/phsmethods/reference/chi_check.html) -
  default is TRUE.

## Value

a [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
if (FALSE) { # \dontrun{
chi_cohort %>% get_anon_chi()
chi_cohort %>% get_anon_chi(chi_var = "upi_number")
} # }
```
