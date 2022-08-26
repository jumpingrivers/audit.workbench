
# Testing if Python via Terminal works
testthat::test_that("Python calculation via Terminal works", {
  testthat::expect_equal(system('python3 -c "print(2+2)"', intern = TRUE), "4")
})

# Testing if Python via Reticulate works
testthat::test_that("Python via Reticulate", {
  testthat::expect_true(require(reticulate, quietly = TRUE))
  reticulate::py_run_string("x=2+2")
  testthat::expect_equal(reticulate::py$x, 4)
})

# Is pip installed?
testthat::test_that("Pip is installed", {
  testthat::expect_true(as.integer(stringr::str_extract(
    processx::run("pip", "--version")$stdout, "[0-9]{2}"
  )) >= 20)
})

# Installing a Python package
testthat::test_that("Pip installation of pkg works", {
  numpy = processx::run("pip", args = c("install", "numpy", "--force-reinstall"))
  testthat::expect_true(stringr::str_detect(numpy$stdout, "Successfully installed"))
})
