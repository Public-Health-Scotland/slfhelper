# Check the year(s) supplied are valid

Check the year(s) supplied are valid

## Usage

``` r
check_year(year, call = rlang::caller_env())
```

## Arguments

- year:

  Year of the file to be read, you can specify multiple years which will
  then be returned as one file. It will be converted to short FY using
  [`format_year()`](https://public-health-scotland.github.io/slfhelper/reference/format_year.md).

- call:

  Supply environment from the top-level function to make any error
  messages more useful.

## Value

`TRUE` if the year is valid and a newer year, `FALSE` for any older but
still valid years. Otherwise throws an error.
