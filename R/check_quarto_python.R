#' R6 classes
#'
#' Check classes
#' @export
check_quarto_python = R6::R6Class(
  "check_quarto_python",
  inherit = audit.base::base_check,
  public = list(
    #' @description Check that Quarto can render a document with Python
    #' @param debug_level See check() for details
    check = function(debug_level) {
      quarto_dir = system.file(
        "extdata",
        private$group,
        private$short,
        package = "audit.base",
        mustWork = TRUE
      )
      private$checker(render_quarto_python(quarto_dir, debug_level), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Rendering python",
    short = "python",
    group = "render_quarto",
    long = "Checking that quarto can render a document with the Jupyter engine, using a
    virtual environment built from the document's requirements.txt"
  )
)

# python3 on the PATH, else the newest Python in /opt/python, where Posit installs it
find_python = function(root_dir = "/opt/python") {
  python = unname(Sys.which("python3"))
  if (nzchar(python)) {
    return(python)
  }
  pythons = Sys.glob(file.path(root_dir, "*", "bin", "python3"))
  versions = basename(dirname(dirname(pythons)))
  pythons = pythons[grepl("^[0-9]+\\.[0-9]+", versions)]
  if (length(pythons) == 0L) {
    return("")
  }
  versions = numeric_version(basename(dirname(dirname(pythons))), strict = FALSE)
  # order() rather than which.max(), which can't sort versions before R 4.6
  pythons[order(versions, decreasing = TRUE)[1]]
}

render_quarto_python = function(quarto_dir, debug_level, python = find_python()) {
  if (!nzchar(python)) {
    cli::cli_abort("Can't find Python: looked for python3 on the PATH and in /opt/python")
  }
  venv = file.path(tempdir(), "quarto-python-venv")
  on.exit({
    if (debug_level < 2L && fs::dir_exists(venv)) fs::dir_delete(venv)
  }) #nolint
  processx::run(python, c("-m", "venv", venv))
  venv_python = file.path(venv, "bin", "python")
  processx::run(
    venv_python,
    c("-m", "pip", "install", "--quiet", "-r", file.path(quarto_dir, "requirements.txt"))
  )
  # A user's python3 Jupyter kernel runs whichever python is first on the PATH,
  # so put the virtual environment there as well as in QUARTO_PYTHON
  path = paste(dirname(venv_python), Sys.getenv("PATH"), sep = .Platform$path.sep)
  withr::with_envvar(
    c(QUARTO_PYTHON = venv_python, PATH = path),
    render_quarto(quarto_dir, debug_level)
  )
}
