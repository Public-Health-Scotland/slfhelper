test_that("Partnership filtering works", {
  indiv_1718_edinburgh <- read_slf_individual("1718",
                                              partnership = "S37000012",
                                              columns = c("hscp2018"),
                                              from = 1,
                                              to = 10000)

  expect_true(all(indiv_1718_edinburgh$hscp2018 == "S37000012"))
  expect_equal(length(unique(indiv_1718_edinburgh$hscp2018)), 1)
  expect_gte(nrow(indiv_1718_edinburgh), 100)
})
