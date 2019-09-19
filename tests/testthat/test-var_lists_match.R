test_that("episode file vars match the vars list", {
  # Get the list of episode file variables
  data_vars <- ep_file_vars

  # Compare the variables in the current episode files to the list
  file_vars <- as.list(names(read_slf_episode("1819", from = 1, to = 1)))

  # These should be identical (names, order etc.)
  expect_identical(data_vars, file_vars)
})

test_that("individual file vars match the vars list", {
  # Get the list of individual file variables
  data_vars <- indiv_file_vars

  # Compare the variables in the current episode files to the list
  file_vars <- as.list(names(read_slf_individual("1819", from = 1, to = 1)))

  # These should be identical (names, order etc.)
  expect_identical(data_vars, file_vars)
})
