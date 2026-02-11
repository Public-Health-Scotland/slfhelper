# Read a Source Linkage individual file

Read a Source Linkage individual file

## Usage

``` r
read_slf_individual(
  year,
  col_select = NULL,
  partnerships = NULL,
  as_data_frame = TRUE,
  dev = FALSE,
  columns = lifecycle::deprecated()
)
```

## Arguments

- year:

  Year of the file to be read, you can specify multiple years which will
  then be returned as one file. It will be converted to short FY using
  [`format_year()`](https://public-health-scotland.github.io/slfhelper/reference/format_year.md).

- col_select:

  A character vector of column names to keep, as in the "select"
  argument to `data.table::fread()`, or a [tidy selection
  specification](https://tidyselect.r-lib.org/reference/eval_select.html)
  of columns, as used in
  [`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html).

- partnerships:

  Optional specify a partnership (hscp2018) or partnerships to select.

- as_data_frame:

  Should the function return a `tibble` (default) or an Arrow
  [Table](https://arrow.apache.org/docs/r/reference/Table-class.html)?

- dev:

  **\[experimental\]** Whether to get the file from the development area
  (`/conf/sourcedev/Source_Linkage_File_Updates`). The default (`FALSE`)
  will get the production file from the usual area.

- columns:

  **\[deprecated\]** `columns` is no longer used, use `col_select`
  instead.

## Value

The requested SLF data as a
[tibble](https://tibble.tidyverse.org/reference/tibble-package.html) or
an [Arrow
Table](https://arrow.apache.org/docs/r/reference/arrow-package.html).

## Examples

``` r
if (FALSE) { # \dontrun{
read_slf_individual("1718",
  col_select = c("anon_chi", "dob", "hri_scot")
)
read_slf_individual(c("1718", "1819"),
  col_select = c("anon_chi", "dob", "hri_scot"),
  as_data_frame = FALSE
)
} # }
```
