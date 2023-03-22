
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![GitHub release (latest by
date)](https://img.shields.io/github/v/release/Public-Health-Scotland/slfhelper)](https://github.com/Public-Health-Scotland/slfhelper/releases/latest)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/Public-Health-Scotland/slfhelper/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Public-Health-Scotland/slfhelper/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/Public-Health-Scotland/slfhelper/branch/production/graph/badge.svg?token=ev2n04MPNG)](https://codecov.io/gh/Public-Health-Scotland/slfhelper)
<!-- badges: end -->

# slfhelper

The goal of slfhelper is to provide some easy-to-use functions that make
working with the Source Linkage Files as painless and efficient as
possible.

## Installation

The preferred method of installation is to use the [{`pak`}
package](https://pak.r-lib.org/), which does an excellent job of
handling the errors which sometimes occur.

``` r
# Install pak (if needed)
install.packages("pak")

# Use pak to install slfhelper
pak::pak("Public-Health-Scotland/slfhelper")
```

## Usage

### Read a file

**Note:** Reading a full file is quite slow and will use a lot of
memory, we would always recommend doing a column selection to only keep
the variables that you need for your analysis. Just doing this will
dramatically speed up the read-time.

We provide some data snippets to help with the column selection and
filtering.

``` r
library(slfhelper)

# Get a list of the variables in a file
ep_file_vars
indiv_file_vars

# See a lookup of Partnership names to HSCP_2018 codes
View(partnerships)

# See a list with descriptions for the recids
View(recids)
```

``` r
library(slfhelper)

# Read certain variables
# It's much faster to choose variables like this
indiv_1718 <- read_slf_individual(year = "1718", columns = c("anon_chi", "hri_scot"))

# Read multiple years
# This will use dplyr::bind_rows() and return the files added together as a single tibble
episode_data <- read_slf_episode(year = c("1516", "1617", "1718", "1819"),
                                 columns = c("anon_chi", "yearstay"))

# Read only data for a certain partnership (HSCP_2018 code)
# This can be a single partnership or multiple by supplying a vector e.g. c(...)
indiv_1718 <- read_slf_individual(year = "1718", 
                                  partnerships = "S37000001", # Aberdeen City
                                  columns = c("anon_chi", "hri_scot"))

# Read only data for a certain recid
# This can be a single recid or multiple by supplying a vector e.g. c(...)
ep_1718 <- read_slf_episode("1718", recid = c("01B", "GLS"), columns = c("anon_chi", "yearstay"))
```

The above options for reading files can (and should) be combined if
required.

### Match on CHI numbers to Anon_CHI (or vice versa)

``` r
library(slfhelper)

# Add real CHI numbers to a SLF
ep_1718 <- read_slf_episode(c("1718", "1819", "1920"),
  columns = c("year", "anon_chi", "demographic_cohort")
) %>%
  get_chi()

# Change chi numbers from data above back to anon_chi
ep_1718_anon <- ep_1718 %>%
  get_anon_chi(chi_var = "chi")

# Add anon_chi to cohort sample
chi_cohort <- chi_cohort %>%
  get_anon_chi(chi_var = "upi_number")
```
