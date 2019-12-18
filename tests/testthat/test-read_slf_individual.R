test_that("Reads individual", {
  # Read file, pick a year at random
  year <- sample(c("1516", "1617", "1718", "1819"), 1)
  indiv_file <- read_slf_individual(year, from = 1, to = 100)

  # Test for anything odd
  expect_type(indiv_file, "list")
  expect_named(indiv_file)

  # Test for correct number of variables (will need updating)
  expect_length(indiv_file, 162)

  # Test for roughly correct number of rows
  expect_equal(nrow(indiv_file), 100)
})

test_that("column selection works", {
  indiv_1718 <- read_slf_individual("1718",
    columns = c("anon_chi"),
    from = 1, to = 100
  )

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
