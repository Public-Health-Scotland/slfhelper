skip_on_ci()


test_that("Episode files exist", {
  # Episode files
  expect_true(fs::file_exists(gen_file_path("1415", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1516", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1617", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1718", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1819", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1920", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("2021", "episode", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("2122", "episode", ext = "parquet")))
})


test_that("Individual files exist", {
  expect_true(fs::file_exists(gen_file_path("1415", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1516", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1617", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1718", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1819", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("1920", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("2021", "individual", ext = "parquet")))
  expect_true(fs::file_exists(gen_file_path("2122", "individual", ext = "parquet")))
})
