#' R6 classes
#'
#' Check classes
#' @export
check_git_cloning = R6::R6Class(
  "check_git_cloning",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checking that we can access and clone from github.com
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(git_cloning(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Cloning from github.com",
    short = "git",
    group = "Cloning",
    long = "Checking that we can access and clone from `github.com`"
  )
)

git_cloning = function(debug_level) {
  git_clone_url = "https://github.com/jumpingrivers/diffify.git"
  git_local_folder = file.path(tempdir(), "diffify")

  system2("git", args = c("clone", "--depth", "1", git_clone_url, git_local_folder))
  withr::defer(unlink(git_local_folder, recursive = TRUE))
  success = dir.exists(git_local_folder)
  return(success)
}
