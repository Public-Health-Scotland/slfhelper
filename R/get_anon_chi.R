#' Match on anon_chi to a dataset using CHI numbers
#'
#' @param chi_cohort a [tibble][tibble::tibble-package] or data frame.
#' @param chi_var CHI variable: the name of the variable containing CHI
#' (default is chi).
#' @param drop Optional boolean indicating whether the existing `chi_var`
#' should be dropped - default is TRUE.
#' @param check Optional boolean, should the CHIs be checked using
#' [phsmethods::chi_check()] - default is TRUE.
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
get_anon_chi <- function(chi_cohort, chi_var = "chi", drop = TRUE, check = TRUE) {
  if (check) {
    # Optional code, if the user has phsmethods installed check the CHIs with it.
    if (rlang::is_installed("phsmethods")) {
      checked_chi <- phsmethods::chi_check(
        dplyr::pull(chi_cohort, {{ chi_var }})
      )

      which_invalid <- which(
        !(checked_chi %in% c("Valid CHI", "Missing (Blank)", "Missing (NA)"))
      )

      n_invalid <- length(which_invalid)

      if (n_invalid > 10) {
        cli::cli_warn(c(
          "More than 10 of the CHIs supplied look invalid,",
          "you should check them with {.fn phsmethods::chi_check}"
        ))
      } else if (n_invalid > 0) {
        cli::cli_alert_warning(
          "Some of the CHI numbers supplied look invalid according to {.fn phsmethods::chi_check}"
        )
        print(tibble::tibble(
          {{ chi_var }} := dplyr::pull(chi_cohort, {{ chi_var }})[which_invalid],
          reason = checked_chi[which_invalid]
        ))
      }
    }
  }

  lookup <- tibble::tibble(
    chi = unique(chi_cohort[[chi_var]])
  ) %>%
    dplyr::mutate(
      anon_chi = purrr::map_chr(.data$chi, openssl::base64_encode)
    )

  chi_cohort <- chi_cohort %>%
    dplyr::left_join(
      lookup,
      by = stats::setNames("chi", chi_var)
    )

  if (drop) {
    chi_cohort <- chi_cohort %>%
      dplyr::select(-{{ chi_var }})
  }

  return(chi_cohort)
}
