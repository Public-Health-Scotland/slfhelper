test_that("Produces single episode file path", {
  path <- gen_file_path("1718", "episode")

  expect_equal(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-episode-file-1718.parquet"
  ))

  expect_equal(fs::path_ext(path), "parquet")
})


test_that("Produces single individual file path", {
  path <- gen_file_path("1718", "individual")

  expect_equal(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-individual-file-1718.parquet"
  ))

  expect_equal(fs::path_ext(path), "parquet")
})

test_that("Produces correct episode file paths for multiple years", {
  path <- gen_file_path(
    c(
      "1415",
      "1516",
      "1617",
      "1718",
      "1819",
      "1920",
      "2021"
    ),
    "episode"
  )

  expect_equal(
    path,
    fs::path(c(
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1415.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1516.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1617.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1718.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1819.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1920.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-2021.parquet"
    ))
  )

  expect_equal(fs::path_ext(path), rep_len("parquet", length(path)))
})

test_that("Produces correct individual file paths for multiple years", {
  path <- gen_file_path(
    c(
      "1415",
      "1516",
      "1617",
      "1718",
      "1819",
      "1920",
      "2021"
    ),
    "individual"
  )

  expect_equal(
    path,
    fs::path(c(
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1415.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1516.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1617.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1718.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1819.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1920.parquet",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-2021.parquet"
    ))
  )

  expect_equal(fs::path_ext(path), rep_len("parquet", length(path)))
})
