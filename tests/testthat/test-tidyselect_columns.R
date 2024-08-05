test_that("tidyselect helpers work for column selection in the episode file", {
  expect_named(
    read_slf_episode("1920", col_select = dplyr::starts_with("dd")),
    c("dd_responsible_lca", "dd_quality")
  )
  expect_named(
    read_slf_episode("1920", col_select = c("year", dplyr::starts_with("dd"))),
    c("year", "dd_responsible_lca", "dd_quality")
  )
  expect_named(
    read_slf_episode("1920", col_select = !dplyr::matches("[aeiou]"))
  )
})

test_that("col_select works when columns are added", {
  expect_named(
    read_slf_episode("1920", col_select = "year", recids = "DD"),
    "year"
  )
  expect_named(
    read_slf_episode("1920", col_select = "year", partnerships = "S37000001"),
    "year"
  )
  expect_named(
    read_slf_episode(
      "1920",
      col_select = c("year", dplyr::contains("dd")),
      recids = "DD"
    )
  )
  expect_named(
    read_slf_episode(
      "1920",
      col_select = c("year", dplyr::contains("cij")),
      partnerships = "S37000001"
    )
  )
})

test_that("tidyselect helpers work for column selection in the individual file", {
  expect_named(
    read_slf_individual("1920", col_select = dplyr::starts_with("dd")),
    c("dd_noncode9_episodes", "dd_noncode9_beddays", "dd_code9_episodes", "dd_code9_beddays")
  )
  expect_named(
    read_slf_individual("1920", col_select = c("year", dplyr::starts_with("dd"))),
    c("year", "dd_noncode9_episodes", "dd_noncode9_beddays", "dd_code9_episodes", "dd_code9_beddays")
  )
  expect_named(
    read_slf_individual("1920", col_select = !dplyr::matches("[aeiou]"))
  )
})
