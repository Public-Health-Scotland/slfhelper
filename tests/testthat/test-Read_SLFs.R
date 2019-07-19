test_that("Year formats correctly", {
  expect_equal(format_year("1718"), "1718")
  expect_equal(format_year("17/18"), "1718")
  expect_equal(format_year(1718), "1718")
  expect_equal(format_year("201718"), "1718")
  expect_equal(format_year("2017/18"), "1718")
})

test_that("Reads individual", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  indiv_file <- read_slf_individual(year)

  expect_type(indiv_file, "list")
  expect_length(indiv_file, 155)
  expect_gte(nrow(indiv_file), 4000000)
  expect_named(indiv_file)
})

test_that("Reads episode", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  ep_file <- read_slf_episode(year)

  expect_type(ep_file, "list")
  expect_length(ep_file, 210)
  expect_gte(nrow(ep_file), 10000000)
  expect_named(ep_file)
})

test_that("column selection works", {
  indiv_1718 <- read_slf_individual("1718", columns = c("anon_chi"))

  expect_type(indiv_1718, "list")
  expect_length(indiv_1718, 1)
  expect_named(indiv_1718, "anon_chi")
  expect_gte(nrow(indiv_1718), 4000000)
  expect_named(indiv_1718)
})


test_that("read multiple years works", {
  indiv <- read_slf_individual(c("1718", "1819"), columns = c("year", "anon_chi"), from = 1, to = 100)
  indiv_full <- read_slf_individual(c("1718", "1819"))

  expect_type(indiv, "list")
  expect_equal(nrow(indiv), 200)
  expect_named(indiv, c("year", "anon_chi"))
  expect_length(indiv, 2)
  expect_equal(dplyr::count(indiv, year), dplyr::tibble(year = c("1718", "1819"), n = c(100L, 100L)))

  expect_type(indiv_full, "list")
  expect_gt(nrow(indiv_full), 8000000)
  expect_named(indiv_full)
  expect_length(indiv_full, 155)

})

