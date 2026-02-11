# Read a Source Linkage File

Read a Source Linkage File

## Usage

``` r
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
```

## Arguments

- year:

  Year of the file to be read, you can specify multiple years which will
  then be returned as one file. It will be converted to short FY using
  [`format_year()`](https://public-health-scotland.github.io/slfhelper/reference/format_year.md).

- file_version:

  Version of the file (individual / episode).

- dev:

  **\[experimental\]** Whether to get the file from the development area
  (`/conf/sourcedev/Source_Linkage_File_Updates`). The default (`FALSE`)
  will get the production file from the usual area.

- col_select:

  A character vector of column names to keep, as in the "select"
  argument to `data.table::fread()`, or a [tidy selection
  specification](https://tidyselect.r-lib.org/reference/eval_select.html)
  of columns, as used in
  [`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html).

- columns:

  **\[deprecated\]** `columns` is no longer used, use `col_select`
  instead.

- as_data_frame:

  Should the function return a `tibble` (default) or an Arrow
  [Table](https://arrow.apache.org/docs/r/reference/Table-class.html)?

- partnerships:

  Optional specify a partnership (hscp2018) or partnerships to select.

- recids:

  Optional specify a recid or recids to select.

## Value

The requested SLF data as a
[tibble](https://tibble.tidyverse.org/reference/tibble-package.html) or
an [Arrow
Table](https://arrow.apache.org/docs/r/reference/arrow-package.html).
