## code to prepare `chi_cohort` dataset goes here
# Generate a sample which should contain at least some valid CHIs
set.seed(1)
n <- 100
# Make one column upi_number and one chi
chi_cohort <- dplyr::tibble(
  upi_number = paste0(
    round(runif(n, min = 0, max = 3)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 1)),
    round(runif(n, min = 0, max = 2)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9))
  ), chi = paste0(
    round(runif(n, min = 0, max = 3)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 1)),
    round(runif(n, min = 0, max = 2)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9)),
    round(runif(n, min = 0, max = 9))
  )
)

usethis::use_data(chi_cohort, compress = "gzip")
