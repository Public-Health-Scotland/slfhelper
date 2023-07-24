skip_on_ci()


test_that("Partnership filtering works", {
  set.seed(50)

  # Read in a bit of a file selecting only Edinburgh
  indiv_1718_edinburgh <- read_slf_individual("1718",
    partnerships = "S37000012",
    col_select = c("hscp2018")
  ) %>%
    dplyr::slice_sample(n = 1000)

  # Should only have Edinburgh codes
  expect_true(all(indiv_1718_edinburgh$hscp2018 == "S37000012"))
  # Should only be one unique code
  expect_equal(length(unique(indiv_1718_edinburgh$hscp2018)), 1)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edinburgh), 10)
})


test_that("Can select multiple partnerships", {
  set.seed(50)

  # Read in a bit of a file selecting Edinburgh and Glasgow
  indiv_1718_edi_gla <- read_slf_individual("1718",
    partnerships = c("S37000012", "S37000015"),
    col_select = c("hscp2018")
  ) %>%
    dplyr::slice_sample(n = 1000)
  # Should only have Edinburgh or Glasgow city codes
  expect_true(all(indiv_1718_edi_gla$hscp2018 == "S37000012" |
    indiv_1718_edi_gla$hscp2018 == "S37000015"))
  # Should be exactly 2 unique codes
  expect_equal(length(unique(indiv_1718_edi_gla$hscp2018)), 2)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edi_gla), 100)
})

test_that("Can still do filtering if variable is not selected", {
  set.seed(50)

  # Read in a bit of a file selecting only Edinburgh
  # Don't choose to read the partnership variable
  indiv_1718_edinburgh <- read_slf_individual("1718",
    partnerships = "S37000012",
    col_select = c("hri_scot")
  ) %>%
    dplyr::slice_sample(n = 1000)

  # We shouldn't have the partnership variable
  expect_false("hscp2018" %in% names(indiv_1718_edinburgh))

  # Should still have the variables we picked
  expect_true("hri_scot" %in% names(indiv_1718_edinburgh))

  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edinburgh), 100)
})


test_that("Still reads all variables if just filtering", {
  set.seed(50)

  indiv_1718_edinburgh <- read_slf_individual("1718",
    partnerships = "S37000012"
  ) %>%
    dplyr::slice_sample(n = 1000)

  # Should only have Edinburgh codes
  expect_true(all(indiv_1718_edinburgh$hscp2018 == "S37000012"))
  # Should only be one unique code
  expect_equal(length(unique(indiv_1718_edinburgh$hscp2018)), 1)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edinburgh), 10)
  # Should have all variables
  expect_gte(length(indiv_1718_edinburgh), 150)
})
