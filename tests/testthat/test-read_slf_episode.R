test_that("Reads episode file correctly", {
  # Read file, test all years
  years <- c("1415", "1516", "1617", "1718", "1819", "1920", "2021")
  for (year in years) {
    ep_file <- read_slf_episode(year, from = 100, to = 110)

    # Test for anything odd
    expect_type(ep_file, "list")
    expect_named(ep_file)

    # Test for correct number of variables (will need updating)
    expect_length(ep_file, 234)

    # Test for roughly correct number of rows
    expect_equal(nrow(ep_file), 11)
  }
})
