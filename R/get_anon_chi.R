#' Match on anon_chi to a dataset using CHI numbers
#'
#' @param data tibble or data frame
#' @param chi_var CHI variable: the name of the variable containg CHI (default is chi)
#' @param drop Optional boolean indicating whether the existing chi_var should be dropped - default is TRUE
#'
#' @return a tibble
#' @export
#'
#' @examples
#' get_anon_chi(data)
#' get_anon_chi(data, drop = FALSE)
#' get_anon_chi(data, chi_var = "unique_id")
get_anon_chi <- function(data, chi_var = "chi", drop = TRUE) {
  default_name <- "chi"

  anon_chi_lookup <- fst::read_fst(
    "/conf/hscdiip/01-Source-linkage-files/CHI-to-Anon-lookup.fst"
  )

  data <- data %>%
    dplyr::left_join(
      anon_chi_lookup,
      by = setNames(default_name, chi_var)
    )

  if (drop) {
    data <- data %>%
      dplyr::select(-{{ chi_var }})
  }
  return(data)
}
