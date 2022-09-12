test_that("Test R packages are pre-installed", {
  testthat::skip_on_ci()

  pkgs = "quarto"
  lapply(pkgs, function(pkg) testthat::expect_true(requireNamespace(pkg)))
})

test_that("Installing a CRAN package", {
  testthat::skip_on_ci()
  lapply(options("repos")$repos, message)
  pkg_name = "drat"
  expect_true(install_packages(pkg_name, quiet = TRUE))
})

test_that("Installing a Github package", {
  testthat::skip_on_ci()
  # Should use a smaller package here
  # Don't need to clean up; it's a dummy account
  installed_pkg = remotes::install_github("jumpingrivers/datasauRus",
                                          quiet = TRUE, force = TRUE)
  expect_equal(installed_pkg, "datasauRus")
})

test_that("Bioconductor installation works", {
  testthat::skip_on_ci()
  is_bioc = requireNamespace("BiocManager", quietly = TRUE)
  if (!is_bioc) {
    # Don't need to remove this; not what we are testing
    expect_true(install_packages("BiocManager", quiet = TRUE))
  }

  # Can we access the bioconductor repos
  # Repo 5 is bioconductor, but doesn't work!
  # Installing a bioconductor pkg is slowwww
  repos = BiocManager::repositories()[1:4]
  lapply(repos, function(repo) {
    message("Testing ", repo)
    expect_false(httr::http_error(repo))
  })

})
