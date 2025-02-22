#' R6 classes
#'
#' Checks that core R packages are pre-installed as described in
#' https://docs.posit.co/ide/server-pro/reference/r_package_dependencies.html
#' @export
check_core_r_pkgs = R6::R6Class(
  "check_core_r_pkgs",
  inherit = audit.base::base_check,
  public = list(
    #' @description Test for core R packages
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_core_r_pkgs(debug_level))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Checking core_r_pkgs",
    long = "Checks that core R packages are pre-installed as described in
    [the Posit Workbench documentation](https://docs.posit.co/ide/server-pro/reference/r_package_dependencies.html)", #nolint
    short = "r_pkgs",
    group = "package"
  )
)

testing_core_r_pkgs = function(debug_level) {
  core_r_pkgs = get_core_r_packages()
  in_pkgs = utils::installed.packages()
  missing_r_pkgs = core_r_pkgs[!(core_r_pkgs %in% rownames(in_pkgs))]
  if (length(missing_r_pkgs) > 0L) {
    cli::cli_abort("Core R packages are missing: {missing_r_pkgs}")
  }
  return(TRUE)
}

get_core_r_packages = function() {
  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    core = rstudioapi::getRStudioPackageDependencies()$name
  } else if (requireNamespace("rstudioapi", quietly = TRUE)) {
    html = rvest::read_html("https://docs.posit.co/ide/server-pro/reference/r_package_dependencies.html") #nolint
    cells = rvest::html_nodes(html, "td")
    values = purrr::map_chr(cells, rvest::html_text2)
    all = tibble::tibble(
      "name" = values[seq.int(1L, length(values), 3L)],
      "version" = values[seq.int(1L, length(values), 3L) + 1],
      "features" = values[seq.int(1L, length(values), 3L) + 2]
    )
    core = all$name
  } else {
    stop("Install either rstudioapi or rvest to check core packages ")
  }
  return(sort(core))
}
