test_that("Recid filtering works", {
  # Read in a bit of a file selecting only Edinburgh
  ep_1718_edinburgh <- read_slf_individual("1718",
                                              partnership = "S37000012",
                                              columns = c("hscp2018"),
                                              from = 1,
                                              to = 10000
  )
  
  # Should only have Edinburgh codes
  expect_true(all(indiv_1718_edinburgh$hscp2018 == "S37000012"))
  # Should only be one unique code
  expect_equal(length(unique(indiv_1718_edinburgh$hscp2018)), 1)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edinburgh), 100)
})


test_that("Can select multiple partnerships", {
  # Read in a bit of a file selecting Edinburgh and Glasgow
  indiv_1718_edi_gla <- read_slf_individual("1718",
                                            partnership = c("S37000012", "S37000015"),
                                            columns = c("hscp2018"),
                                            from = 1,
                                            to = 10000
  )
  # Should only have Edinburgh or Glasgow city codes
  expect_true(all(indiv_1718_edi_gla$hscp2018 == "S37000012" |
                    indiv_1718_edi_gla$hscp2018 == "S37000015"))
  # Should be exactly 2 unique codes
  expect_equal(length(unique(indiv_1718_edi_gla$hscp2018)), 2)
  # Should have at least 100 records (checks we're not getting an empty file)
  expect_gte(nrow(indiv_1718_edi_gla), 100)
})
