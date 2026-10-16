#' R6 classes
#'
#' Check classes
#' @export
check_test_config = R6::R6Class(
  "check_test_config",
  inherit = audit.base::base_check,
  public = list(
    #' @description Run Posit's own configuration check
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_test_config(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Running rstudio-server test-config",
    short = "test_config",
    group = "workbench",
    long = "Checking that `rstudio-server test-config` passes"
  )
)

# test-config, not verify-installation: verify-installation refuses to run while rserver is up,
# which it always is inside a Workbench session, and then stops the service
testing_test_config = function(rstudio_server = Sys.which("rstudio-server")) {
  if (!nzchar(rstudio_server)) {
    cli::cli_abort("Can't find {.code rstudio-server}")
  }
  res = processx::run(
    rstudio_server,
    "test-config",
    error_on_status = FALSE,
    timeout = 300
  )
  if (res$status != 0L) {
    output = trimws(paste(res$stdout, res$stderr)) # nolint
    cli::cli_abort(c("{.code rstudio-server test-config} failed", "i" = "{output}"))
  }
  invisible(TRUE)
}
