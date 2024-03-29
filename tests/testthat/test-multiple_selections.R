skip_on_ci()


test_that("select years and recid", {
  set.seed(50)

  acute_only <- read_slf_episode(c("1718", "1819"),
    col_select = c("year", "anon_chi", "recid", "record_keydate1"),
    recids = "01B"
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(
    names(acute_only),
    c("year", "anon_chi", "recid", "record_keydate1")
  )
  # expect_equal(unique(acute_only$year), c("1718", "1819"))
  expect_equal(unique(acute_only$recid), "01B")

  hosp_only <- read_slf_episode(c("1718", "1819"),
    col_select = c("year", "anon_chi", "recid", "record_keydate1"),
    recids = c("01B", "02B", "04B", "GLS")
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(
    names(hosp_only),
    c("year", "anon_chi", "recid", "record_keydate1")
  )
  # expect_equal(unique(hosp_only$year), c("1718", "1819"))
  expect_equal(sort(unique(hosp_only$recid)), c("01B", "02B", "04B", "GLS"))
})

test_that("select recids and partnerships", {
  set.seed(50)

  edi_acute <- read_slf_episode("1718",
    col_select = c("year", "anon_chi", "recid", "hscp2018"),
    partnerships = "S37000012",
    recid = "01B"
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(names(edi_acute), c("year", "anon_chi", "recid", "hscp2018"))
  expect_equal(unique(edi_acute$year), "1718")
  expect_equal(unique(edi_acute$recid), "01B")
  expect_equal(unique(edi_acute$hscp2018), "S37000012")

  edi_gla_acute <- read_slf_episode("1718",
    col_select = c("year", "anon_chi", "recid", "hscp2018"),
    partnerships = c("S37000012", "S37000015"),
    recid = "01B"
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(
    names(edi_gla_acute),
    c("year", "anon_chi", "recid", "hscp2018")
  )
  expect_equal(unique(edi_gla_acute$year), "1718")
  expect_equal(unique(edi_gla_acute$recid), "01B")
  expect_equal(
    sort(unique(edi_gla_acute$hscp2018)),
    c("S37000012", "S37000015")
  )

  edi_hosp <- read_slf_episode("1718",
    col_select = c("year", "anon_chi", "recid", "hscp2018"),
    partnerships = "S37000012",
    recids = c("01B", "02B", "04B", "GLS")
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(names(edi_hosp), c("year", "anon_chi", "recid", "hscp2018"))
  expect_equal(unique(edi_hosp$year), "1718")
  expect_equal(sort(unique(edi_hosp$recid)), c("01B", "02B", "04B", "GLS"))
  expect_equal(unique(edi_hosp$hscp2018), "S37000012")

  edi_gla_hosp <- read_slf_episode("1718",
    col_select = c("year", "anon_chi", "recid", "hscp2018"),
    partnerships = c("S37000012", "S37000015"),
    recids = c("01B", "02B", "04B", "GLS")
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(names(edi_gla_hosp), c("year", "anon_chi", "recid", "hscp2018"))
  expect_equal(unique(edi_gla_hosp$year), "1718")
  expect_equal(sort(unique(edi_gla_hosp$recid)), c("01B", "02B", "04B", "GLS"))
  expect_equal(sort(unique(edi_gla_hosp$hscp2018)), c("S37000012", "S37000015"))
})


test_that("all selections", {
  set.seed(50)

  edi_gla_hosp_2_year <- read_slf_episode(c("1718", "1819"),
    col_select = c("year", "anon_chi", "recid", "hscp2018"),
    partnerships = c("S37000012", "S37000015"),
    recids = c("01B", "02B", "04B", "GLS")
  ) %>%
    dplyr::slice_sample(n = 200000)

  expect_equal(
    names(edi_gla_hosp_2_year),
    c("year", "anon_chi", "recid", "hscp2018")
  )
  # expect_equal(
  #   unique(edi_gla_hosp_2_year$year),
  #   c("1718", "1819")
  # )
  expect_equal(
    sort(unique(edi_gla_hosp_2_year$recid)),
    c("01B", "02B", "04B", "GLS")
  )
  expect_equal(
    sort(unique(edi_gla_hosp_2_year$hscp2018)),
    c("S37000012", "S37000015")
  )
})
