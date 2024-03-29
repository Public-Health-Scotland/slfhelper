test_that("Can get CHI numbers for an arbitrary set of anon_chi numbers", {
  data <- tibble::tibble(
    anon_chi = c(
      "MjYwMTIxMTYxOA==",
      "MjIxMDY4MDYzMQ==",
      "MTQxMDkyMDc1NA==",
      "MzExMjM1ODE1OA==",
      "MDExMjQxODE1Ng==",
      "MDYxMjczMjI0Mw==",
      "MjMxMDQ3NDAxNQ==",
      "MjQxMTA2MzY5OA==",
      "MzgwMTExMjM3NA==",
      "MjMxMTE2MTIzMw==",
      "",
      NA_character_
    )
  )

  expect_snapshot(get_chi(data))

  expect_snapshot(get_chi(data, drop = FALSE))
})

skip_on_ci()

test_that("Match CHI to individual file", {
  set.seed(50)

  # Read 100 records from individual file
  indiv_1718_small <- read_slf_individual("1718",
    col_select = c("anon_chi")
  ) %>%
    dplyr::slice_sample(n = 100)

  # Match on the chi
  indiv_1718_with_chi <- indiv_1718_small %>% get_chi()

  # Catch anything weird
  expect_type(indiv_1718_with_chi, "list")

  # Default behaviour is to drop the anon_chi we should now have a chi var
  expect_true("chi" %in% names(indiv_1718_with_chi))
  expect_false("anon_chi" %in% names(indiv_1718_with_chi))

  # Number of rows and variables should be the same
  expect_equal(nrow(indiv_1718_with_chi), nrow(indiv_1718_small))
  expect_equal(length(indiv_1718_with_chi), length(indiv_1718_small))
})

test_that("Match CHI to episode file", {
  set.seed(50)

  # Read 100 records from ep file
  ep_1718_small <- read_slf_episode("1718",
    col_select = c("anon_chi")
  ) %>%
    dplyr::slice_sample(n = 100)

  # Match on the chi
  ep_1718_with_chi <- ep_1718_small %>% get_chi()

  # Catch anything wierd
  expect_type(ep_1718_with_chi, "list")

  # Default behaviour is to drop the anon_chi we should now have a chi var
  expect_true("chi" %in% names(ep_1718_with_chi))
  expect_false("anon_chi" %in% names(ep_1718_with_chi))

  # Number of rows and variables should be the same
  expect_equal(nrow(ep_1718_with_chi), nrow(ep_1718_small))
  expect_equal(length(ep_1718_with_chi), length(ep_1718_small))
})
