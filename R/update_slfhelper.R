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

## Stage 1 - Specify the year to check with
#-------------------------------------------------------------------------------

year <- "1920" # Can always edit and change the year

# Only run the following code locally, skip in CI
if (!identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {

## Stage 2 - Update Episode File Variables
#-------------------------------------------------------------------------------
ep_data <- createslf::get_slf_episode_path(year) %>%
  createslf::read_file()
ep_file_vars <- names(ep_data)

# Save the 'ep_file_vars' object to the package's data directory
usethis::use_data(ep_file_vars, overwrite = TRUE, compress = "xz", version = 3)

# Alternative method to save the data
# save(ep_file_vars, file = "data/ep_file_vars.rda")

## Stage 3 - Update Individual File Variables
#-------------------------------------------------------------------------------
indiv_file_vars <- createslf::get_slf_individual_path(year) %>%
  createslf::read_file() %>%
  names()

# Save the 'indiv_file_vars' object to the package's data directory
usethis::use_data(indiv_file_vars, overwrite = TRUE, compress = "xz", version = 3)

# Alternative method to save the data
# save(indiv_file_vars, file = "data/indiv_file_vars.rda")

}

## Stage 4 - Run package tests and checks
#-------------------------------------------------------------------------------
devtools::test()
devtools::check()

## Stage 5 - Set a new version number
#-------------------------------------------------------------------------------
usethis::use_version()

# Further Instructions
#-------------------------------------------------------------------------------
# After running this script, you must manually complete the remaining steps:
# - Update the NEWS.md file in the slfhelper root folder
# - Commit the changes to your new branch
# - Create a PR and merge the branch into development
# - Merge development to production
# - Create a release and a tag on GitHub
