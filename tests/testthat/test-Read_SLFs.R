test_that("Year formats correctly", {
  expect_equal(format_year("1718"), "1718")
  expect_equal(format_year("17/18"), "1718")
  expect_equal(format_year(1718), "1718")
  expect_equal(format_year("201718"), "1718")
  expect_equal(format_year("2017/18"), "1718")
})

test_that("Reads individual", {
  indiv_1718 <- read_slf_individual("1718")
  expect_type(indiv_1718, "list")
  expect_gte(nrow(indiv_1718), 4000000)
  expect_named(indiv_1718)
})

test_that("Reads episode", {
  ep_1718 <- read_slf_episode("1718")
  expect_type(ep_1718, "list")
  expect_gte(nrow(ep_1718), 10000000)
  expect_named(ep_1718)
})

