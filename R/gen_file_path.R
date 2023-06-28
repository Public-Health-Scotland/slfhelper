#' Generate a Source Linkage File, file path
#'
#' @inheritParams read_slf
#'
#' @param call Supply environment from the top-level function to make any error
#' messages more useful.
#' @param dev `r lifecycle::badge("experimental")` Whether to get the file from
#' the development area (`/conf/sourcedev/Source_Linkage_File_Updates`).
#' The default (`FALSE`) will get the production file from the usual area.
#' @param ext `r lifecycle::badge("questioning")` The file extension to read.
#'
#' @return a [fs_path][fs::fs-package] object.
gen_file_path <- function(
    year,
    file_version,
    call,
    dev = FALSE,
    ext = "fst") {
  file_version <- match.arg(file_version, c("episode", "individual"))
  ext <- match.arg(ext, c("fst", "parquet"))

  # Clean up year
  # We want it in the format 1718
  # This will handle numbers or strings of the form 201718 or 1718
  if (!all(check_year(year, call = call))) {
    cli::cli_alert_info(
      "{.val {year}} is no longer updated and the data should be treated with
      caution."
    )
  }
  year <- format_year(year)

  file_name <- stringr::str_glue("source-{file_version}-file-20{year}")

  if (dev) {
    file_path <- fs::path(
      "/",
      "conf",
      "sourcedev",
      "Source_Linkage_File_Updates",
      year,
      stringr::str_glue("source-{file_version}-file-{year}"),
      ext = ext
    )
  } else {
    file_path <- fs::path(
      "/",
      "conf",
      "hscdiip",
      "01-Source-linkage-files",
      stringr::str_glue("source-{file_version}-file-20{year}"),
      ext = ext
    )
  }

  return(file_path)
}
