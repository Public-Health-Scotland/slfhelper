test_that("Year formats correctly", {
  expect_equal(format_year("1718"), "1718")
  expect_equal(format_year("17/18"), "1718")
  expect_equal(format_year(1718), "1718")
  expect_equal(format_year("201718"), "1718")
  expect_equal(format_year("2017/18"), "1718")
})
