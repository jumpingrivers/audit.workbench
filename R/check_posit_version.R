check_posit_version = function() {
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    posit_version = rstudioapi::versionInfo()$long_version
  } else {
    posit_version = rstudio_server_version()
  }
  posit_version = stringr::str_squish(posit_version)

  posit_version = stringr::str_extract(
    posit_version,
    "^20[0-9][0-9]\\.[0-9]?[0-9]\\.[0-9]?[0-9]"
  )
  audit.base::audit_posit_version(posit_version, type = "workbench")
  posit_version
}

# rstudio-server is often not on a user's PATH, so also look where Workbench installs it.
# NA when it can't be found.
rstudio_server_version = function(
  paths = c(Sys.which("rstudio-server"), "/usr/lib/rstudio-server/bin/rstudio-server")
) {
  paths = paths[nzchar(paths) & file.exists(paths)]
  if (length(paths) == 0L) {
    cli::cli_alert_info("Can't find rstudio-server, so can't check the Workbench version")
    return(NA_character_)
  }
  cmd = system2(paths[1L], args = "version", stdout = TRUE)
  stringr::str_remove(cmd[1L], " .*")
}
