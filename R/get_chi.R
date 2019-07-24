#' Match on CHI numbers to a dataset using anon_chi
#'
#' @param data tibble or data frame
#' @param anon_chi_var Anon CHI variable: the name of the variable containg anonymised CHI (default is anon_chi)
#' @param drop Optional boolean indicating whether the existing anon_ch_var should be dropped - default is TRUE
#'
#' @return a tibble
#' @export
#'
#' @examples
#' get_chi(data)
#' get_chi(data, drop = FALSE)
get_chi <- function(data, anon_chi_var = "anon_chi", drop = TRUE) {
  default_name <- "anon_chi"

  chi_lookup <- fst::read_fst(
    "/conf/hscdiip/01-Source-linkage-files/Anon-to-CHI-lookup.fst"
  )

  data <- data %>%
    dplyr::left_join(
      chi_lookup,
      by = setNames(default_name, anon_chi_var)
    )

  if (drop) {
    data <- data %>%
      dplyr::select(-{{ anon_chi_var }})
  }

  return(data)
}
