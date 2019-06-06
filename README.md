# slfhelper

<!-- badges: start -->

<!-- badges: end -->

The goal of slfhelper is to provide some easy to use functions which make working with the Source Linkage Files as painless and efficient as possible.

## Installation

You can install slf by using the [devtools package](https://devtools.r-lib.org/)  in R:

``` r
devtools::install_github("Moohan/slfhelper")
```

Unless you jump through some hoops this may not work on the internal NSS network.
However it should work on the [RStudio server](http://nssrstudio.csa.scot.nhs.uk/) which this package is designed to be ran on.

## Usage

### Read a file

``` r
library(slfhelper)

ep_1718 <- read_slf_episode("1718")
```

### Match on CHI numbers to Anon_CHI (or vice versa)
``` r
library(slfhelper)

cohort <- cohort %>% get_anon_chi()
```


