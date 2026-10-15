#' R6 classes
#'
#' Check classes
#' @export
check_verify_installation = R6::R6Class(
  "check_verify_installation",
  inherit = audit.base::base_check,
  public = list(
    #' @description Run Posit's own installation check
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_verify_installation(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Running rstudio-server verify-installation",
    short = "verify_installation",
    group = "workbench",
    long = "Checking that `rstudio-server verify-installation` passes"
  )
)

testing_verify_installation = function() {
  if (!nzchar(Sys.which("rstudio-server"))) {
    cli::cli_abort("Can't find {.code rstudio-server}")
  }
  res = processx::run(
    "rstudio-server",
    "verify-installation",
    error_on_status = FALSE,
    timeout = 300
  )
  if (res$status != 0L) {
    output = trimws(paste(res$stdout, res$stderr)) # nolint
    cli::cli_abort(c("{.code rstudio-server verify-installation} failed", "i" = "{output}"))
  }
  invisible(TRUE)
}
