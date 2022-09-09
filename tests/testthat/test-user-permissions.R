test_that("Permissions to touch ~/.Rprofile", {
  testthat::expect_true(touch_file_succeeds("~/.Rprofile"))
})

test_that("Permissions to edit ~/.Rprofile", {
  permissions_on_rprofile_int = get_permissions_of_file("~/.Rprofile")
  # Assert that the conversion from string to integer has happened:
  testthat::expect_true(typeof(permissions_on_rprofile_int) == "integer")
  # If the permissions of the file (in octal format) are greater than or equal to 600,
  # then we have permissions to edit:
  testthat::expect_true(permissions_on_rprofile_int >= 600)
})

test_that("Permissions to touch ~/.Renviron", {
  testthat::expect_true(touch_file_succeeds("~/.Renviron"))
})

test_that("Permissions to edit ~/.Renviron", {
  permissions_on_renviron_int = get_permissions_of_file("~/.Renviron")
  # Assert that the conversion from string to integer has happened:
  testthat::expect_true(typeof(permissions_on_renviron_int) == "integer")
  # If the permissions of the file (in octal format) are greater than or equal to 600,
  # then we have permissions to edit:
  testthat::expect_true(permissions_on_renviron_int >= 600)
})
