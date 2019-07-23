#' Read a Source Linkage File
#'
#' @param year Year of the file to be readl you can specify multiple years which will then be returned as one file
#' @param file_version Version of the file (Individual / episode)
#' @param partnership Optional specify Partnership to select (not yet implemented)
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#'
#' @examples
#' read_slf("1718", "episode")
read_slf <-
  function(year, file_version, partnership = NA_character_, ...) {

    # Define a function for filtering to a partnership
    filter_partnership <- function(data, partnership) {
      data <- data %>% filter(hscp2018 == partnership)

      return(data)
    }

    # Clean up year
    # We want it in the format 1718
    # This will handle numbers or strings of the form 201718 or 1718
    year <- format_year(year)

    file_path <-
      paste0(
        "/conf/hscdiip/01-Source-linkage-files/source-",
        file_version,
        "-file-20",
        year,
        ".fst"
      )

    # Count how many files we are going to read
    num_files <- length(file_path)

    # Check if there is more than one year
    if (num_files > 1) {

      # Gather up any optional parameters which were supplied
      optional_params <- list(...)

      # Create a list of parameters, starting with the filepaths
      param_list <- list(as.list(file_path))

      # Add all the optional parameters together correctly
      for (i in names(optional_params)) {
        param_list <-
          append(
            param_list,
            list(as.list(
              rep(list(optional_params[[i]]), num_files)
            ))
          )
      }

      # We now have a list which contains a list for each parameter supplied
      # Give the inner lists names
      names(param_list) <- c("path", names(optional_params))

      # Pass the list of parameters to fst::read_fst through purrr
      slfs_list <- purrr::pmap(param_list, fst::read_fst)

      # If a partnership is specified filter now
      if (!(is.na(partnership))) {
        partnership <- as.list(rep(
          partnership,
          num_files
        ))

        slfs_list <- purrr::map2(
          slfs_list,
          partnership,
          filter_partnership
        )
      }

      # Bind the files which have been read together
      slf <- dplyr::bind_rows(slfs_list)
    } else {
      # Simple case for one year
      slf <- fst::read_fst(file_path, ...)

      # If a partnership is specified filter now
      if (!(is.na(partnership))) {
        slf <- slf %>% filter_partnership(partnership)
      }
    }

    return(slf)
  }

#' Read a Source Linkage episode file
#'
#' @param year Year of the file to be readl you can specify multiple years
#' which will then be returned as one file
#' @param columns Optional a vector of column names
#' @param partnership Optional specify Partnership to select
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_episode("1718")
#' read_slf_episode("1718",
#'   columns = c("anon_chi", "dob", "demographic_cohort"),
#'   from = 100000, to = 200000
#' )
#'
#' read_slf_episode(c("1516", "1617", "1718", "1819"),
#'   columns = c("anon_chi", "dob", "demographic_cohort")
#' )
read_slf_episode <-
  function(year,
             columns = NULL,
             partnership = NA_character_,
             ...) {
    # TODO add option to drop blank CHIs?
    # TODO add a filter by recid option
    return(
      read_slf(
        year = year,
        file_version = "episode",
        partnership = partnership,
        columns = columns,
        ...
      )
    )
  }


#' Read a Source Linkage individual file
#'
#' @param year Year of the file to be readl you can specify multiple years
#'   which will then be returned as one file
#' @param columns Optional a vector of column names
#' @param partnership Optional specify Partnership to select
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_individual("1718")
#' read_slf_individual("1718",
#'   columns = c("anon_chi", "dob", "hri_scot"),
#'   from = 100000, to = 200000
#' )
#' read_slf_individual(c("1516", "1617", "1718", "1819"),
#'   columns = c("anon_chi", "dob", "hri_scot")
#' )
read_slf_individual <-
  function(year,
             columns = NULL,
             partnership = NA_character_,
             ...) {
    return(
      read_slf(
        year = year,
        file_version = "individual",
        partnership = partnership,
        columns = columns,
        ...
      )
    )
  }
