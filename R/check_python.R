#' R6 classes
#'
#' Check classes
#' @export
check_python_pip = R6::R6Class(
  "check_python_pip",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks python pip install
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(python_pip_tests(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Checking pip installs",
    short = "pip",
    group = "python",
    long = "Checking that numpy can be installed using pip"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_python_reticulate = R6::R6Class(
  "check_python_reticulate",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks python can be used via reticulate
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(python_reticulate_tests(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Checking reticulate installs & runs",
    short = "reticulate",
    group = "python",
    long = "Checking that {reticulate} can be installed and runs correctly"
  )
)

# Installs numpy into a temporary venv, so the user's own Python is never changed
python_pip_tests = function(python = find_python()) {
  if (!nzchar(python)) {
    cli::cli_abort("Can't find Python: looked in /opt/python and for python3 on the PATH")
  }
  venv = withr::local_tempdir(pattern = "pip-venv-")
  venv_python = make_venv(python, venv)

  pip_version = processx::run(venv_python, c("-m", "pip", "--version"))$stdout
  stopifnot("pip is older than version 20" = grepl("pip [2-9][0-9]", pip_version))

  processx::run(
    venv_python,
    c("-m", "pip", "install", "--quiet", "--disable-pip-version-check", "numpy")
  )
  processx::run(venv_python, c("-c", "import numpy"))
  invisible(TRUE)
}

python_reticulate_tests = function() {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    utils::install.packages("reticulate")
    withr::defer(utils::remove.packages("reticulate"))
  }

  reticulate::py_run_string("x=2+2")
  stopifnot("Reticulate error " = reticulate::py$x == 4)
  invisible(TRUE)
}
