test_that("Reads individual", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  indiv_file <- read_slf_individual(year, from = 1, to = 100)

  # Test for anything odd
  expect_type(indiv_file, "list")
  expect_named(indiv_file)

  # Test for correct number of variables (will need updating)
  expect_length(indiv_file, 155)

  # Test for roughly correct number of rows
  expect_equal(nrow(indiv_file), 100)
})

test_that("column selection works", {
  indiv_1718 <- read_slf_individual("1718",
                                    columns = c("anon_chi"),
                                    from = 1, to = 100)

  # Test for anything odd
  expect_type(indiv_1718, "list")
  expect_named(indiv_1718)

  # Test for correct number of variables
  expect_length(indiv_1718, 1)

  # Test for the existance of the anon_chi var
  expect_named(indiv_1718, "anon_chi")

  # Test for roughly correct number of rows
  expect_equal(nrow(indiv_1718), 100)
})

test_that("read multiple years works", {
  # Read in multiple years
  indiv <- read_slf_individual(c("1718", "1819"),
    columns = c("year", "anon_chi"),
    from = 1,
    to = 50
  )

  # Test for anything odd
  expect_type(indiv, "list")

  # Test for the existance of the correct variables
  expect_named(indiv, c("year", "anon_chi"))
  expect_length(indiv, 2)

  # Test for the correct number of rows (50 * 2)
  expect_equal(nrow(indiv), 100)

  # Test that we have 50 rows from each year
  expect_equal(
    dplyr::count(indiv, year),
    dplyr::tibble(year = c("1718", "1819"), n = c(50L, 50L))
  )
})

test_that("Partnership filtering works", {
  indiv_1718_edinburgh <- read_slf_individual("1718",
                                              partnership = "S37000012",
                                              columns = c("hscp2018"),
                                              from = 1,
                                              to = 10000)

  expect_true(all(indiv_1718_edinburgh$hscp2018 == "S37000012"))
  expect_equal(length(unique(indiv_1718_edinburgh$hscp2018)), 1)
  expect_gte(nrow(indiv_1718_edinburgh), 100)
})
