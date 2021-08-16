#' Check if it's a server session
#'
#' @return Boolean
check_on_server <- function() {
  on_server <- rstudioapi::versionInfo()$mode == "server"

  if (!on_server) {
    warning("It looks like you are not on the PHS RStudio server. This is a requirement for this package, go to:\nhttps://rstudio.nhsnss.scot.nhs.uk/")
  }

  return(on_server)
}

#' Check if user is in hscdiip
#'
#' @param group The group to check
#'
#' @return Boolean
check_has_access <- function(group) {
  has_access <- grepl(paste0("\\b", group, "\\b"), system("groups", intern = TRUE))

  if (!has_access) {
    warning("It looks like you don't have the relevant access, access to UNIX hscdiip is required.")
  }

  return(has_access)
}

.onLoad <- function(libname, pkgname) {
  if (interactive()) {
    if (check_on_server()) {
      check_has_access(group = "hscdiip")
    }
  }
}
