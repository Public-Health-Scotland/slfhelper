#' Match on anon_chi to an object using CHI numbers
#'
#' @param data tibble or data frame
#' @param chi_var CHI variable: the name of the variable containg CHI (default is chi)
#'
#' @return a tibble
#' @export
#'
#' @examples
#' get_anon_chi(data)
#' get_anon_chi(data, chi_var = "uniqueid")
get_anon_chi <- function(data, chi_var = "chi") {
  return(data %>%
           dplyr::left_join(dplyr::rename(
             fst::read_fst(
               "/conf/hscdiip/01-Source-linkage-files/CHI-to-Anon-lookup.fst"
             ),
             !!(chi_var) := "chi"
           ),
           by = "chi"))
}
