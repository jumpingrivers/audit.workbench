#' R6 classes
#'
#' Check classes
#' @export
check_r_options = R6::R6Class(
  "check_r_options",
  inherit = audit.base::base_check,
  public = list(
    #' @description Check that R download options are set
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_r_options(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Checking R download options",
    short = "download",
    group = "r_options",
    long = "Checking that the `HTTPUserAgent` and `download.file.extra` R options are set"
  )
)

testing_r_options = function() {
  opts = c("HTTPUserAgent", "download.file.extra")
  is_unset = vapply(opts, function(opt) !nzchar(getOption(opt, "")), logical(1))
  if (any(is_unset)) {
    unset = opts[is_unset] # nolint
    cli::cli_abort("R options not set: {unset}")
  }
  invisible(TRUE)
}
