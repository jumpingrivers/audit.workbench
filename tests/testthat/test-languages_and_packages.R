# Important: best not use the 'Run Tests' button in RStudio IDE.
# That button creates a vanilla R session without running startup scripts,
# see https://github.com/rstudio/rstudio/issues/10246#issuecomment-994042496
# It seems the same error occurs when we're testing using an R package.
# Workaround solution: copy-and-paste into R Console.

REPO_URL = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"
R_PACKAGE_TO_TEST_INSTALLATION_OF = "drat"

# Testing if R Console calculation
testthat::test_that("Check if R calculation works", {
  testthat::expect_equal(2 + 2, 4)
})

# Testing if Python via Terminal works
testthat::test_that("Python calculation via Terminal works", {
  testthat::expect_equal(system('python3 -c "print(2+2)"', intern = TRUE), "4")
})

# Testing if Python via Reticulate works
testthat::test_that("Python via Reticulate", {
  testthat::expect_true(require(reticulate, quietly = TRUE))
  reticulate::py_run_string('x=2+2')
  testthat::expect_equal(reticulate::py$x, 4)
})

# Testing if Git pull works
testthat::test_that("Git pull", {
  testthat::skip("Need to fix git pull test")
  testing_git_clone_directory_name = paste('git_clone_', sub(" ", "_", Sys.time()), sep =
                                             '')
  git_terminal_command = paste(
    "git clone",
    "https://github.com/jumpingrivers/diffify.git",
    testing_git_clone_directory_name,
    "&& ls"
  )
  working_directory_contents_after_git_pull = system(git_terminal_command, intern = TRUE)
  testthat::expect_true(
    testing_git_clone_directory_name %in% working_directory_contents_after_git_pull
  )# TODO: delete git_clone_* directories afterwards
})
#system("rm -rf testing_git_clone")

# TODO Git push, which repo to push to?

#Installing an R package
testthat::test_that(
  paste(
    "Installing R package: {",
    R_PACKAGE_TO_TEST_INSTALLATION_OF,
    "}",
    sep = ''
  ),
  {
    install.packages(R_PACKAGE_TO_TEST_INSTALLATION_OF, repo = REPO_URL, quietly = TRUE)
    testthat::expect_true(require(R_PACKAGE_TO_TEST_INSTALLATION_OF, character.only = TRUE))
    testthat::expect_true(R_PACKAGE_TO_TEST_INSTALLATION_OF %in% installed.packages()[, "Package"])
    #TODO https://withr.r-lib.org/ to put state back
  }
)

#TODO: install Python packages numpy and pandas
