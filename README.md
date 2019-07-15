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

# Read a full episode file
ep_1718 <- read_slf_episode("1718")

# Read certain variables from an individual file
# It's much faster to chose variables like this
indiv_1718 <- read_slf_individual("1718", columns = c("anon_chi", "hri_scot"))
```

### Match on CHI numbers to Anon_CHI (or vice versa)
``` r
library(slfhelper)

# Add real CHI numbers to a SLF
ep_1718 <- read_slf_episode("1718") %>% get_chi()

# Add anon_chi numbers to a cohort
# Optionaly specifiy the name of the CHI variable
cohort <- cohort %>% get_anon_chi(chi_var = "upi_number")
```


