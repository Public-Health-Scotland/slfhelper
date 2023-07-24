#' Check if it's a server session
#'
#' @return Boolean
check_on_server <- function() {
  on_server <- rstudioapi::versionInfo()$mode == "server"

  if (!on_server) {
    cli::cli_warn(
      c(
        "!" = "You are not using RStudio on the PHS Posit Workbench environment.",
        "This is a requirement for this package, go to:",
        ">" = "{.url https://pwb.publichealthscotland.org/}"
      ),
      call = rlang::caller_env()
    )
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
    group,
    system2(
      command = "groups",
      args = Sys.getenv("USER"),
      stdout = TRUE
    ),
    fixed = TRUE
  )

  return(has_access)
}

.onLoad <- function(libname, pkgname) {
  if (interactive()) {
    if (check_on_server()) {
      if (!check_has_access(group = "hscdiip")) {
        cli::cli_warn(
          c(
            "x" = "Access to {.path /conf/hscdiip} is required to use the
            Source Linkage Files, it looks like you don't have the correct
            permissions.",
            ">" = "email {.email phs.source@phs.scot} and request access to
            {.value UNIX hscdiip}."
          ),
          call = rlang::caller_env()
        )
      }
    }
  }
}
