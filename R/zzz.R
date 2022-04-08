#' Check if it's a server session
#'
#' @return Boolean
check_on_server <- function() {
  on_server <- rstudioapi::versionInfo()$mode == "server"

  if (!on_server) {
    cli::cli_warn(c(
      "It looks like you are not on the PHS RStudio server.",
      "This is a requirement for this package, go to:",
      ">" = "{.url https://rstudio.nhsnss.scot.nhs.uk/}"
    ))
  }

  return(on_server)
}

#' Check if the current user is in a UNIX group
#'
#' @param group The group to check, default is hscdiip
#'
#' @return Boolean
check_has_access <- function(group = "hscdiip") {
  has_access <- grepl(
    paste0("\\b", group, "\\b"),
    system("groups", intern = TRUE)
  )

  if (!has_access) {
    cli::cli_warn(c(
      "You might not have the relevant access.",
      "i" = "Access to UNIX {group} is required."
    ))
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
