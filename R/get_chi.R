#' Match on CHI numbers to an object using anon_chi
#'
#' @param data tibble or data frame
#' @param anon_chi_var Anon CHI variable: the name of the variable containg anonymised CHI (default is anon_chi)
#'
#' @return a tibble
#' @export
#'
#' @examples
#' get_chi(data)
get_chi <- function(data, anon_chi_var = "anon_chi") {
  default_name <- "anon_chi"
  return(data %>%
    dplyr::left_join(
      fst::read_fst(
        "/conf/hscdiip/01-Source-linkage-files/Anon-to-CHI-lookup.fst"
      ),
      by = setNames(default_name, anon_chi_var)
    ))
}
