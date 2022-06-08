skip_on_ci()


test_that("Episode files exist", {
  # Episode files
  expect_true(fs::file_exists(gen_file_path("1415", "episode")))
  expect_true(fs::file_exists(gen_file_path("1516", "episode")))
  expect_true(fs::file_exists(gen_file_path("1617", "episode")))
  expect_true(fs::file_exists(gen_file_path("1718", "episode")))
  expect_true(fs::file_exists(gen_file_path("1819", "episode")))
  expect_true(fs::file_exists(gen_file_path("1920", "episode")))
  expect_true(fs::file_exists(gen_file_path("2021", "episode")))
  expect_true(fs::file_exists(gen_file_path("2122", "episode")))
})


test_that("Individual files exist", {
  expect_true(fs::file_exists(gen_file_path("1415", "individual")))
  expect_true(fs::file_exists(gen_file_path("1516", "individual")))
  expect_true(fs::file_exists(gen_file_path("1617", "individual")))
  expect_true(fs::file_exists(gen_file_path("1718", "individual")))
  expect_true(fs::file_exists(gen_file_path("1819", "individual")))
  expect_true(fs::file_exists(gen_file_path("1920", "individual")))
  expect_true(fs::file_exists(gen_file_path("2021", "individual")))
  expect_true(fs::file_exists(gen_file_path("2122", "individual")))
})
