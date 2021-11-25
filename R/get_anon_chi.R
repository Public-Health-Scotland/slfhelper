#' Match on anon_chi to a dataset using CHI numbers
#'
#' @param chi_cohort a [tibble][tibble::tibble-package] or data frame
#' @param chi_var CHI variable: the name of the variable containing CHI
#' (default is chi)
#' @param drop Optional boolean indicating whether the existing `chi_var`
#' should be dropped - default is TRUE
#'
#' @importFrom rlang :=
#'
#' @return a [tibble][tibble::tibble-package]
#' @export
#'
#' @examples
#' \dontrun{
#' chi_cohort %>% get_anon_chi()
#' chi_cohort %>% get_anon_chi(chi_var = "upi_number")
#' }
get_anon_chi <- function(chi_cohort, chi_var = "chi", drop = TRUE) {
  default_name <- "chi"

  # Optional code, if the user has phsmethods installed check the CHIs with it.
  if (requireNamespace("phsmethods", quietly = TRUE)) {
    checked_chi <- phsmethods::chi_check(dplyr::pull(chi_cohort, {{ chi_var }}))

    which_invalid <- which(checked_chi != "Valid CHI")
    n_invalid <- length(which_invalid)

    if (n_invalid > 10) {
      rlang::warn("More than 10 of the CHIs supplied look invalid, you should check them with phsmethods::chi_check()")
    } else if (n_invalid > 0) {
      rlang::inform("Some of the CHI numbers supplied look invalid according to phsmethods::chi_check()")
      print(tibble::tibble(
        {{ chi_var }} := dplyr::pull(chi_cohort, {{ chi_var }})[which_invalid],
        reason = checked_chi[which_invalid]
      ))
    }
  }

  anon_chi_lookup <- fst::read_fst(
    "/conf/hscdiip/01-Source-linkage-files/CHI-to-Anon-lookup.fst"
  )

  chi_cohort <- chi_cohort %>%
    dplyr::left_join(
      anon_chi_lookup,
      by = stats::setNames(default_name, chi_var)
    )

  if (drop) {
    chi_cohort <- chi_cohort %>%
      dplyr::select(-{{ chi_var }})
  }
  return(chi_cohort)
}
