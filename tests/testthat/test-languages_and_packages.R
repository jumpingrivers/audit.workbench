repo_url = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"
r_package_to_install = "drat"

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
  reticulate::py_run_string("x=2+2")
  testthat::expect_equal(reticulate::py$x, 4)
})

# Testing if Git pull works
testthat::test_that("Git pull", {
  # URL of Git repository which we would like to test cloning of:
  git_clone_url = "https://github.com/jumpingrivers/diffify.git"

  #Current time, with spaces removed:
  current_time_no_spaces = gsub(" ", "", Sys.time())
  # Variable representing the path of the directory where we want git to save the
  # cloned files on our machine:
  parent_of_temporary_clone = file.path(tempdir(), "git_clones")
  # Variable representing the name of the new subdirectory we would like to
  # clone into. This doesn't include the names of parent folders:
  clone_directory_name = paste("git_clones", current_time_no_spaces, sep = "")
  # The full path of the directory we would like to clone into:
  git_clone_directory_path = file.path(
    parent_of_temporary_clone,
    clone_directory_name
  )

  # Constructing the terminal command to clone our Git repository and then list
  # all files in the containing directory:
  git_terminal_command = paste(
    "git clone",
    "https://github.com/jumpingrivers/diffify.git",
    git_clone_directory_path,
    "&& ls",
    parent_of_temporary_clone
  )
  if (!dir.exists(parent_of_temporary_clone)) {
    dir.create(parent_of_temporary_clone)
    }
  # withr::with_tempdir creates a temporary directory, which will be deleted when the session ends:
  withr::with_dir(parent_of_temporary_clone, {

    # Run the terminal command which clones the Git repository and returns the
    # list of all files in the containing directory:
    containing_ls_after_git_pull = system(git_terminal_command, intern = TRUE)
    # Assert that the cloned repository is where we expect it to be:
    print(paste("We are checking this directory contents listing:", list.files(getwd())))
    print(paste("For these contents", clone_directory_name))
    testthat::expect_true(
      clone_directory_name %in% list.files(getwd())
    )
  })
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
