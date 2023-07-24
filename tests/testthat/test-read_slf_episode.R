skip_on_ci()

# Read file, test all years
years <- c(
  "1415",
  "1516",
  "1617",
  "1718",
  "1819",
  "1920",
  "2021",
  "2122",
  "2223"
)

for (year in years) {
  set.seed(50)

  ep_file <- read_slf_episode(year) %>%
    dplyr::slice_sample(n = 110)

  test_that("Reads episode file correctly", {
    # Test for anything odd
    expect_s3_class(ep_file, "tbl_df")
    expect_named(ep_file)

    # Test for the correct number of rows
    expect_equal(nrow(ep_file), 110)
  })

  test_that("Episode file has the expected number of variables", {
    # Test for correct number of variables (will need updating)
    expect_length(ep_file, 241)
  })
}
