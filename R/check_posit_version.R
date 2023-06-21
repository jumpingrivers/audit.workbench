check_posit_version = function() {
  posit_version = rstudioapi::versionInfo()$long_version
  posit_version = stringr::str_remove(posit_version, "\\+[0-9]*")
  audit.base::audit_posit_version(posit_version, type = "workbench")
  return(posit_version)
}
