test_that("Produces single episode file path", {
  path <- gen_file_path("1718", "episode")

  expect_identical(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-episode-file-201718.fst"
  ))

  expect_identical(fs::path_ext(path), "fst")
})


test_that("Produces single individual file path", {
  path <- gen_file_path("1718", "individual")

  expect_identical(path, fs::path(
    "/conf/hscdiip",
    "01-Source-linkage-files",
    "source-individual-file-201718.fst"
  ))

  expect_identical(fs::path_ext(path), "fst")
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

  expect_identical(path, fs::path(c(
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201415.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201516.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201617.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201718.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201819.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-201920.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-episode-file-202021.fst"
  )))

  expect_identical(fs::path_ext(path), rep_len("fst", length(path)))
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

  expect_identical(path, fs::path(c(
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201415.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201516.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201617.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201718.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201819.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-201920.fst",
    "/conf/hscdiip/01-Source-linkage-files/source-individual-file-202021.fst"
  )))

  expect_identical(fs::path_ext(path), rep_len("fst", length(path)))
})
