skip_on_ci()


test_that("Episode files are readable", {
  # Episode files
  expect_true(fs::file_access(gen_file_path("1415", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1516", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1617", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1718", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1819", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1920", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2021", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2122", "episode"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2223", "episode"), mode = "read"))
})


test_that("Individual files are readable", {
  expect_true(fs::file_access(gen_file_path("1415", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1516", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1617", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1718", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1819", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("1920", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2021", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2122", "individual"), mode = "read"))
  expect_true(fs::file_access(gen_file_path("2223", "individual"), mode = "read"))
})
