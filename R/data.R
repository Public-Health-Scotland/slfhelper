#' Episode file variables
#'
#' The names of the variables in the episode files,
#' in the correct order.
#'
#' @name ep_file_vars
#' @docType data
#' @keywords data
"ep_file_vars"

#' Individual file variables
#'
#' The names of the variables in the individual files,
#' in the correct order.
#'
#' @name indiv_file_vars
#' @docType data
#' @keywords data
"indiv_file_vars"

#' HSCP name / code lookup
#'
#' A [tibble][tibble::tibble-package]
#' containing the names and codes (hscp2018 configuration) of partnerships.
#' To be used with the \code{partnership} parameter when reading files.
#'
#' @format A [tibble][tibble::tibble-package] with 31 rows and 2 variables:
#' \describe{
#'   \item{partnership_name}{The official name of the Partnership}
#'   \item{hscp2018}{The hscp2018 standard code S370000??}
#' }
#' @name partnerships
#' @docType data
#' @keywords data
"partnerships"

#' Recid name / description lookup
#'
#' A [tibble][tibble::tibble-package]
#' containing the names and description of the recids.
#' To be used with the \code{recid} parameter when reading the episode files.
#'
#' @format A [tibble][tibble::tibble-package] with 18 rows and 2 variables:
#' \describe{
#'   \item{recid}{The short-form recid}
#'   \item{Description}{A description of the recid}
#' }
#' @name recids
#' @docType data
#' @keywords data
"recids"

#' A tibble containing an example cohort of CHI numbers under different
#' variable names. It is used for testing and to illustrate examples.
#' It is likely that many of the 'chi numbers' are not valid.
#'
#' @name chi_cohort
#' @docType data
#' @keywords data
"chi_cohort"
