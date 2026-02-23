check_posit_drivers = function(debug_level) {
  cli::cli_h2("Checking Posit DB Drivers")
  installed_version = get_installed_posit_driver()
  latest_version = audit.base::get_posit_versions(type = "drivers")$version[1]
  upgrade = is.na(installed_version) ||
    (package_version(installed_version) < package_version(latest_version))
  installed = tibble::tibble(
    software = "Posit pro-drivers",
    installed_version = installed_version,
    upgrade = upgrade,
    version = latest_version
  )
  print_colour_version_posit_driver(installed[1, ])
  installed
}

get_installed_posit_driver = function() {
  fname = "/opt/rstudio-drivers/odbcinst.ini.sample"
  if (file.exists(fname)) {
    odbc = readLines(fname, warn = FALSE)
    versions = odbc[stringr::str_starts(odbc, "#", negate = TRUE)]
    versions = stringr::str_extract(
      versions,
      "RStudioVersion = (.*)",
      group = TRUE
    )
    versions = versions[!is.na(versions)]
    installed_version = unique(versions)
  } else {
    installed_version = NA_character_
  }
  installed_version
}


print_colour_version_posit_driver = function(row) {
  software_name = glue::glue("{stringr::str_to_title(row$software)}{major}") # nolint
  latest_version = glue::glue("v{row$version}") # nolint
  if (is.na(row$installed_version)) {
    cli::cli_alert_danger(
      "{software_name}: latest {latest_version} not installed"
    )
    return(invisible(NULL))
  }

  if (isTRUE(row$upgrade)) {
    cli::cli_alert_danger(
      "{software_name}: v{row$installed_version} installed, \\
                          but {latest_version} available"
    )
  } else {
    cli::cli_alert_success(
      "{software_name}: Latest version installed"
    )
  }
  invisible(NULL)
}
