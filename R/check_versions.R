check_versions = function(debug_level) {
  cli::cli_h2("Checking R/Python/Quarto Versions")
  # Assume everything stored in /opt
  root_dir = "/opt"

  # Liberal Reg Exp
  regexpr = "[1-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]"
  r_vers = find_versions(
    file.path(root_dir, "R"),
    type = "any",
    regexp = paste0(root_dir, "/[R|r]/", regexpr, "/bin/R$"),
    recurse = TRUE
  )
  py_vers = find_versions(
    file.path(root_dir, "python"),
    type = "any",
    regexp = paste0(root_dir, "/[P|p]ython/", regexpr, "/bin/python$"),
    recurse = TRUE
  )
  quarto_vers = find_versions(
    file.path(root_dir, "quarto"),
    type = "directory",
    regexp = regexpr
  )

  versions = stringr::str_extract(c(r_vers, py_vers, quarto_vers), regexpr)
  software = rep(
    c("r", "python", "quarto"),
    c(length(r_vers), length(py_vers), length(quarto_vers))
  )
  software
  installed = tibble::tibble(installed_version = versions, software)
  audit.base::augment_installed(installed, remote = TRUE)
}

# A server without, say, Posit's Python builds has no /opt/python
find_versions = function(dir, ...) {
  if (!fs::dir_exists(dir)) {
    cli::cli_alert_info("{.path {dir}} not found")
    return(character(0))
  }
  fs::dir_ls(dir, ...)
}
