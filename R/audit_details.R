audit_details = function(server) {
  list(user = Sys.info()[["user"]],
       server = server,
       time = Sys.time(),
       version = utils::packageVersion("audit.workbench"))
}
