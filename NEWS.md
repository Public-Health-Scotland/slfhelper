# slfhelper (development version)

* Add check for server and hscdiip access on package load.
* Update variable lists.
* Add a recid lookup for use with the `recid` filtering parameter.
* Now depends on R >= 3.5
* When using `get_anon_chi()` it will now use `phsmethods::chi_check` (if avaliable) and warn if a lot of CHIs look invalid.

# slfhelper 0.6.0

* Fix bug with selecting partnerships/recids when also selecting multiple years (#13) (#14)

# slfhelper 0.5.3

* Added a `NEWS.md` file to track changes to the package.
* Moved to use Rmd version for the readme.
* Bump dplyr version requirement to 1.0.0 to enable use of `across()` and other new things.
* Add checks to the year
