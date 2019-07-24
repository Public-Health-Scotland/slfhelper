test_that("Reads individual", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  indiv_file <- read_slf_individual(year)

  # Test for anything odd
  expect_type(indiv_file, "list")
  expect_named(indiv_file)

  # Test for correct number of variables (will need updating)
  expect_length(indiv_file, 155)

  # Test for roughly correct number of rows
  expect_gte(nrow(indiv_file), 4000000)
})

test_that("Reads episode", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  ep_file <- read_slf_episode(year)

  # Test for anything odd
  expect_type(ep_file, "list")
  expect_named(ep_file)

  # Test for correct number of variables (will need updating)
  expect_length(ep_file, 210)

  # Test for roughly correct number of rows
  expect_gte(nrow(ep_file), 10000000)
})

test_that("column selection works", {
  indiv_1718 <- read_slf_individual("1718", columns = c("anon_chi"))

  # Test for anything odd
  expect_type(indiv_1718, "list")
  expect_named(indiv_1718)

  # Test for correct number of variables
  expect_length(indiv_1718, 1)

  # Test for the existance of the anon_chi var
  expect_named(indiv_1718, "anon_chi")

  # Test for roughly correct number of rows
  expect_gte(nrow(indiv_1718), 4000000)
})

test_that("read multiple years works", {
  # Read in multiple years
  indiv <- read_slf_individual(c("1718", "1819"),
    columns = c("year", "anon_chi"),
    from = 1,
    to = 100
  )

  # Test for anything odd
  expect_type(indiv, "list")

  # Test for the existance of the correct variables
  expect_named(indiv, c("year", "anon_chi"))
  expect_length(indiv, 2)

  # Test for the correct number of rows (100 * 2)
  expect_equal(nrow(indiv), 200)

  # Test that we have 100 rows from each year
  expect_equal(
    dplyr::count(indiv, year),
    dplyr::tibble(year = c("1718", "1819"), n = c(100L, 100L))
  )
})
