test_that("Match CHI to individual file", {
  # Read 100 records from indiv file
  indiv_1718_small <- read_slf_individual("1718",
                                          columns = c("anon_chi"),
                                          from = 1, to = 100
  )
  # Match on the chi
  indiv_1718_with_CHI <- indiv_1718_small %>% get_chi()

  # Catch anything wierd
  expect_type(indiv_1718_with_CHI, "list")

  # Default behaviour is to drop the anon_chi we should now have a chi var
  expect_true("chi" %in% names(indiv_1718_with_CHI))
  expect_false("anon_chi" %in% names(indiv_1718_with_CHI))

  # Number of rows and variables should be the same
  expect_equal(nrow(indiv_1718_with_CHI), nrow(indiv_1718_small))
  expect_equal(length(indiv_1718_with_CHI), length(indiv_1718_small))
})

test_that("Match CHI to episode file", {
  # Read 1000 records from ep file
  # Start at 100000 to avoid blank anon_chis
  ep_1718_small <- read_slf_episode("1718",
                                    columns = c("anon_chi"),
                                    from = 100000,
                                    to = 101000
  )
  # Match on the chi
  ep_1718_with_CHI <- ep_1718_small %>% get_chi()

  # Catch anything wierd
  expect_type(ep_1718_with_CHI, "list")

  # Default behaviour is to drop the anon_chi we should now have a chi var
  expect_true("chi" %in% names(ep_1718_with_CHI))
  expect_false("anon_chi" %in% names(ep_1718_with_CHI))

  # Number of rows and variables should be the same
  expect_equal(nrow(ep_1718_with_CHI), nrow(ep_1718_small))
  expect_equal(length(ep_1718_with_CHI), length(ep_1718_small))
})
