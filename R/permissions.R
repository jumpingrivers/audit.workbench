touch_file_succeeds = function(filepath) {
  file_location_normalized = normalizePath(filepath)
  status_from_touch = processx::run("touch", args = c(file_location_normalized))$status
  return(status_from_touch == 0)
}

get_permissions_of_file = function(filepath) {
  # The command to check, in octal form, what are the permissions of the file:
  permissions_on_file = file.mode(filepath)
  # Convert the string to an integer, so that we can use it to make comparisons:
  permissions_on_file_int = strtoi(permissions_on_file)
  return(permissions_on_file_int)
}
