################################################################################
# Name of file -  update_slfhelper.R
#
# Original Authors - Jennifer Thom, Zihao Li, Oluwatobi Oni
# Original Date - September 2025
# Written/run on - R Posit
# Version of R - 4.4.2
#
# Description:
#     If new variables have been added to the episode or individual file, or if
#     the package has been updated, we will need to update SLFhelper accordingly
#     to ensure the new variables are picked up by the package.
#
#     Run this script in stages
#
###############################################################################

library(dplyr)
# Tells github workflow to only run code locally, skip in CI
# There's no need to run the above code. Start from below and run in stages

## Stage 1 - Specify the year to check with
#-----------------------------------------------------------------------------

year <- "1920" # Can always edit and change the year

## Stage 2 - Update Episode File Variables
#-----------------------------------------------------------------------------
ep_file_vars <-  createslf::get_slf_episode_path(year) %>%
  arrow::open_dataset(format = "parquet") %>%
  names()

# Save the 'ep_file_vars' object to the package's data directory
usethis::use_data(
  ep_file_vars,
  overwrite = TRUE,
  compress = "xz",
  version = 3
)

# Alternative method to save the data
# save(ep_file_vars, file = "data/ep_file_vars.rda")

## Stage 3 - Update Individual File Variables
#-----------------------------------------------------------------------------
indiv_file_vars <- createslf::get_slf_individual_path(year) %>%
  arrow::open_dataset(format = "parquet") %>%
  names()

# Save the 'indiv_file_vars' object to the package's data directory
usethis::use_data(
  indiv_file_vars,
  overwrite = TRUE,
  compress = "xz",
  version = 3
)

# Alternative method to save the data
# save(indiv_file_vars, file = "data/indiv_file_vars.rda")

## Stage 4 - Run package tests and checks
#-----------------------------------------------------------------------------

# devtools::test() and devtools::check() should NEVER show up in anywhere
# in "R\" folder
devtools::test()
devtools::check()

## Stage 5 - Set a new version number
#-----------------------------------------------------------------------------
usethis::use_version()

# Further Instructions
#-----------------------------------------------------------------------------
# After running this script, you must manually complete the remaining steps:
# - Update the NEWS.md file in the slfhelper root folder
# - Commit the changes to your new branch
# - Create a PR and merge the branch into development
# - Merge development to production
# - Create a release and a tag on GitHub
