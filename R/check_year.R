#' Check the year(s) supplied are valid
#'
#' @inheritParams gen_file_path
#'
#' @return `TRUE` if the year is valid and a newer year, `FALSE` for any
#' older but still valid years. Otherwise throws an error.
check_year <- function(year, call) {
  min_full_years <- "1415"
  min_year <- "1213"

  check <- FALSE

  formatted_year <- format_year(year)

  year_first_part <- as.integer(substring(formatted_year, 1L, 2L))
  year_last_part <- as.integer(substring(formatted_year, 3L, 4L))

  if (anyNA(formatted_year)) {
    cli::cli_abort(
      c("The year {.val {year}} is not valid.",
        "i" = "Values to {.arg year} should be supplied in the short financial year format e.g. {.val 1718}"
      ),
      call = call
    )
  } else if (any(year_first_part + 1L != year_last_part)) {
    cli::cli_abort(
      c("The year {.val {year}} is ambiguous.",
        "i" = "Values to {.arg year} should be supplied in the short financial year format e.g. {.val 1718}",
        "v" = "Did you mean {.val {paste0(year_first_part, year_first_part + 1L)}} or {.val {paste0(year_last_part - 1L, year_last_part)}}?"
      ),
      call = call
    )
  } else if (any(formatted_year < min_year)) {
    cli::cli_abort(
      c("The year {.val {year}} is not valid.",
        "i" = "The oldest valid {.arg year} is {.val {min_year}}."
      ),
      call = call
    )
  }

  check <- dplyr::case_when(
    formatted_year >= min_full_years ~ TRUE,
    formatted_year >= min_year ~ FALSE
  )

  return(check)
}
