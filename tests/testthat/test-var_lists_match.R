get_variable_names <- function(type, year) {
  if (type == "episode") {
    file_vars <- read_slf_episode(
      year = year,
      from = 1,
      to = 1
    ) %>%
      names()
  } else if (type == "individual") {
    file_vars <- read_slf_individual(
      year = year,
      from = 1,
      to = 1
    ) %>%
      names()
  }

  return(file_vars)
}

years <- c("1415", "1516", "1617", "1718", "1819", "1920", "2021")

test_that("episode file vars match the vars list", {

  # Get the list of episode file variables
  data_vars <- ep_file_vars

  for (year in years) {
    # Compare the variables in the current episode files to the list
    # These should be identical (names, order etc.)
    expect_identical(data_vars, get_variable_names("episode", year))
  }
})

test_that("individual file vars match the vars list", {
  # Get the list of individual file variables
  data_vars <- indiv_file_vars

  for (year in years) {
    # Compare the variables in the current episode files to the list
    # These should be identical (names, order etc.)
    expect_identical(data_vars, get_variable_names("individual", year))
  }
})
