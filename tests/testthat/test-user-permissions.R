test_that("Creating files in the home area", {
  testthat::expect_true(create_file(dir = "~"))
})

test_that("Permissions to edit ~/.Rprofile", {
  permissions_on_rprofile_int = get_file_permissions(dir = "~")
  # If the permissions of the file (in octal format) are greater than or equal to 600,
  # then we have permissions to edit:
  testthat::expect_true(permissions_on_rprofile_int >= 600)
})
