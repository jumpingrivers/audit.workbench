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
