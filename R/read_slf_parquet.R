#' Read a Source Linkage File (parquet)
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' @inherit read_slf
#' @inheritParams gen_file_path
#' @inheritParams arrow::read_parquet
read_slf_parquet <- function(
    year,
    col_select = NULL,
    as_data_frame = TRUE,
    file_version = c("episode", "individual"),
    partnerships = NULL,
    recids = NULL,
    dev = TRUE) {
  file_path <- gen_file_path(
    year,
    file_version,
    call = rlang::caller_env(),
    dev = dev,
    ext = "parquet"
  )

  stopifnot(fs::file_access(file_path, "read"))

  # If we're looking at the dev version of the file swap anon_chi for chi
  if (dev && !is.null(col_select) && "anon_chi" %in% col_select) {
    col_select[which(col_select == "anon_chi")] <- "chi"
  }

  # If the we are trying to filter by partnership or recid
  # but the column wasn't selected we need to add it (and remove later)
  remove_partnership_var <- FALSE
  remove_recid_var <- FALSE
  if (!is.null(col_select)) {
    if (!is.null(partnerships) &
      !("hscp2018" %in% col_select)) {
      col_select <- c(col_select, "hscp2018")
      remove_partnership_var <- TRUE
    }
    if (!is.null(recids) & file_version == "episode" &
      !("recid" %in% col_select)) {
      col_select <- c(col_select, "recid")
      remove_recid_var <- TRUE
    }
  }

  slf_table <- purrr::map(
    file_path,
    function(file_path) {
      slf_table <- arrow::read_parquet(
        file = file_path,
        col_select = arrow::all_of(col_select),
        as_data_frame = FALSE
      )

      if (!is.null(recids)) {
        slf_table <- dplyr::filter(
          slf_table,
          .data$recid %in% recids
        )
      }
      if (!is.null(partnerships)) {
        slf_table <- dplyr::filter(
          slf_table,
          .data$partnership %in% partnerships
        )
      }
      if (remove_partnership_var) {
        slf_table <- dplyr::select(slf_table, -"hscp2018")
      }
      if (remove_recid_var) {
        slf_table <- dplyr::select(slf_table, -"recid")
      }

      return(slf_table)
    }
  )

  # Collapse the list to a single Arrow Table object
  if (length(slf_table) == 1) {
    slf_table <- slf_table[[1]]
  } else {
    slf_table <- purrr::reduce(slf_table, dplyr::union_all)
  }

  if (as_data_frame) {
    return(dplyr::collect(slf_table))
  } else {
    return(slf_table)
  }
}

#' Read a Source Linkage episode file (parquet)
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' @inherit read_slf_episode
#' @inheritParams read_slf_parquet
#' @export
read_slf_episode_parquet <- function(
    year,
    col_select = NULL,
    partnerships = NULL,
    recids = NULL,
    as_data_frame = TRUE,
    dev = TRUE,
    columns = lifecycle::deprecated()) {
  if (lifecycle::is_present(columns)) {
    lifecycle::deprecate_soft(
      "0.10.0",
      "read_slf_episode(columns)",
      "read_slf_episode(col_select)"
    )
    col_select <- columns
  }
  # TODO add option to drop blank CHIs?
  # TODO add a filter by recid option
  return(
    read_slf_parquet(
      year = year,
      col_select = unique(col_select),
      file_version = "episode",
      partnerships = unique(partnerships),
      recids = unique(recids)
    )
  )
}

#' Read a Source Linkage individual file (parquet)
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' @inherit read_slf_individual
#' @inheritParams read_slf_parquet
#' @export
read_slf_individual_parquet <-
  function(year,
           col_select = NULL,
           partnerships = NULL,
           recids = NULL,
           as_data_frame = TRUE,
           dev = TRUE,
           columns = lifecycle::deprecated()) {
    if (lifecycle::is_present(columns)) {
      lifecycle::deprecate_soft(
        "0.10.0",
        "read_slf_individual(columns)",
        "read_slf_individual(col_select)"
      )
      col_select <- columns
    }
    return(
      read_slf_parquet(
        year = year,
        file_version = "individual",
        partnerships = unique(partnerships),
        col_select = unique(col_select),
        dev = TRUE
      )
    )
  }
