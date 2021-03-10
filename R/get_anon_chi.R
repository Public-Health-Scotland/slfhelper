#' Match on anon_chi to a dataset using CHI numbers
#'
#' @param tibb tibble or data frame
#' @param chi_var CHI variable: the name of the variable containing CHI
#' (default is chi)
#' @param drop Optional boolean indicating whether the existing chi_var
#' should be dropped - default is TRUE
#'
#' @return a tibble
#' @export
#'
#' @examples
#' chi_cohort %>% get_anon_chi()
#' chi_cohort %>% get_anon_chi(chi_var = "upi_number")
get_anon_chi <- function(tibb, chi_var = "chi", drop = TRUE) {
  default_name <- "chi"

  anon_chi_lookup <- fst::read_fst(
    "/conf/hscdiip/01-Source-linkage-files/CHI-to-Anon-lookup.fst"
  )

  tibb <- tibb %>%
    dplyr::left_join(
      anon_chi_lookup,
      by = stats::setNames(default_name, chi_var)
    )

  if (drop) {
    tibb <- tibb %>%
      dplyr::select(-{{ chi_var }})
  }
  return(tibb)
}
