install_packages = function(pkgs, quiet = FALSE) {
  e = NULL
  capture = function(e) e <<- e #nolint

  # If the package doesn't install correctly, capture the error
  withCallingHandlers(utils::install.packages(pkgs, quiet = quiet), capture = e)
  # If pkg not installed, return FALSE
  is.null(e)
}
