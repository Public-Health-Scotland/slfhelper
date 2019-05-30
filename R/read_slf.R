


read_slf <- function(year, file_version, ...) {
  # Clean up year

  # We want it in the format 1718
  # This will handle numbers or strings of the form 201718 or 1718
  year <- stringr::str_extract(as.character(year), "\\d{2}\\d{2}$")


  slf <-
    fst::read_fst(
      stringr::str_glue(
        "/conf/hscdiip/01-Source-linkage-files/source-{file_version}-20{year}.fst"
      ),
      ...
    )

  return(slf)
}

read_episode <- function(year) {
  read_slf(year = year, file_version = "episode")
}

read_individual <- function(year) {
  read_slf(year = year, file_version = "individual")
}
