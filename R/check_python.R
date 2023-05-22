#' R6 classes
#'
#' Check classes
#' @export
check_python_pip = R6::R6Class(
  "check_python",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks python pip install
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(python_pip_tests(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking pip installs",
    short = "pip",
    group = "python"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_python_reticulate = R6::R6Class(
  "check_python",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks python can be used via reticulate
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(python_reticulate_tests(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking reticulate installs & runs",
    short = "reticulate",
    group = "python"
  )
)

python_pip_tests = function(debug_level) {
  system('python3 -c "print(2+2)"', intern = TRUE)

  pip_version = processx::run("pip", "--version")$stdout
  min_version = grepl("pip [2-3][0-9]", pip_version)
  stopifnot("Pip failed to install " = min_version)

  numpy = processx::run("pip", args = c("install", "numpy", "--force-reinstall"))
  withr::defer(processx::run("pip", args = c("uninstall", "numpy", "--yes")))
  has_installed = grepl(numpy$stdout, pattern = "Successfully installed")
  stopifnot("Pip failed to install " = has_installed)
  return(invisible(TRUE))
}

python_reticulate_tests = function(debug_level) {

  if (!requireNamespace("reticulate", quietly = TRUE)) {
    utils::install.packages("reticulate")
    withr::defer(utils::remove.packages("reticulate"))
  }

  reticulate::py_run_string("x=2+2")
  stopifnot("Reticulate error " = reticulate::py$x == 4)
  return(invisible(TRUE))
}
