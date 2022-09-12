create_file = function(dir = ".") {
  fname = file.path(dir, "tmp-file-creating.txt")
  fs::file_create(fname)
  on.exit(unlink(fname))
  return(file.exists(normalizePath(fname)))
}

get_file_permissions = function(dir = ".") {
  fname = file.path(dir, "tmp-permissions.txt")
  fs::file_create(fname)
  on.exit(unlink(fname))
  file_path = normalizePath(fname)
  # The command to check, in octal form, what are the permissions of the file:
  permissions_on_file = file.mode(file_path)
  # Convert the string to an integer, so that we can use it to make comparisons:
  permissions_on_file_int = strtoi(permissions_on_file)
  return(permissions_on_file_int)
}
