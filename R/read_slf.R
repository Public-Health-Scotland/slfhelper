#' Read a Source Linkage File
#'
#' @param year Year of the file to be read, you can specify multiple years
#'  which will then be returned as one file. It will be converted to short FY
#'  using [format_year()].
#' @param file_version Version of the file (individual / episode).
#' @param partnerships Optional specify a partnership (hscp2018) or
#' partnerships to select.
#' @param recids Optional specify a recid or recids to select.
#' @param dev `r lifecycle::badge("experimental")` Whether to get the file from
#' the development area (`/conf/sourcedev/Source_Linkage_File_Updates`). The
#' default (`FALSE`) will get the production file from the usual area.
#'
#' @inheritParams arrow::read_parquet
#'
#' @param columns `r lifecycle::badge("deprecated")` `columns` is no
#'   longer used, use `col_select` instead.
#'
#' @return The requested SLF data as a [tibble][tibble::tibble-package] or an
#' [Arrow Table][arrow::arrow-package].
#' @importFrom rlang .data
read_slf <- function(
    year,
    file_version = c("episode", "individual"),
    dev = FALSE,
    col_select = NULL,
    columns = lifecycle::deprecated(),
    as_data_frame = TRUE,
    partnerships = NULL,
    recids = NULL) {
  file_path <- gen_file_path(
    year,
    file_version,
    call = rlang::caller_env(),
    dev = dev,
    ext = "parquet"
  )

  files_exist <- fs::file_access(file_path, "read")

  if (!all(files_exist)) {
    cli::cli_abort(
      c(
        "x" = "{?The/Some of the} {cli::qty(length(year))} file{?s} you
        requested don't exist or you don't have permission to read {?it/them}.",
        ">" = "Please check: {.file {names(files_exist[!files_exist])}}"
      ),
      call = rlang::caller_env()
    )
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
        col_select = !!col_select,
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
          .data$hscp2018 %in% partnerships
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

#' Read a Source Linkage episode file
#'
#' @inherit read_slf
#' @export
#'
#' @examples
#' \dontrun{
#' read_slf_episode("1718",
#'   col_select = c("anon_chi", "dob", "demographic_cohort")
#' )
#'
#' read_slf_episode(c("1718", "1819"),
#'   col_select = c("anon_chi", "dob", "demographic_cohort"),
#'   as_data_frame = FALSE
#' )
#' }
read_slf_episode <- function(
    year,
    col_select = NULL,
    partnerships = NULL,
    recids = NULL,
    as_data_frame = TRUE,
    dev = FALSE,
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

  data <- read_slf(
    year = year,
    col_select = unique(col_select),
    file_version = "episode",
    partnerships = unique(partnerships),
    recids = unique(recids),
    as_data_frame = as_data_frame,
    dev = dev
  )

  if ("keytime1" %in% colnames(data)) {
    data <- data %>%
      dplyr::mutate(keytime1 = hms::as_hms(.data$keytime1))
  }
  if ("keytime2" %in% colnames(data)) {
    data <- data %>%
      dplyr::mutate(keytime2 = hms::as_hms(.data$keytime2))
  }

  return(data)
}

#' Read a Source Linkage individual file
#'
#' @inherit read_slf
#'
#' @export
#'
#' @examples
#' \dontrun{
#' read_slf_individual("1718",
#'   col_select = c("anon_chi", "dob", "hri_scot")
#' )
#' read_slf_individual(c("1718", "1819"),
#'   col_select = c("anon_chi", "dob", "hri_scot"),
#'   as_data_frame = FALSE
#' )
#' }
read_slf_individual <- function(
    year,
    col_select = NULL,
    partnerships = NULL,
    as_data_frame = TRUE,
    dev = FALSE,
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
    read_slf(
      year = year,
      col_select = unique(col_select),
      file_version = "individual",
      partnerships = unique(partnerships),
      as_data_frame = as_data_frame,
      dev = dev
    )
  )
}
