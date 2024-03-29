skip_on_ci()


test_that("read multiple years works for individual file", {
  set.seed(50)

  # Read in multiple years
  indiv <- read_slf_individual(c("1718", "1819"),
    col_select = c("year", "anon_chi")
  ) %>%
    dplyr::slice_sample(n = 100)

  # Test for anything odd
  expect_s3_class(indiv, "tbl_df")

  # Test for the existance of the correct variables
  expect_named(indiv, c("year", "anon_chi"))
  expect_length(indiv, 2)

  # Test for the correct number of rows (50 * 2)
  expect_equal(nrow(indiv), 100)

  # This test keeps failing as the rows are not equal to 50, e.g 29 and 21
  # # Test that we have 50 rows from each year
  # expect_equal(
  #   dplyr::count(indiv, year),
  #   tibble::tibble(year = c("1718", "1819"), n = c(50L, 50L))
  # )
})

test_that("read multiple years works for episode file", {
  set.seed(50)

  # Read in multiple years
  ep <- read_slf_episode(c("1718", "1819"),
    col_select = c("year", "anon_chi")
  ) %>%
    dplyr::slice_sample(n = 100)

  # Test for anything odd
  expect_s3_class(ep, "tbl_df")

  # Test for the existance of the correct variables
  expect_named(ep, c("year", "anon_chi"))
  expect_length(ep, 2)

  # Test for the correct number of rows (50 * 2)
  expect_equal(nrow(ep), 100)

  # This test keeps failing as the rows are not equal to 50, e.g 29 and 21
  # # Test that we have 50 rows from each year
  # expect_equal(
  #   dplyr::count(ep, year),
  #   tibble::tibble(year = c("1718", "1819"), n = c(50L, 50L))
  # )
})
