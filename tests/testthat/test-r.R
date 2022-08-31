test_that("Check if R calculation works", {
  expect_equal(2 + 2, 4)
})


test_that("Installing an R package", {
  install.packages("lubridate", repo = get_repo_url())
  withr::defer(remove.packages("lubridate"))
  expect_true(require("lubridate"))
})

bioconductor_install = function() {
  if (!("BiocManager" %in% rownames(installed.packages()))) {
    install.packages("BiocManager", repo = get_repo_url())
    withr::defer(remove.packages("BiocManager"))
  }
  BiocManager::install("graph", force = TRUE)
  withr::defer(remove.packages("graph"))
  return(require(graph))
}

github_install = function() {
  if (!("devtools" %in% rownames(installed.packages()))) {
    install.packages("devtools", repo = get_repo_url())
    withr::defer(remove.packages("devtools"))
  }
  devtools::install_github("jumpingrivers/datasauRus")
  withr::defer(remove.packages("datasauRus"))
  return(require(datasauRus))
}

test_that("Bioconductor installation works", {
  expect_true(bioconductor_install())
})

test_that("GitHub R package installation works", {
    expect_true(github_install())
})
