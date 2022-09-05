touch_file_succeeds = function(filepath) {
  file_location_normalized = normalizePath(filepath)
  status_from_touch = processx::run("touch", args = c(file_location_normalized))$status
  return(status_from_touch == 0)
}

get_permissions_of_file = function(filepath) {
  # We use normalisePath for tilde-expansion, since processx doesn't do this:
  normalized_filepath = normalizePath(filepath)
  # The command to check, in octal form, what are the permissions of the file:
  permissions_on_file = file.mode(normalized_filepath)
  permissions_on_file_int = strtoi(permissions_on_file)
  return(permissions_on_file_int)
}
