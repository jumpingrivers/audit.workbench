check_posit_version = function() {
  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    posit_version = rstudioapi::versionInfo()$long_version
  } else {
    cmd = system2("rstudio-server", args = "version", stdout = TRUE)
    posit_version = stringr::str_remove(cmd, " .*")

  }
  posit_version = stringr::str_remove(posit_version, "\\+[0-9]*")
  audit.base::audit_posit_version(posit_version, type = "workbench")
  return(posit_version)
}
