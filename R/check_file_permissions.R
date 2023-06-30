#' R6 classes
#'
#' Check classes
#' @export
check_file_permissions = R6::R6Class(
  "check_file_permissions",
  inherit = audit.base::base_check,
  public = list(
    #' @description Check
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_file_permissions(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking file permissions",
    short = "permissions",
    group = "user",
    long = "Checking that newly created files in a user's home directory
    have the correct file permission"
  )
)

testing_file_permissions = function(debug_level) {
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
