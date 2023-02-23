test_that("check_names accepts some valid names", {
  out <- expect_invisible(check_variable_names("year", ep_file_vars))
  expect_null(out)

  out <- expect_invisible(check_variable_names(c("year", "recid", "anon_chi"), ep_file_vars))
  expect_null(out)
})

test_that("Suggests corrections properly", {
  # Single bad var
  expect_invisible(check_variable_names("years", ep_file_vars)) %>%
    expect_error("Try: 'columns = c\\(\"year\"\\)'")

  expect_invisible(check_variable_names(c("years", "anon_chi"), ep_file_vars)) %>%
    expect_error("Try: 'columns = c\\(\"year\", \"anon_chi\"\\)'")


  # Multiple bad var
  expect_invisible(check_variable_names(c("years", "anon_chis"), ep_file_vars)) %>%
    expect_error("Try: 'columns = c\\(\"year\", \"anon_chi\"\\)'")

  expect_invisible(check_variable_names(c("years", "anon_chis", "recid"), ep_file_vars)) %>%
    expect_error("Try: 'columns = c\\(\"year\", \"anon_chi\", \"recid\"\\)'")
})

test_that("Errors properly if no match found", {
  expect_invisible(check_variable_names(c("year", "anon_chi", "unknown_var"), ep_file_vars)) %>%
    expect_error("'unknown_var' is not a correct variable name.")

  expect_invisible(check_variable_names(c("year", "anon_chis", "unknown_var"), ep_file_vars)) %>%
    expect_error("'anon_chis' is not a correct variable name.\\n\\* 'unknown_var' is not a correct variable name.")
})
