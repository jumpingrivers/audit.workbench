check_sys_libs = function(debug_level) {
  libs = audit.base::get_installed_libs()
  os = readLines("/etc/os-release")
  audit.base::check_sys_deps(os, libs, debug_level)
}
