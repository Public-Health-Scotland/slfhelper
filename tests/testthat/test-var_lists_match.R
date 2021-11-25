get_variable_names <- function(type, year) {
  if (type == "episode") {
    variable_names <- read_slf_episode(
      year = year,
      from = 1L,
      to = 1L
    ) %>%
      names()
  } else if (type == "individual") {
    variable_names <- read_slf_individual(
      year = year,
      from = 1L,
      to = 1L
    ) %>%
      names()
  }

  return(variable_names)
}


test_that("episode file vars match the vars list", {
  # These should be identical (names, order etc.)
  expect_setequal(get_variable_names("episode", "1415"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "1516"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "1617"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "1718"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "1819"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "1920"), ep_file_vars)
  expect_setequal(get_variable_names("episode", "2021"), ep_file_vars)
})

test_that("individual file vars match the vars list", {
  # These should be identical (names, order etc.)
  expect_setequal(get_variable_names("individual", "1415"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "1516"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "1617"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "1718"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "1819"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "1920"), indiv_file_vars)
  expect_setequal(get_variable_names("individual", "2021"), indiv_file_vars)
})
