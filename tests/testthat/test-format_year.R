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
