#' Generate a Source Linkage File, file path
#'
#' @param year Year of the file to be read, you can specify multiple years
#'  which will then be returned as one file
#' @param file_version Version of the file (individual / episode)
#'
#' @return a [fs_path][fs::fs-package] object
gen_file_path <- function(year, file_version) {
  # Clean up year
  # We want it in the format 1718
  # This will handle numbers or strings of the form 201718 or 1718
  year <- format_year(year)

  file_name <- paste0("source-", file_version, "-file-20", year, ".fst")

  file_path <-
    fs::path(
      "/conf", "hscdiip", "01-Source-linkage-files", file_name,
      ext = "fst"
    )

  return(file_path)
}
