pip_install = function() {
  numpy = processx::run("pip", args = c("install", "numpy", "--force-reinstall"))
  withr::defer(processx::run("pip", args = c("uninstall", "numpy", "--yes")))
  return(grepl(numpy$stdout, pattern = "Successfully installed"))
}
