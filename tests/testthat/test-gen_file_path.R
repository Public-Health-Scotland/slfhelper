test_that("Produces single episode file path", {
  path <- gen_file_path("1718", "episode")

  expect_equal(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-episode-file-1718.fst"
  ))

  expect_equal(fs::path_ext(path), "fst")
})


test_that("Produces single individual file path", {
  path <- gen_file_path("1718", "individual")

  expect_equal(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-individual-file-1718.fst"
  ))

  expect_equal(fs::path_ext(path), "fst")
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
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1415.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1516.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1617.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1718.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1819.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-1920.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-episode-file-2021.fst"
    ))
  )

  expect_equal(fs::path_ext(path), rep_len("fst", length(path)))
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
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1415.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1516.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1617.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1718.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1819.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-1920.fst",
      "/conf/hscdiip/01-Source-linkage-files/source-individual-file-2021.fst"
    ))
  )

  expect_equal(fs::path_ext(path), rep_len("fst", length(path)))
})
