#' R6 classes
#'
#' Checks that core R packages are pre-installed as described in
#' https://docs.posit.co/ide/server-pro/reference/r_package_dependencies.html
#' @export
check_core_r_pkgs = R6::R6Class(
  "check_core_r_pkgs",
  inherit = base_check,
  public = list(
    #' @description Test for core R packages
    check = function() {
      private$checker(testing_core_r_pkgs())
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking core_r_pkgs",
    short = "r_pkgs",
    group = "package"
  )
)

testing_core_r_pkgs = function() {
  core_r_pkgs = rstudioapi::getRStudioPackageDependencies()$name
  in_pkgs = utils::installed.packages()
  missing_r_pkgs = core_r_pkgs[!(core_r_pkgs %in% rownames(in_pkgs))]
  if (length(missing_r_pkgs) > 0L) {
    cli::cli_abort("Core R packages are missing: {missing_r_pkgs}")
  }
  return(NULL)
}
