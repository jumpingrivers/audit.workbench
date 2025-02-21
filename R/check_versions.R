check_versions = function(debug_level) {
  cli::cli_h2("Checking R/Python/Quarto Versions")
  # Assume everything stored in /opt
  root_dir = "/opt"
  root_dir = "/usr/bin"
  r_dir = fs::dir_ls(root_dir, regexp = "/[R|r]$")
  py_dir = fs::dir_ls(root_dir, regexp = "/[P|p]ython$")
  quarto_dir = fs::dir_ls(root_dir, regexp = "/[Q|q]uarto$")

  # Liberal Reg Exp
  regexpr = "[1-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]$"
  r_vers = fs::dir_ls(r_dir, type = "directory", regexp = regexpr)
  py_vers = fs::dir_ls(py_dir, type = "directory", regexp = regexpr)
  quarto_vers = fs::dir_ls(quarto_dir, type = "directory", regexp = regexpr)

  versions = stringr::str_extract(c(r_vers, py_vers, quarto_vers), regexpr)
  software = rep(c("r", "python", "quarto"),
                 c(length(r_vers), length(py_vers), length(quarto_vers)))

  installed = tibble::tibble(installed_version = versions, software)
  audit.base::augment_installed(installed)
}

dir_name = "/usr/bin"
find_versions = function(dir_name) {
  root_dir = dir_name
  r_dir = fs::dir_ls(root_dir, regexp = "/[R|r]$")
  py_dir = fs::dir_ls(root_dir, regexp = "/[P|p]ython$")
  quarto_dir = fs::dir_ls(root_dir, regexp = "/[Q|q]uarto$")

  r_dir = ?fs::dir_ls(root_dir, regexp = "/[R|r]$", type = )
  py_dir = fs::dir_ls(root_dir, regexp = "/[P|p]ython$")
  quarto_dir = fs::dir_ls(root_dir, regexp = "/[Q|q]uarto$")

  # Liberal Reg Exp
  regexpr = "[1-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]$"
  r_vers = fs::dir_ls(r_dir, type = "directory", regexp = regexpr)
  py_vers = fs::dir_ls(py_dir, type = "directory", regexp = regexpr)
  quarto_vers = fs::dir_ls(quarto_dir, type = "directory", regexp = regexpr)

  versions = stringr::str_extract(c(r_vers, py_vers, quarto_vers), regexpr)
  software = rep(c("r", "python", "quarto"),
                 c(length(r_vers), length(py_vers), length(quarto_vers)))

  installed = tibble::tibble(installed_version = versions, software)
  audit.base::augment_installed(installed)
}