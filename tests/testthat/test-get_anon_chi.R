test_that("Matching with a different name works", {
  # Use the example chi cohort included

  # Match on anon_chi
  cohort_with_anon <- suppressWarnings(
    get_anon_chi(chi_cohort, chi_var = "upi_number")
  )

  # Default behaviour is to drop the matching variable
  # we should now have an anon_chi variable
  expect_false("upi_number" %in% names(cohort_with_anon))
  expect_true("anon_chi" %in% names(cohort_with_anon))

  # Number of rows and variables should be the same
  expect_equal(nrow(cohort_with_anon), nrow(chi_cohort))
  expect_equal(length(cohort_with_anon), length(chi_cohort))
})

test_that("Missing or blank CHIs match correctly", {
  data <- tibble::tibble(chi = c("", NA_character_))

  expect_snapshot(get_anon_chi(data))
  expect_snapshot(get_anon_chi(data, drop = FALSE))
})
