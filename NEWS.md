# slfhelper (development version)

# slfhelper 0.10.0

* [`{glue}`](https://glue.tidyverse.org/) is no longer a dependency as the required functionality can be provided by [`stringr::str_glue()](https://stringr.tidyverse.org/reference/str_glue.html).
* Dependency versions have been updated to the latest.
* `get_chi()` and `get_anon_chi()` now properly match missing (`NA`) and blank (`""`) values.
* slfhelper now defaults to using the `.parquet` file versions, old versions of slfhelper will no longer work.
* There is now a `dev` parameter available when using the `read_slf_*` functions which allows reading the file from the development environment.

# slfhelper 0.9.0

* [`{openssl}`](https://cran.r-project.org/web/packages/openssl/index.html) is now required.
* `get_chi()` and `get_anon_chi()` are now much faster (>100X) and use significantly less memory.
* The `year` parameter is now checked early in the process, and if an invalid year is supplied the error message should be much more informative.

# slfhelper 0.8.2

* `ep_file_vars` and `indiv_file_vars` updated with correct variables. 

# slfhelper 0.8.1

* Use `{cli}` for nicer error messages and warning.

# slfhelper 0.8.0

* Add a number of 'variable packs' for easily selecting sets of variables: `demog_vars`, `ltc_vars`,  `ep_file_bedday_vars` and `ep_file_cost_vars`.
* Add [a new vignette](https://public-health-scotland.github.io/slfhelper/articles/variable-packs.html) introducing variable packs.

# slfhelper 0.7.1

* Add check for server and hscdiip access on package load.
* Add a recid lookup for use with the `recid` filtering parameter.
* When using `get_anon_chi()` it will now use `phsmethods::chi_check` (if available) and warn if a lot of CHI numbers return as invalid.
* Update variable lists for new Home Care related variables.

# slfhelper 0.7.0

* Now depends on R >= 3.5
* `ep_file_vars` and `indiv_file_vars` updated with the latest variable names. These now also return a character vector instead of a list.
* `read_slf_` now returns a [tibble](https://tibble.tidyverse.org/). 

# slfhelper 0.6.0

* Fix bug with selecting partnerships/recids when also selecting multiple years (#13) (#14)

# slfhelper 0.5.3

* Added a `NEWS.md` file to track changes to the package.
* Moved to use Rmd version for the readme.
* Bump dplyr version requirement to 1.0.0 to enable use of `across()` and other new things.
* Add checks to the year
