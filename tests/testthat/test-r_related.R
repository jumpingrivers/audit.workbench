repo_url = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"
r_package_to_install = "drat"

# Testing if R Console calculation
testthat::test_that("Check if R calculation works", {
  testthat::expect_equal(2 + 2, 4)
})

#Installing an R package
testthat::test_that(paste(
  "Installing R package: {",
  r_package_to_install,
  "}",
  sep = ""
),
{
  install.packages(r_package_to_install,
                   repo = repo_url,
                   quietly = TRUE)
    package_has_loaded = withr::with_package(package = r_package_to_install, {
      testthat::expect_true(r_package_to_install %in% installed.packages()[, "Package"])
    },
    logical.return = TRUE
  )
  testthat::expect_true(package_has_loaded)
  testthat::expect_true(require(r_package_to_install, character.only = TRUE))
  testthat::expect_true(r_package_to_install %in% installed.packages()[, "Package"])
})

# Installing a Bioconductor package
testthat::test_that("Bioconductor installation works", {
  if (require(BiocManager)) {
    BiocManager::install("graph", force = TRUE)
  } else {
    install.packages("BiocManager", repo = repo_url)
    BiocManager::install("graph", force = TRUE)
  }
  testthat::expect_true(require(graph))
})

# Installing an R package from GitHub
testthat::test_that("GitHub R package installation works", {
  devtools::install_github("jumpingrivers/datasauRus")
  testthat::expect_true(require(datasauRus))
})
