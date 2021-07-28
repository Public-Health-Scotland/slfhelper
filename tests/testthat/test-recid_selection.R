test_that("Recid filtering works", {
  # Read in a bit of a file selecting only Edinburgh
  ep_1718_acute <- read_slf_episode("1718",
    recids = "01B",
    columns = c("recid"),
    from = 1000,
    to = 100000
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
    recids = c("01B", "02B", "04B"),
    columns = c("recid"),
    from = 1000,
    to = 100000
  )
  # Should only have SMRA 1, 2 and 4
  expect_equal(sort(unique(ep_1718_acute$recid)), c("01B", "02B", "04B"))
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(ep_1718_acute), 100)
})

test_that("Can still do filtering if variable is not selected", {
  # Read in a bit of a file selecting only Edinburgh
  # Don't choose to read the partnership variable
  ep_1718_acute <- read_slf_episode("1718",
    recids = "01B",
    columns = c("sparra_end_fy"),
    from = 1000,
    to = 100000
  )

  # We shouldn't have the recid variable
  expect_false("recid" %in% names(ep_1718_acute))

  # Should still have the variables we picked
  expect_equal(names(ep_1718_acute), "sparra_end_fy")

  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(ep_1718_acute), 100)
})

test_that("Still reads all variables if just filtering", {
  ep_1718_acute <- read_slf_episode("1718",
    recids = "01B",
    from = 1000,
    to = 100000
  )

  # Should only have Edinburgh codes
  expect_true(all(ep_1718_acute$recid == "01B"))
  # Should only be one unique code
  expect_equal(length(unique(ep_1718_acute$recid)), 1)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(ep_1718_acute), 100)
  # Should have all variables
  expect_gte(length(ep_1718_acute), 200)
})
