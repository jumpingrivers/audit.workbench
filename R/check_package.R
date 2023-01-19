#' R6 classes
#'
#' Check classes
#' @export
check_cran = R6::R6Class(
  "check_cran",
  inherit = base_check,
  public = list(
    #' @description Installs a package from CRAN
    check = function() {
      private$checker(testing_cran())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking cran installation",
    short = "cran",
    group = "package"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_bioconductor = R6::R6Class(
  "check_bioconductor",
  inherit = base_check,
  public = list(
    #' @description Checks that bioconductor URLs are accessible
    check = function() {
      private$checker(testing_bioconductor())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking bioconductor",
    short = "bioconductor",
    group = "package"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_github = R6::R6Class(
  "check_github",
  inherit = base_check,
  public = list(
    #' @description Checks installs a package from github
    check = function() {
      private$checker(testing_github())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking GitHub installation",
    short = "github",
    group = "package"
  )
)


testing_cran = function() {
  pkg_name = "drat"
  is_installed = install_packages(pkg_name, quiet = TRUE)
  stopifnot("pkg unable to be installed" = is_installed)
  return(invisible(TRUE))
}

testing_github = function() {
  installed_pkg = remotes::install_github("jumpingrivers/datasauRus",
                                          quiet = TRUE, force = TRUE)
  stopifnot(installed_pkg == "datasauRus")
  return(invisible(TRUE))
}

testing_bioconductor = function() {
  # Can we access the bioconductor repos
  # Repo 5 is bioconductor, but doesn't work!
  # Installing a bioconductor pkg is slowwww
  repos = BiocManager::repositories()[1:4]
  lapply(repos, function(repo) {
    stopifnot("Unable to access bioconductor repo" = !httr::http_error(repo))
  })
  return(invisible(TRUE))
}

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
