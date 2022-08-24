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
  # URL of Git repository which we would like to test cloning of:
  GIT_CLONE_URL = "https://github.com/jumpingrivers/diffify.git"
  
  #Current time, with spaces removed:
  current_time_no_spaces = gsub(" ", "", Sys.time())
  # Variable representing the path of the directory where we want git to save the
  # cloned files on our machine:
  temporary_directory_which_will_contain_git_clone_directory = file.path(tempdir(), "git_clones")
  # Variable representing the name of the new subdirectory we would like to
  # clone into. This doesn't include the names of parent folders:
  testing_git_clone_directory_name = paste("git_clones", current_time_no_spaces, sep="")
  # The full path of the directory we would like to clone into:
  git_clone_directory_path = file.path(
    temporary_directory_which_will_contain_git_clone_directory,
    testing_git_clone_directory_name
  )
  
  # Constructing the terminal command to clone our Git repository and then list
  # all files in the containing directory:
  git_terminal_command = paste(
    "git clone",
    "https://github.com/jumpingrivers/diffify.git",
    git_clone_directory_path,
    "&& ls",
    temporary_directory_which_will_contain_git_clone_directory
  )
  if(!dir.exists(temporary_directory_which_will_contain_git_clone_directory)){dir.create(temporary_directory_which_will_contain_git_clone_directory)}
  # withr::with_tempdir creates a temporary directory, which will be deleted when
  # the session ends:
  withr::with_dir(temporary_directory_which_will_contain_git_clone_directory, {
    # Run the terminal command which clones the Git repository and returns the
    # list of all files in the containing directory:
    containing_directory_contents_after_git_pull = system(git_terminal_command, intern = TRUE)
    # Assert that the cloned repository is where we expect it to be:
    print(paste("We are checking this directory contents listing:", list.files(getwd())))
    print(paste("For these contents", testing_git_clone_directory_name))
    testthat::expect_true(
      testing_git_clone_directory_name %in% list.files(getwd())
    )
  })
})

# TODO Git push, which repo to push to?

#Installing an R package
testthat::test_that(paste(
  "Installing R package: {",
  R_PACKAGE_TO_TEST_INSTALLATION_OF,
  "}",
  sep = ''
),
{
  install.packages(R_PACKAGE_TO_TEST_INSTALLATION_OF,
                   repo = REPO_URL,
                   quietly = TRUE)
    package_loading_worked_correctly = withr::with_package(package = R_PACKAGE_TO_TEST_INSTALLATION_OF, {
      testthat::expect_true(R_PACKAGE_TO_TEST_INSTALLATION_OF %in% installed.packages()[, "Package"])
    },
    logical.return = TRUE
  )
  testthat::expect_true(package_loading_worked_correctly)
  testthat::expect_true(require(R_PACKAGE_TO_TEST_INSTALLATION_OF, character.only = TRUE))
  testthat::expect_true(R_PACKAGE_TO_TEST_INSTALLATION_OF %in% installed.packages()[, "Package"])
  #TODO https://withr.r-lib.org/ to put state back. This one? https://withr.r-lib.org/reference/with_package.html#ref-examples
})

#TODO: install Python packages numpy and pandas
