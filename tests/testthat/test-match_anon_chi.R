test_that("Matching with a different name works", {
  # Generate a sample which should contain at least some valid CHIs
  set.seed(1)
  n <- 100
  # Call it UPI number
  cohort <- dplyr::tibble(upi_number = paste0(
    round(runif(n, min = 0, max = 3)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 1)),
    round(runif(n, min = 0, max = 2)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9))
  ))

  # Match on anon_chi
  cohort_with_anon <- cohort %>%
    get_anon_chi(chi_var = "upi_number")

  # Default behaviour is to drop the matching var
  # we should now have an anon_chi var
  expect_false("upi_number" %in% names(cohort_with_anon))
  expect_true("anon_chi" %in% names(cohort_with_anon))

  # Number of rows and variables should be the same
  expect_equal(nrow(cohort_with_anon), nrow(cohort))
  expect_equal(length(cohort_with_anon), length(cohort))
})
