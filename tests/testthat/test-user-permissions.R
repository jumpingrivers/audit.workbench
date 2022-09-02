test_that("Check if we have permissions to edit ~/.Rprofile", {
  # We use normalisePath for tilde-expansion, since processx doesn't do this:
  rprofile_location = normalizePath("~/.Rprofile")
  # We check that running touch on the file will not result in an error:
  testthat::expect_equal(processx::run("touch", args = c(rprofile_location))$status, 0)
  # The command to check, in octal form, what are the permissions of the file:
  check_permission = processx::run("stat", args = c("-c", "'%a", rprofile_location))
  # Obtain the stdout of the command:
  stdout_of_check_permission = check_permission$stdout
  # Remove any whitespace, newlines or quotes from the stdout string:
  permissions_on_profile = gsub(pattern = "\\s|'", "", stdout_of_check_permission)
  # Convert the string to an integer, so that we can use it to make comparisons
  permissions_on_rprofile_int = strtoi(permissions_on_profile)
  # Assert that the conversion from string to integer has happened:
  testthat::expect_true(typeof(permissions_on_rprofile_int) == "integer")
  # If the permissions of the file (in octal format) are greater than or equal to 600,
  # then we have permissions to edit:
  testthat::expect_true(permissions_on_rprofile_int >= 600)
})
