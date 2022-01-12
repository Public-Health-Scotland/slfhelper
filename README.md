<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![GitHub release (latest by
date)](https://img.shields.io/github/v/release/Public-Health-Scotland/slfhelper)](https://github.com/Public-Health-Scotland/slfhelper/releases/latest)
<!-- badges: end -->

slfhelper
=========

The goal of slfhelper is to provide some easy to use functions that make
working with the Source Linkage Files as painless and efficient as
possible.

Installation
------------

You can install slfhelper from GitHub with the [remotes
package](https://remotes.r-lib.org/).

    install.packages("remotes")
    remotes::install_github("Public-Health-Scotland/slfhelper")

Usage
-----

### Read a file

**Note:** Reading a full file is quite slow, we would always recommend
doing a column selection to only keep the variables that you need for
your analysis. Just doing this will dramatically speed up the read-time.

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

    #single recid filtering
    ep_1718_recid_04B <- read_slf_episode("1718",
      recid = "04B")

All of the above options for reading files can be combined if required.

There are a few data files included in the package which should be
useful.

    # Get a list of the variables in a file
    slfhelper::ep_file_vars
    slfhelper::indiv_file_vars

    # See a lookup of Partnership names to HSCP_2018 codes

    hscp_lookup <- slfhelper::partnerships

### Match on CHI numbers to Anon\_CHI (or vice versa)

    library(slfhelper)

    # Add real CHI numbers to a SLF
    ep_1718 <- read_slf_episode(c("1718", "1819", "1920"),
      columns = c("year", "anon_chi", "demographic_cohort")
    ) %>%
      get_chi()

    # Change chi numbers from data above back to anon_chi
    ep_1718_anon <- ep_1718 %>% 
      get_anon_chi(chi_var = "chi")

    # Optionally specifiy the name of the CHI variable on a cohort of CHI's
    # Generate a sample which should contain at least some valid CHIs
    set.seed(1)
    n <- 100
    # Make one column upi_number and one chi
    chi_cohort <- dplyr::tibble(
      upi_number = paste0(
        round(runif(n, min = 0, max = 3)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 1)),
        round(runif(n, min = 0, max = 2)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9))
      ), chi = paste0(
        round(runif(n, min = 0, max = 3)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 1)),
        round(runif(n, min = 0, max = 2)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9)),
        round(runif(n, min = 0, max = 9))
      )
    )

    # Add anon_chi to cohort sample
    chi_cohort <- chi_cohort %>% 
      get_anon_chi(chi_var = "upi_number")
