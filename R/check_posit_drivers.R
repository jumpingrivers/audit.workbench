check_posit_drivers = function(debug_level) {
  cli::cli_h2("Checking Posit DB Drivers")
  fname = "/opt/rstudio-drivers/odbcinst.ini.sample"
  if (file.exists(fname)) {
    odbc = readLines(fname, warn = FALSE)
    versions = odbc[stringr::str_starts(odbc, "#", negate = TRUE)]
    versions = stringr::str_extract(versions, "RStudioVersion = (.*)", group = TRUE)
    versions = versions[!is.na(versions)]
    installed_version = unique(versions)
  } else {
    installed_version = NA_character_
  }
  version = "2022.11.0"
  upgrade = is.na(installed_version) ||
    (package_version(installed_version) < package_version(version))
  installed = tibble::tibble(
    software = "pro-drivers",
    installed_version = installed_version,
    upgrade = upgrade,
    version = version)
  uatBase::print_colour_versions(installed)
}
