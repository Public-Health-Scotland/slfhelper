#' Read a Source Linkage File
#'
#' @param year Year of the file to be read
#' @param file_version Version of the file (Individual / episode)
#' @param partnership Optional specify Partnership to select (not yet implemented)
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#'
#' @examples
#' read_slf("1718", "episode")
read_slf <- function(year, file_version, partnership = NA_character_, ...) {
  # Clean up year

  # We want it in the format 1718
  # This will handle numbers or strings of the form 201718 or 1718
  year <- format_year(year)

  file_path <-
    paste0(
      "/conf/hscdiip/01-Source-linkage-files/source-",
      file_version,
      "-file-20",
      year,
      ".fst"
    )
  # TODO wrap this with a furrr::future_map() then bind_rows() - to deal with multiple years
  # TODO Add a filter to partnership here
  slf <- fst::read_fst(file_path, ...)

  return(slf)
}



#' Format Year parameter
#'
#' @param year Year in any format
#'
#' @return Year correctly formatted as "CCYY"
#'
#' @examples
#' format_year("2017/18")
format_year <- function(year) {
  year <- stringr::str_remove(year, "/")
  year <- stringr::str_extract(as.character(year), "\\d{2}\\d{2}$")
  return(year)
}



#' Read a Source Linkage episode file
#'
#' @param year of the file you would like to load
#' @param partnership Optional specify Partnership to select
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_episode("1718")
#' read_slf_episode("1718",
#'   columns = c("anon_chi", "dob", "demographic_cohort"),
#'   from = 100000, to = 200000
#' )
read_slf_episode <- function(year, partnership = NA_character_, ...) {
  # TODO add option to drop blank CHIs?
  # TODO add a filter by recid option
  return(read_slf(year = year, file_version = "episode", partnership = partnership, ...))
}



#' Read a Source Linkage individual file
#'
#' @param year of the file you would like to load
#' @param partnership Optional specify Partnership to select
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_individual("1718")
#' read_slf_individual("1718", columns = c("anon_chi", "dob", "hri_scot"), from = 100000, to = 200000)
read_slf_individual <- function(year, partnership = NA_character_, ...) {
  return(read_slf(year = year, file_version = "individual", partnership = partnership, ...))
}
