skip_on_ci()


test_that("Reads individual file correctly", {
  # Read file, test all years
  years <- years <- c("1415", "1516", "1617", "1718", "1819", "1920", "2021", "2122")
  for (year in years) {
    indiv_file <- read_slf_individual(year, from = 1, to = 100)

    # Test for anything odd
    expect_s3_class(indiv_file, "tbl_df")
    expect_named(indiv_file)

    # Test for the correct number of rows
    expect_equal(nrow(indiv_file), 100)

    # Test for correct number of variables (will need updating)
    expect_length(indiv_file, 189)
  }
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

  # Test for the existence of the anon_chi var
  expect_named(indiv_1718, "anon_chi")

  # Test for roughly correct number of rows
  expect_equal(nrow(indiv_1718), 100)
})
