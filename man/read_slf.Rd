% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_slf.R
\name{read_slf}
\alias{read_slf}
\title{Read a Source Linkage File}
\usage{
read_slf(
  year,
  file_version = c("episode", "individual"),
  dev = FALSE,
  col_select = NULL,
  columns = lifecycle::deprecated(),
  as_data_frame = TRUE,
  partnerships = NULL,
  recids = NULL
)
}
\arguments{
\item{year}{Year of the file to be read, you can specify multiple years
which will then be returned as one file. It will be converted to short FY
using \code{\link[=format_year]{format_year()}}.}

\item{file_version}{Version of the file (individual / episode).}

\item{dev}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}} Whether to get the file from
the development area (\verb{/conf/sourcedev/Source_Linkage_File_Updates}). The
default (\code{FALSE}) will get the production file from the usual area.}

\item{col_select}{A character vector of column names to keep, as in the
"select" argument to \code{data.table::fread()}, or a
\link[tidyselect:eval_select]{tidy selection specification}
of columns, as used in \code{dplyr::select()}.}

\item{columns}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}} \code{columns} is no
longer used, use \code{col_select} instead.}

\item{as_data_frame}{Should the function return a \code{tibble} (default) or
an Arrow \link[arrow]{Table}?}

\item{partnerships}{Optional specify a partnership (hscp2018) or
partnerships to select.}

\item{recids}{Optional specify a recid or recids to select.}
}
\value{
The requested SLF data as a \link[tibble:tibble-package]{tibble} or an
\link[arrow:arrow-package]{Arrow Table}.
}
\description{
Read a Source Linkage File
}
