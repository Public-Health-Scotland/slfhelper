check_variable_names <- function(columns, var_list, cnd = NULL) {
  bad_names <- columns[!(columns %in% var_list)]

  if (length(bad_names) == 0) {
    return(invisible())
  }

  suggested_names <- columns

  real_names <- character()

  for (name in bad_names) {
    string_dist <- utils::adist(name, var_list)

    if (min(string_dist) < 3) {
      real_name <- var_list[which.min(string_dist)]
      real_names <- c(real_names, real_name)

      suggested_names[which(columns == name)] <- real_name
    }
  }

  if (length(bad_names) == length(real_names)) {
    rlang::abort(
      message = c("One or more variables were not found.",
        glue::glue("Instead of '{bad_names}', did you mean '{real_names}'?\n"),
        "i" = glue::glue("Try: 'columns = c(\"{stringr::str_flatten(suggested_names, collapse = '\", \"')}\")'")
      ),
      parent = cnd
    )
  } else {
    rlang::abort(
      message = c(
        "Variables not found.",
        glue::glue("'{bad_names}' is not a correct variable name.", sep = "\\n")
      ),
      parent = cnd
    )
  }
}
