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

  formatted_year <- format_year(year)

  if (!stringr::str_detect(
    formatted_year,
    "^\\d{2}\\d{2}$"
  ) |
    is.na(formatted_year)) {
    stop(
      stringr::str_glue(
        "Invalid year:'{year}' was supplied.
        \\n Years should be supplied in the short financial year format
        e.g. '1718'"
      )
    )
  } else if (as.integer(substring(formatted_year, 1, 2)) + 1
  != as.integer(substring(formatted_year, 3, 4))) {
    stop(
      stringr::str_glue(
        "Ambiguous year:'{year}' was supplied.
        \\n Years should be supplied in the short financial year format
        e.g. '1718'"
      )
    )
  } else if (formatted_year < min_year) {
    stop(
      stringr::str_glue(
        "Invalid year:'{year}' was supplied.
        \\nThe oldest file available is 20{min_year}."
      )
    )
  }


  check <- dplyr::case_when(
    formatted_year >= min_full_years ~ TRUE,
    formatted_year >= min_year ~ FALSE)


  return(check)
}

