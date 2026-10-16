fake_rstudio_server = function(status) {
  path = withr::local_tempfile(.local_envir = parent.frame())
  writeLines(c("#!/bin/sh", "echo \"called with $*\"", paste("exit", status)), path)
  Sys.chmod(path, "755")
  path
}

test_that("testing_test_config() runs rstudio-server test-config", {
  skip_on_os("windows")
  expect_true(testing_test_config(fake_rstudio_server(0L)))
})

test_that("testing_test_config() fails with the command's output", {
  skip_on_os("windows")
  expect_error(testing_test_config(fake_rstudio_server(1L)), "called with test-config")
})

test_that("testing_test_config() fails when rstudio-server is missing", {
  expect_error(testing_test_config(""), "Can't find")
})
