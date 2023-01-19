#' Run UAT Checks
#'
#' This functions runs all UAT tests.
#' To skip tests, set check to `no` in the config yaml file.
#' See `create_config()`
#' @param server Posit Workbench server. If NULL, use the ENV variable WORKBENCH_SERVER
#' @param token Posit Workbenc API token. If NULL, use the ENV variable WORKBENCH_API_KEY
#' @param dir directory location of the the config file
#' @param file config file name
#' @importFrom rlang .data
#' @export
check = function(server = NULL, token = NULL,
                 dir = ".", file = "config-uat.yml") {

  cli::cli_h2("Starting checks")
  r6_inits = init_r6_checks(dir = dir, file = file)
  lapply(r6_inits, function(r6) r6$check())
  results = purrr::map_dfr(r6_inits, ~.x$get_log())
  dplyr::arrange(results, .data$group, .data$short)
}

init_r6_checks = function(dir, file) {
  exports = getNamespaceExports("jrHealthCheckWorkbench")
  check_exports = sort(exports[stringr::str_starts(exports, "check_")])
  r6_inits = lapply(check_exports, init_r6_check, dir = dir, file = file)
  r6_inits
}

init_r6_check = function(export, dir, file) {
  obj = eval(parse(text = export))
  if (inherits(obj, "R6ClassGenerator")) {
    obj = obj$new(dir, file)
  } else {
    obj = NULL
  }
  return(obj)
}
