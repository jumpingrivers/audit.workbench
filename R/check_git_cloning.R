#' R6 classes
#'
#' Check classes
#' @export
check_git_cloning = R6::R6Class(
  "check_git_cloning",
  inherit = base_check,
  public = list(
    #' @description Checks deployment of a Plumber API
    check = function() {
      private$checker(git_cloning())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Cloning from github.com",
    short = "git",
    group = "Cloning"
  )
)

git_cloning = function() {
  git_clone_url = "https://github.com/jumpingrivers/diffify.git"
  git_local_folder = file.path(tempdir(), "diffify")

  system2("git", args = c("clone", "--depth", "1", git_clone_url, git_local_folder))
  withr::defer(unlink(git_local_folder, recursive = TRUE))
  success = dir.exists(git_local_folder)
  return(success)
}
