#' Match on CHI numbers to a dataset using anon_chi
#'
#' @param tibb tibble or data frame
#' @param anon_chi_var Anon CHI variable: the name of the variable
#' containing anonymised CHI (default is anon_chi)
#' @param drop Optional boolean indicating whether the existing `anon_chi_var`
#' should be dropped - default is TRUE
#'
#' @return a tibble
#' @export
#'
#' @examples
#' slf_1718 <- read_slf_individual("1718", from = 1, to = 100)
#' get_chi(slf_1718)
#' get_chi(slf_1718, drop = FALSE)
get_chi <- function(tibb, anon_chi_var = "anon_chi", drop = TRUE) {
  default_name <- "anon_chi"

  chi_lookup <- fst::read_fst(
    "/conf/hscdiip/01-Source-linkage-files/Anon-to-CHI-lookup.fst"
  )

  tibb <- tibb %>%
    dplyr::left_join(
      chi_lookup,
      by = stats::setNames(default_name, anon_chi_var)
    )

  if (drop) {
    tibb <- tibb %>%
      dplyr::select(-{{ anon_chi_var }})
  }

  return(tibb)
}
