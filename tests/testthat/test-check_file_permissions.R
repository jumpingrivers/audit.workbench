test_that("testing_file_permissions() fails when new files are world-writable", {
  old = Sys.umask("022")
  withr::defer(Sys.umask(old))
  expect_true(testing_file_permissions())
  Sys.umask("000")
  expect_error(testing_file_permissions(), "written by other users")
  Sys.umask("200")
  expect_error(testing_file_permissions(), "read and written by their owner")
})
