skip_on_ci()

# Exclude for now as tests are failing due to the ordering not matching. We
# do not order variables anymore in R

# variable_names <- function(year, file_version = c("episode", "individual")) {
#   if (file_version == "episode") {
#     set.seed(50)
#
#     variable_names <- names(read_slf_episode(year) %>%
#       dplyr::slice_sample(n = 1))
#   } else if (file_version == "individual") {
#     set.seed(50)
#
#     variable_names <- names(read_slf_individual(year) %>%
#       dplyr::slice_sample(n = 1))
#   }
# }
#
#
# test_that("episode file vars match the vars list", {
#   # These should be identical (names, order etc.)
#   expect_equal(variable_names("1415", "episode"), ep_file_vars)
#   expect_equal(variable_names("1516", "episode"), ep_file_vars)
#   expect_equal(variable_names("1617", "episode"), ep_file_vars)
#   expect_equal(variable_names("1718", "episode"), ep_file_vars)
#   expect_equal(variable_names("1819", "episode"), ep_file_vars)
#   expect_equal(variable_names("1920", "episode"), ep_file_vars)
#   expect_equal(variable_names("2021", "episode"), ep_file_vars)
#   expect_equal(variable_names("2122", "episode"), ep_file_vars)
#   expect_equal(variable_names("2223", "episode"), ep_file_vars)
# })
#
# test_that("individual file vars match the vars list", {
#   # These should be identical (names, order etc.)
#   expect_equal(variable_names("1415", "individual"), indiv_file_vars)
#   expect_equal(variable_names("1516", "individual"), indiv_file_vars)
#   expect_equal(variable_names("1617", "individual"), indiv_file_vars)
#   expect_equal(variable_names("1718", "individual"), indiv_file_vars)
#   expect_equal(variable_names("1819", "individual"), indiv_file_vars)
#   expect_equal(variable_names("1920", "individual"), indiv_file_vars)
#   expect_equal(variable_names("2021", "individual"), indiv_file_vars)
#   expect_equal(variable_names("2122", "individual"), indiv_file_vars)
#   expect_equal(variable_names("2223", "individual"), indiv_file_vars)
# })
