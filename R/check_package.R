#' R6 classes
#'
#' Check classes
#'
#' @aliases check_quarto_beamer check_quarto_docx
#' @aliases check_quarto_html check_quarto_observable check_quarto_pdf
#' @aliases check_quarto_rsvg_convert
#' @export
check_cran = R6::R6Class(
  "check_cran",
  inherit = audit.base::base_check,
  public = list(
    #' @description Installs a package from CRAN
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_cran(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking cran installation",
    short = "cran",
    group = "package",
    long = "Checking that we can install a package from CRAN"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_bioconductor = R6::R6Class(
  "check_bioconductor",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks that bioconductor URLs are accessible
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_bioconductor(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking bioconductor",
    short = "bioconductor",
    group = "package",
    long = "Checking that we can install a package from Bioconductor"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_github = R6::R6Class(
  "check_github",
  inherit = audit.base::base_check,
  public = list(
    #' @description Checks installs a package from github#
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_github(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking GitHub installation",
    short = "github",
    group = "package",
    long = "Checking that we can install a package from Github using remotes::install_github"
  )
)


testing_cran = function(debug_level) {
  pkg_name = "drat"
  is_installed = install_packages(pkg_name, quiet = TRUE)
  stopifnot("pkg unable to be installed" = is_installed)
  return(invisible(TRUE))
}

testing_github = function(debug_level) {
  installed_pkg = remotes::install_github("jumpingrivers/datasauRus",
                                          quiet = TRUE, force = TRUE)
  stopifnot(installed_pkg == "datasauRus")
  return(invisible(TRUE))
}

testing_bioconductor = function(debug_level) {
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
