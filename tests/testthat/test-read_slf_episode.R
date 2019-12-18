test_that("Reads episode", {
  # Read file, test all years
  years <- c("1516", "1617", "1718", "1819")
  for (year in years) {
    ep_file <- read_slf_episode(year, from = 10000, to = 10010)

    # Test for anything odd
    expect_type(ep_file, "list")
    expect_named(ep_file)

    # Test for correct number of variables (will need updating)
    expect_length(ep_file, 223)

    # Test for roughly correct number of rows
    expect_equal(nrow(ep_file), 11)
  }
})
