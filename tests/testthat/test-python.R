testthat::test_that("Python calculation via Terminal works", {
  testthat::expect_equal(system('python3 -c "print(2+2)"', intern = TRUE), "4")
})

testthat::test_that("Python via Reticulate", {
  repo_url = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"
  pkgs = rownames(installed.packages())

  if (!("reticulate" %in% pkgs)) {
    install.packages("reticulate", repo = repo_url)
    withr::defer(remove.packages("reticulate"))
  }

  reticulate::py_run_string("x=2+2")
  testthat::expect_equal(reticulate::py$x, 4)
})

testthat::test_that("Pip is installed", {
  pip_version =
    processx::run("pip", "--version")$stdout |>
    stringr::str_extract("[0-9]{2}") %>%
    as.integer()

  testthat::expect_true(pip_version >= 20)
})

pip_install = function() {
  numpy = processx::run("pip", args = c("install", "numpy", "--force-reinstall"))
  withr::defer(processx::run("pip", args = c("uninstall", "numpy", "--yes")))
  return(stringr::str_detect(numpy$stdout, "Successfully installed"))
}

# Installing a Python package
testthat::test_that("Pip installation of pkg works", {
  testthat::expect_true(pip_install())
})
