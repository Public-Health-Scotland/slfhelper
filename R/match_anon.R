



get_chi <- function(data, anon_chi_var = "anon_chi") {
  return(data %>%
           dplyr::left_join(
             fst::read_fst(
               "/conf/hscdiip/01-Source-linkage-files/Anon-to-CHI-lookup.fst"
             ),
             by = c(anon_chi_var = "anon_chi")
           ))
}

get_anon_chi <- function(data, chi_var = "chi") {
  return(data %>%
           dplyr::left_join(
             fst::read_fst(
               "/conf/hscdiip/01-Source-linkage-files/CHI-to-Anon-lookup.fst"
             ),
             by = c(chi_var = "chi")
           ))
}
