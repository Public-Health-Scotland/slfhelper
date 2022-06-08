skip_on_ci()


test_that("Reads episode file correctly", {
  # Read file, test all years
  years <- c("1415", "1516", "1617", "1718", "1819", "1920", "2021", "2122")
  for (year in years) {
    ep_file <- read_slf_episode(year, from = 100, to = 110)

    # Test for anything odd
    expect_s3_class(ep_file, "tbl_df")
    expect_named(ep_file)

    # Test for the correct number of rows
    expect_equal(nrow(ep_file), 11)

    # Test for correct number of variables (will need updating)
    expect_length(ep_file, 243)
  }
})
