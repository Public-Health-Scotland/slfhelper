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

#' Check the year(s) supplied are valid
#'
#' @inheritParams gen_file_path
#'
#' @return `TRUE` if the year is valid and a newer year, `FALSE` for any
#' older but still valid years. Otherwise throws an error.
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
    cli::cli_abort(c("Invalid year:'{year}' was supplied.",
      "i" = "Years should be supplied in the short financial year format e.g. '1718'"
    ))
  } else if (as.integer(substring(formatted_year, 1, 2)) + 1
  != as.integer(substring(formatted_year, 3, 4))) {
    cli::cli_abort(c("Ambiguous year:'{year}' was supplied.",
      "i" = "Years should be supplied in the short financial year format e.g. '1718'"
    ))
  } else if (formatted_year < min_year) {
    cli::cli_abort(c("Invalid year:'{year}' was supplied.",
      "i" = "The oldest file available is {min_year}."
    ))
  }

  check <- dplyr::case_when(
    formatted_year >= min_full_years ~ TRUE,
    formatted_year >= min_year ~ FALSE
  )

  return(check)
}
