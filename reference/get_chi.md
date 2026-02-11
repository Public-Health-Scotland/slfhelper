# Match on CHI numbers to a dataset using anon_chi

Match on CHI numbers to a dataset using anon_chi

## Usage

``` r
get_chi(data, anon_chi_var = "anon_chi", drop = TRUE)
```

## Arguments

- data:

  a [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
  or data frame

- anon_chi_var:

  Anon CHI variable: the name of the variable containing anonymised CHI
  (default is anon_chi)

- drop:

  Optional boolean indicating whether the existing `anon_chi_var` should
  be dropped - default is TRUE

## Value

a [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
if (FALSE) { # \dontrun{
slf_1718 <- read_slf_individual("1718")
get_chi(slf_1718)
get_chi(slf_1718, drop = FALSE)
} # }
```
