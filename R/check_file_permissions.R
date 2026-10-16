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
      private$checker(testing_file_permissions(), debug_level)
      invisible(NULL)
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

testing_file_permissions = function() {
  fname = withr::local_tempfile(tmpdir = path.expand("~"))
  file.create(fname)
  stopifnot("file does not exist" = file.exists(fname))
  # file.mode() is octal: the owner must read and write, and other users must not write
  mode = as.integer(file.mode(fname))
  owner_rw = strtoi("600", 8L)
  other_w = strtoi("002", 8L)
  stopifnot(
    "New files can't be read and written by their owner" = bitwAnd(mode, owner_rw) == owner_rw
  )
  stopifnot("New files can be written by other users" = bitwAnd(mode, other_w) == 0L)
  invisible(TRUE)
}
