test_that("Recid filtering works", {
  # Read in a bit of a file selecting only Edinburgh
  ep_1718_acute <- read_slf_episode("1718",
    recid = "01B",
    columns = c("recid"),
    from = 1,
    to = 10000
  )

  # Should only have Edinburgh codes
  expect_true(all(ep_1718_acute$recid == "01B"))
  # Should only be one unique code
  expect_equal(length(unique(ep_1718_acute$recid)), 1)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(ep_1718_acute), 100)
})


test_that("Can select multiple recids", {
  # Read in a bit of a file selecting Edinburgh and Glasgow
  ep_1718_acute <- read_slf_episode("1718",
    recid = c("01B", "02B", "04B"),
    columns = c("recid"),
    from = 1,
    to = 10000
  )
  # Should only have Edinburgh or Glasgow city codes
  expect_true(all(ep_1718_acute$recid %in% c("01B", "02B", "04B")))
  # Should be exactly 2 unique codes
  expect_equal(length(unique(ep_1718_acute$recid)), 3)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(ep_1718_acute), 100)
})
