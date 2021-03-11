#' Read a Source Linkage File
#'
#' @param year Year of the file to be read, you can specify multiple years
#'  which will then be returned as one file
#' @param file_version Version of the file (individual / episode)
#' @param partnerships Optional specify a partnership (hscp2018) or
#' partnerships to select
#' @param recids Optional specify a recid or recids to select
#' @param ... other options to be passed to read_fst()
#'
#' @return a tibble
#' @importFrom rlang .data
read_slf <-
  function(year, file_version, partnerships = NULL, recids = NULL, ...) {

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

    # The following code is designed to deal with multiple years
    # but works fine with a single year too

    # Gather up any optional parameters which were supplied
    optional_params <- list(...)

    # If the we are trying to filter by partnership or recid
    # but the column wasn't selected we need to add it (and remove later)
    remove_partnership_var <- FALSE
    remove_recid_var <- FALSE
    if (!(is.null(optional_params$columns))) {
      if (!(is.null(partnerships)) &
        !("hscp2018" %in% optional_params$columns)) {
        optional_params$columns <- c(optional_params$columns, "hscp2018")
        remove_partnership_var <- TRUE
      }
      if (!(is.null(recids)) & file_version == "episode" &
        !("recid" %in% optional_params$columns)) {
        optional_params$columns <- c(optional_params$columns, "recid")
        remove_recid_var <- TRUE
      }
    }

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

    # Define a function for filtering to a list of partnerships
    filter_partnership <- function(tibb, partnerships) {
      tibb <- tibb %>% dplyr::filter(.data$hscp2018 %in% partnerships)

      return(tibb)
    }

    # Define a function for filtering to a list of recids
    filter_recid <- function(tibb, recids) {
      tibb <- tibb %>% dplyr::filter(.data$recid %in% recids)

      return(tibb)
    }

    # If a partnership is specified filter first;
    # With testing it seems to usually be faster if we do partnership
    # filtering before recid filtering
    if (!(is.null(partnerships))) {
      partnerships <- as.list(rep(
        partnerships,
        num_files
      ))

      slfs_list <- purrr::map2(
        slfs_list,
        partnerships,
        filter_partnership
      )
    }

    # If a recid is specified filter now
    if (!(is.null(recids))) {
      recids <- as.list(rep(
        recids,
        num_files
      ))

      slfs_list <- purrr::map2(
        slfs_list,
        recids,
        filter_recid
      )
    }

    # Bind the files which have been read together
    slf <- dplyr::bind_rows(slfs_list)

    # With testing it is faster to remove any extra columns after binding
    if (remove_partnership_var) {
      slf <- dplyr::select(slf, -.data$hscp2018)
    }
    if (remove_recid_var) {
      slf <- dplyr::select(slf, -.data$recid)
    }

    return(slf)
  }

#' Read a Source Linkage episode file
#'
#' @param year Year of the file to be read you can specify multiple years
#' which will then be returned as one file
#' @param columns Optional a vector of column names
#' @param partnerships Optional specify a partnership (hscp2018) or
#' partnerships to select
#' @param recids Optional specify a recid or recids to select
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_episode("1718",
#'   columns = c("anon_chi", "dob", "demographic_cohort"),
#'   from = 100000,
#'   to = 101000
#' )
#'
#' read_slf_episode(c("1718", "1819"),
#'   columns = c("anon_chi", "dob", "demographic_cohort"),
#'   from = 100000,
#'   to = 101000
#' )
read_slf_episode <-
  function(year, columns = NULL, partnerships = NULL, recids = NULL, ...) {
    # TODO add option to drop blank CHIs?
    # TODO add a filter by recid option
    return(
      read_slf(
        year = year,
        file_version = "episode",
        partnerships = partnerships,
        recids = recids,
        columns = columns,
        ...
      )
    )
  }


#' Read a Source Linkage individual file
#'
#' @param year Year of the file to be read you can specify multiple years
#'   which will then be returned as one file
#' @param columns Optional a vector of column names
#' @param partnerships Optional specify a partnership (hscp2018) or
#' partnerships to select
#' @param ... other options to be passed to read_fst()
#'
#'
#' @return a tibble
#' @export
#'
#' @examples
#' read_slf_individual("1718",
#'   columns = c("anon_chi", "dob", "hri_scot"),
#'   from = 100000, to = 101000
#' )
#' read_slf_individual(c("1718", "1819"),
#'   columns = c("anon_chi", "dob", "hri_scot"),
#'   from = 100000,
#'   to = 101000
#' )
read_slf_individual <-
  function(year, columns = NULL, partnerships = NULL, ...) {
    return(
      read_slf(
        year = year,
        file_version = "individual",
        partnerships = partnerships,
        columns = columns,
        ...
      )
    )
  }
