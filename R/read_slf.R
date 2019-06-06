#' Read a Source Linkage File
#'
#' @param year Year of the file to be read
#' @param file_version Version of the file (Individual / episode)
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#'
#' @examples
#' read_slf("1718", "episode")
read_slf <- function(year, file_version, ...) {
  # Clean up year

  # We want it in the format 1718
  # This will handle numbers or strings of the form 201718 or 1718
  year <- stringr::str_extract(as.character(year), "\\d{2}\\d{2}$")

  file_path <-
    stringr::str_glue(
      "/conf/hscdiip/01-Source-linkage-files/source-{file_version}-file-20{year}.fst"
    )

  slf <- fst::read_fst(file_path, ...)

  return(slf)
}

#' Read a Source Linkage episode file
#'
#' @param year of the file you would like to load
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_episode("1718")
#' read_slf_episode("1718",
#' columns = c("anon_chi", "dob", "demographic_cohort"),
#' from = 100000, to = 200000)
read_slf_episode <- function(year, ...) {
  return(read_slf(year = year, file_version = "episode"))
}

#' Read a Source Linkage individual file
#'
#' @param year of the file you would like to load
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_individual("1718")
#' read_slf_individual("1718", columns = c("anon_chi", "dob", "hri_scot"), from = 100000, to = 200000)
read_slf_individual <- function(year, ...) {
  return(read_slf(year = year, file_version = "individual"))
}
