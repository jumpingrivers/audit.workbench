# Important: best not use the 'Run Tests' button in RStudio IDE.
# That button creates a vanilla R session without running startup scripts,
# see https://github.com/rstudio/rstudio/issues/10246#issuecomment-994042496
# It seems the same error occurs when we're testing using an R package.
# Workaround solution: copy-and-paste into R Console.

# Install package from CRAN only if not installed, and load the library
 if (!require(testthat))
   install.packages('testthat', repos = 'https://packagemanager.rstudio.com/cran/__linux__/focal/latest')
library(testthat)

# Testing if R Console calculation
test_that("Check if R calculation works", {
  expect_equal(2 + 2, 4)
})

# Testing if Python via Terminal works
test_that("Check if Python calculation via Terminal works", {
  expect_equal(system('python3 -c "print(2+2)"', intern = TRUE), "4")
})

# Testing if Python via Reticulate works
test_that("Check if Python works via Reticulate",
          expect_equal({
            install.packages('reticulate')
            library(reticulate)
            py_run_string('x=2+2')
            py$x
          }, 4))

# Testing if Git pull works
testing_git_clone_directory_name = paste('git_clone_', sub(" ", "_", Sys.time()), sep =
                                           '')
git_terminal_command = paste(
  "git clone",
  "https://github.com/jumpingrivers/diffify.git",
  testing_git_clone_directory_name,
  "&& ls"
)
working_directory_contents_after_git_pull = system(git_terminal_command, intern =
                                                     TRUE)
test_that("Checking if Git pull works", {
  expect_equal(
    testing_git_clone_directory_name %in% working_directory_contents_after_git_pull,
    TRUE
  )
})
#system("rm -rf testing_git_clone")

# TODO Git push, which repo to push to?

# Installing Tidyverse
test_that("Check if installing popular R package {tidyverse} works.",
          {
            expect_equal({
              install.packages('tidyverse')
              library(ggplot2)
              library(dplyr)
              "tidyverse" %in% installed.packages()[, "Package"]
            }, TRUE)
          })

#TODO: install Python packages numpy and pandas

#TODO: consider how/if we should use sudo rstudio-server verify-installation --verify-user=user

#TODO qmd->HTML

#TODO qmd->PDF (implicitly also tests for LaTeX)

#TODO: Jupyter notebook: built-in verify-installation check

#TODO: install a popular Bioconductor package

#TODO: install an R package based on a Git repository

#TODO: append a line (comment) to .Rprofile, and check that it has been modified

#TODO: same with .Renviron

#TODO: test creating a new file in the home directory
