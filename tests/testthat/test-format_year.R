test_that("Year formats correctly", {

  # Test various possible inputs
  expect_equal(format_year("1718"), "1718")
  expect_equal(format_year("17/18"), "1718")
  expect_equal(format_year(1718), "1718")
  expect_equal(format_year("201718"), "1718")
  expect_equal(format_year("2017/18"), "1718")

  # Need to add more and develop the function to deal with them
  # Deal with FY as a year e.g. 2017
})

check_formatted_year <- function(year) {format_year(year) %>% check_year()}
test_that("Year check returns true for correct years", {
  expect_true(check_formatted_year("1718"))
})

test_that("Year check rejects clearly erronous years", {
  expect_snapshot_error(check_formatted_year("twenty-twenty"))
})

test_that("Year check rejects ambiguous years", {
  expect_snapshot_error(check_formatted_year("2017"))
})
