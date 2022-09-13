install_packages = function(pkgs, quiet = FALSE) {
  e = NULL
  capture = function(e) e <<- e #nolint

  # install.packages() doesn't throw an error if the pkg install fails
  # instead we capture the warning using capture() - that then changes the value of `e`
  # Hence: if e isn't null, something bad has happened.
  withCallingHandlers(utils::install.packages(pkgs, quiet = quiet), warning = capture)
  # If pkg not installed, return FALSE
  is.null(e)
}
