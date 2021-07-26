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

test_that("Year check returns TRUE for correct newer years", {
  expect_true(check_year("1718"))
  expect_true(check_year("17/18"))
  expect_true(check_year(1718))
  expect_true(check_year("201718"))
  expect_true(check_year("2017/18"))
})

test_that("Year check returns FALSE for correct older years", {
  expect_false(check_year("1213"))
  expect_false(check_year("12/13"))
  expect_false(check_year(1213))
  expect_false(check_year("201213"))
  expect_false(check_year("2012/13"))
})

test_that("Year check rejects clearly erronous years", {
  expect_snapshot_error(check_year("twenty-twenty"))
  expect_snapshot_error(check_year(21))
})

test_that("Year check rejects ambiguous years", {
  expect_snapshot_error(check_year("2017"))
  expect_snapshot_error(check_year("2020"))
  expect_snapshot_error(check_year("1514"))
})

test_that("Year check rejects out of bounds years", {
  expect_snapshot_error(check_year("1112"))
  expect_snapshot_error(check_year("10/11"))
  expect_snapshot_error(check_year("2011/12"))
})
