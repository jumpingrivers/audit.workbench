#' Create test config
#'
#' This function creates an example config. By default all tests are TRUE.
#' Some RSC servers intentionally won't have some features implemented.
#'
#' @param dir Directory of the config file
#' @param default Default value for if a test should run (logical)
#' @param type Merge type, see details
#'
#' @details If a test is missing from the config file, it is assume to be TRUE.
#' Therefore, the config file can be quite short and just list exceptions.
#' If the config file is missing, then all tests are carried out.
#'
#' When merging configs, we either
#' * merge the new with existing
#' * force: overwrite existing file
#' * error: if a config file exists, raise an error
#' @export
create_config = audit.base::create_config(file = "config-uat-psw.yml",
                                       pkg_name = "jrHealthCheckWorkbench")
