test_that("episode file vars match the vars list", {
  data_vars <- ep_file_vars
  file_vars <- as.list(names(read_slf_episode("1819", from = 1, to = 1)))

  expect_identical(data_vars, file_vars)
})

test_that("individual file vars match the vars list", {
  data_vars <- ep_file_vars
  file_vars <- as.list(names(read_slf_individual("1819", from = 1, to = 1)))

  expect_identical(data_vars, file_vars)
})
