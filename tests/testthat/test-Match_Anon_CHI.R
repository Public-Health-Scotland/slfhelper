test_that("Match CHI to individual file", {
  indiv_1718_small <- read_slf_individual("1718") %>% sample_frac(0.1)
  indiv_1718_with_CHI <- indiv_1718_small %>% get_chi()

  expect_type(indiv_1718_with_CHI, "list")
  expect_true("chi" %in% names(indiv_1718_with_CHI))
  expect_equal(nrow(indiv_1718_with_CHI), nrow(indiv_1718_small))
  expect_gt(length(indiv_1718_with_CHI), length(indiv_1718_small))
})

test_that("Match CHI to episode file", {
  ep_1718_small <- read_slf_episode("1718") %>% sample_frac(0.1)
  ep_1718_with_CHI <- ep_1718_small %>% get_chi()

  expect_type(ep_1718_with_CHI, "list")
  expect_true("chi" %in% names(ep_1718_with_CHI))
  expect_equal(nrow(ep_1718_with_CHI), nrow(ep_1718_small))
  expect_gt(length(ep_1718_with_CHI), length(ep_1718_small))
})


test_that("Matching with a different name works", {
  set.seed(1)
  n <- 100
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

  cohort_with_anon <- cohort %>% get_anon_chi(chi_var = "upi_number")

  expect_true("upi_number" %in% names(cohort_with_anon))
  expect_true("anon_chi" %in% names(cohort_with_anon))
  expect_equal(nrow(cohort_with_anon), nrow(cohort))
  expect_gt(length(cohort_with_anon), length(cohort))
})

