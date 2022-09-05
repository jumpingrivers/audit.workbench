touch_file_succeeds = function(filepath) {
  file_location_normalized = normalizePath(filepath)
  status_from_touch = processx::run("touch", args = c(file_location_normalized))$status
  return(status_from_touch==0)
}

get_permissions_of_file = function(filepath) {
  # We use normalisePath for tilde-expansion, since processx doesn't do this:
  file_location = normalizePath(filepath)
  # The command to check, in octal form, what are the permissions of the file:
  check_permission = processx::run("stat", args = c("-c", "'%a", file_location))
  # Obtain the stdout of the command:
  stdout_of_check_permission = check_permission$stdout
  # Remove any whitespace, newlines or quotes from the stdout string:
  permissions_on_file = gsub(pattern = "\\s|'", "", stdout_of_check_permission)
  # Convert the string to an integer, so that we can use it to make comparisons
  permissions_on_file_int = strtoi(permissions_on_file)
  return(permissions_on_file_int)
}
