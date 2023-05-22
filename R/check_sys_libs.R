check_sys_libs = function(debug_level) {
  libs = processx::run("apt", args = c("list", "--installed"))
  os = readLines("/etc/os-release")
  audit.base::check_sys_deps(os, libs$stdout, debug_level)
}
