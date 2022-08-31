repo_url = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"

test_that("Check if R calculation works", {
  expect_equal(2 + 2, 4)
})


test_that("Installing an R package", {
  install.packages("drat", repo = repo_url)
  withr::defer(remove.packages("drat"))
  expect_true(require(graph))x

    package_has_loaded = withr::with_package(package = r_package_to_install, {
      expect_true(r_package_to_install %in% installed.packages()[, "Package"])
    },
    logical.return = TRUE
  )
  expect_true(package_has_loaded)
  expect_true(require(r_package_to_install, character.only = TRUE))
  expect_true(r_package_to_install %in% installed.packages()[, "Package"])
})

# Installing a Bioconductor package
test_that("Bioconductor installation works", {
  if (require(BiocManager)) {
    BiocManager::install("graph", force = TRUE)
  } else {
    install.packages("BiocManager", repo = repo_url)
    BiocManager::install("graph", force = TRUE)
  }
  expect_true(require(graph))
})

# Installing an R package from GitHub
test_that("GitHub R package installation works", {
  devtools::install_github("jumpingrivers/datasauRus")
  expect_true(require(datasauRus))
})
