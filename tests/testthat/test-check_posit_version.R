test_that("check_posit_version() works without rstudio-server on the PATH", {
  testthat::local_mocked_bindings(isAvailable = function(...) FALSE, .package = "rstudioapi")
  testthat::local_mocked_bindings(rstudio_server_version = function() NA_character_)
  expect_message(version <- check_posit_version(), "Couldn't find") # nolint
  expect_identical(version, NA_character_)
})

test_that("rstudio_server_version() looks beyond the PATH", {
  expect_message(version <- rstudio_server_version(paths = ""), "rstudio-server") # nolint
  expect_identical(version, NA_character_)

  fake = withr::local_tempfile()
  writeLines(c("#!/bin/sh", "echo '2026.09.1+401.pro2 Workbench (Pumpkin Spice)'"), fake)
  Sys.chmod(fake, "755")
  expect_identical(rstudio_server_version(paths = c("", fake)), "2026.09.1+401.pro2")
})
