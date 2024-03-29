#' Match on CHI numbers to a dataset using anon_chi
#'
#' @param data a [tibble][tibble::tibble-package] or data frame
#' @param anon_chi_var Anon CHI variable: the name of the variable
#' containing anonymised CHI (default is anon_chi)
#' @param drop Optional boolean indicating whether the existing `anon_chi_var`
#' should be dropped - default is TRUE
#'
#' @return a [tibble][tibble::tibble-package]
#' @export
#'
#' @examples
#' \dontrun{
#' slf_1718 <- read_slf_individual("1718")
#' get_chi(slf_1718)
#' get_chi(slf_1718, drop = FALSE)
#' }
get_chi <- function(data, anon_chi_var = "anon_chi", drop = TRUE) {
  lookup <- tibble::tibble(
    anon_chi = unique(data[[anon_chi_var]])
  ) %>%
    dplyr::mutate(
      anon_chi = dplyr::if_else(is.na(.data$anon_chi), "", .data$anon_chi),
      chi = unname(convert_anon_chi_to_chi(.data$anon_chi)),
      chi = dplyr::if_else(.data$chi == "", NA_character_, .data$chi)
    )
  data <- data %>%
    dplyr::left_join(
      lookup,
      by = stats::setNames("anon_chi", anon_chi_var)
    ) %>%
    dplyr::relocate("chi", .after = {{ anon_chi_var }})

  if (drop) {
    data <- data %>%
      dplyr::select(-{{ anon_chi_var }})
  }

  return(data)
}

convert_anon_chi_to_chi <- Vectorize(function(anon_chi) {
  chi <- openssl::base64_decode(anon_chi) %>%
    substr(2, 2) %>%
    paste0(collapse = "")

  return(chi)
})
