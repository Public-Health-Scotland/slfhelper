#' Format Year parameter
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
