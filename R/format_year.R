#' Format a year into the correct short FY format
#'
#' @inheritParams gen_file_path
#'
#' @return Year correctly formatted into short FY e.g. '1718'
format_year <- function(year) {
  formatted_year <- as.character(year) %>%
    stringr::str_remove("/") %>%
    stringr::str_extract("[1-9][0-9]{3}$")

  return(formatted_year)
}
