# Generate a Source Linkage File, file path

Generate a Source Linkage File, file path

## Usage

``` r
gen_file_path(year, file_version, call, dev = FALSE, ext = "parquet")
```

## Arguments

- year:

  Year of the file to be read, you can specify multiple years which will
  then be returned as one file. It will be converted to short FY using
  [`format_year()`](https://public-health-scotland.github.io/slfhelper/reference/format_year.md).

- file_version:

  Version of the file (individual / episode).

- call:

  Supply environment from the top-level function to make any error
  messages more useful.

- dev:

  Whether to get the file from the development area
  (`/conf/sourcedev/Source_Linkage_File_Updates`). The default (`FALSE`)
  will get the production file from the usual area.

- ext:

  **\[questioning\]** The file extension to read.

## Value

a [fs_path](https://fs.r-lib.org/reference/fs-package.html) object.
