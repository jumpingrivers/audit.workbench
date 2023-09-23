#' Run UAT Checks
#'
#' This functions runs all UAT tests.
#' To skip tests, set check to `no` in the config yaml file.
#' See `create_config()`
#' @param server Posit Workbench server. If NULL, use the ENV variable WORKBENCH_SERVER
#' @param dir directory location of the the config file
#' @param debug_level Integer, 0 to 2.
#'
#' @details
#' Debug level description
#'  * 0: clean-up all files; suppress all noise
#'  * 1: clean-up all files, but display build steps
#'  * 2: No clean-up and display build steps
#' @importFrom rlang .data
#' @export
check = function(server,
                 dir = ".",
                 debug_level = 0:2) {
  debug_level = audit.base::get_debug_level(force(debug_level))

  check_list = list()
  check_list$audit_details = audit_details(server)
  check_list$server_headers = serverHeaders::check(server)
  check_list$posit_version = check_posit_version()
  check_list$pro_drivers = check_posit_drivers(debug_level)

  check_list$sys_deps = check_sys_libs(debug_level)
  check_list$versions = check_versions(debug_level)
  cli::cli_h2("Starting checks")
  r6_inits = audit.base::init_r6_checks(dir = dir,
                                        file = "config-uat-psw.yml",
                                        pkg_name = "audit.workbench")
  lapply(r6_inits, function(r6) r6$check(debug_level = debug_level))
  results = purrr::map_dfr(r6_inits, ~.x$get_log())
  check_list$results = dplyr::arrange(results, .data$group, .data$short)
  return(invisible(check_list))
}
