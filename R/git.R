clone_diffify = function() {
  git_clone_url = "https://github.com/jumpingrivers/diffify.git"
  git_local_folder = file.path(tempdir(), "diffify")

  system2("git", args = c("clone", "--depth", "1", git_clone_url, git_local_folder))
  withr::defer(unlink(git_local_folder, recursive = TRUE))
  success = dir.exists(git_local_folder)
  return(success)
}
