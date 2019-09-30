test_that("Matching with a different name works", {
  # Use the example chi cohort included
  # Match on anon_chi
  cohort_with_anon <- chi_cohort %>%
    get_anon_chi(chi_var = "upi_number")

  # Default behaviour is to drop the matching var
  # we should now have an anon_chi var
  expect_false("upi_number" %in% names(cohort_with_anon))
  expect_true("anon_chi" %in% names(cohort_with_anon))

  # Number of rows and variables should be the same
  expect_equal(nrow(cohort_with_anon), nrow(chi_cohort))
  expect_equal(length(cohort_with_anon), length(chi_cohort))
})
