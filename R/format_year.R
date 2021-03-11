#' Format a year into the correct FY format
#'
#' @param year Year in any format
#'
#' @return Year correctly formatted as "CCYY"
#'
format_year <- function(year) {
  year <- stringr::str_remove(year, "/")
  year <- stringr::str_extract(as.character(year), "\\d{2}\\d{2}$")
  return(year)
}

#' Check the year(s) supplied are valid
#'
#' @param year A year in the short FY format use `format_year()`
#'
#' @return TRUE if pass otherwise an error message
check_year <- function(year) {

  min_full_years <- "1415"
  min_year <- "1213"

  check <- FALSE

  if (!stringr::str_detect(year, "^\\d{2}\\d{2}$") | is.na(year)) {
    stop("An incorrect year was supplied\\n years should be supplied in the short financial year format e.g. '1718'")
  } else if (as.integer(substring(year, 1, 2)) + 1 != as.integer(substring(year, 3, 4))) {
    stop("An ambiguous year was supplied\\n years should be supplied in the short financial year format e.g. '1718'")
  }


  check <- dplyr::case_when(
    year >= min_year ~ TRUE,
    TRUE ~ FALSE
  )


  return(check)
}

