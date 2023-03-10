skip_on_ci()

variable_names <- function(year, file_version = c("episode", "individual")) {
  if (file_version == "episode") {
    variable_names <- names(read_slf_episode(year, from = 1L, to = 1L))
  } else if (file_version == "individual") {
    variable_names <- names(read_slf_individual(year, from = 1L, to = 1L))
  }
}


test_that("episode file vars match the vars list", {
  # These should be identical (names, order etc.)
  expect_equal(variable_names("1415", "episode"), ep_file_vars)
  expect_equal(variable_names("1516", "episode"), ep_file_vars)
  expect_equal(variable_names("1617", "episode"), ep_file_vars)
  expect_equal(variable_names("1718", "episode"), ep_file_vars)
  expect_equal(variable_names("1819", "episode"), ep_file_vars)
  expect_equal(variable_names("1920", "episode"), ep_file_vars)
  expect_equal(variable_names("2021", "episode"), ep_file_vars)
  expect_equal(variable_names("2122", "episode"), ep_file_vars)
  expect_equal(variable_names("2223", "episode"), ep_file_vars)
})

test_that("individual file vars match the vars list", {
  # These should be identical (names, order etc.)
  expect_equal(variable_names("1415", "individual"), indiv_file_vars)
  expect_equal(variable_names("1516", "individual"), indiv_file_vars)
  expect_equal(variable_names("1617", "individual"), indiv_file_vars)
  expect_equal(variable_names("1718", "individual"), indiv_file_vars)
  expect_equal(variable_names("1819", "individual"), indiv_file_vars)
  expect_equal(variable_names("1920", "individual"), indiv_file_vars)
  expect_equal(variable_names("2021", "individual"), indiv_file_vars)
  expect_equal(variable_names("2122", "individual"), indiv_file_vars)
  expect_equal(variable_names("2223", "individual"), indiv_file_vars)
})
