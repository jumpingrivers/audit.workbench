#' R6 classes
#'
#' Check classes
#' @export
check_file_permissions = R6::R6Class(
  "check_file_permissions",
  inherit = base_check,
  public = list(
    #' @description Checks deployment of a Plumber API
    check = function() {
      private$checker(testing_file_permissions())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking file permissions",
    short = "permissions",
    group = "user"
  )
)

testing_file_permissions = function() {
  fname = file.path("~", "tmp-file-creating.txt")
  withr::with_file(fname, {
    fs::file_create(fname)
    stopifnot("file does not exist" = file.exists(fname))
    permissions_on_file = file.mode(fname)
    # Convert the string to an integer, so that we can use it to make comparisons:
    file_permissions = strtoi(permissions_on_file)
    stopifnot("File permissions incorrect" = file_permissions >= 600)
  }
  )
  return(invisible(TRUE))
}
