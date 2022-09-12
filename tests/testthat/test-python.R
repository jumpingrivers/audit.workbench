testthat::test_that("Python calculation via Terminal works", {
  testthat::expect_equal(system('python3 -c "print(2+2)"', intern = TRUE), "4")
})

testthat::test_that("Python via Reticulate", {

  if (!("reticulate" %in% rownames(installed.packages()))) {
    install.packages("reticulate", repo = get_repo_url())
    withr::defer(remove.packages("reticulate"))
  }

  reticulate::py_run_string("x=2+2")
  testthat::expect_equal(reticulate::py$x, 4)
})

testthat::test_that("Pip is installed", {
  pip_version = processx::run("pip", "--version")$stdout
  # Min pip version > 20
  min_version = grepl("pip [2-3][0-9]", pip_version)
  testthat::expect_true(min_version)
})

# Installing a Python package
testthat::test_that("Pip installation of pkg works", {
  testthat::expect_true(pip_install())
})
