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
