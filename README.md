# slfhelper

The goal of slfhelper is to provide some easy to use functions which make 
working with the Source Linkage Files as painless and efficient as possible.

## Installation

You can install slfhelper by using the [remotes package](https://remotes.r-lib.org/)  in R:

``` r
install.packages("remotes")
remotes::install_github("Public-Health-Scotland/slfhelper")
```

Unless you jump through some hoops this may not work on the internal NSS network.
However it should work on the [RStudio server](https://rstudio.nhsnss.scot.nhs.uk/)
which this package is designed to be ran on.

## Usage

### Read a file

``` r
library(slfhelper)

# Read a full file
ep_1718 <- read_slf_episode("1718")
indiv_1718 <- read_slf_individual("1718")

# Read multiple years
# This will use dplyr::bind_rows() and return the files added together as a single tibble
episode_data <- read_slf_episode(c("1516", "1617", "1718", "1819"))

# Read certain variables 
# It's much faster to choose variables like this
indiv_1718 <- read_slf_individual("1718", columns = c("anon_chi", "hri_scot"))

# Read only data for a certain partnership (HSCP_2018 code)
# This can be a single partnership or multiple by supplying a vector e.g. c(...)
indiv_1718 <- read_slf_individual("1718", partnerships = "S37000001") # Aberdeen City

# Read only data for a certain recid
# This can be a single recid or multiple by supplying a vector e.g. c(...)
ep_1718 <- read_slf_episode("1718", recid = c("01B", "GLS"))
```
All of the above options for reading files can be combined if required. 

There are a few data files included in the package which should be useful.

``` r
# Get a list of the variables in a file
slfhelper::ep_file_vars
slfhelper::indiv_file_vars

# See a lookup of Partnership names to HSCP_2018 codes

hscp_lookup <- slfhelper::partnerships
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


