test_that("find_python() prefers the newest Python in /opt/python, then the PATH", {
  opt = withr::local_tempdir()
  for (v in c("3.9.1", "3.12.4", "3.10.2", "current")) {
    dir.create(file.path(opt, v, "bin"), recursive = TRUE)
    file.create(file.path(opt, v, "bin", "python3"))
  }
  path = withr::local_tempdir()
  file.create(file.path(path, "python3"))
  Sys.chmod(file.path(path, "python3"), "755")
  empty = withr::local_tempdir()

  cases = list(
    list(root = opt, path = path, expected = file.path(opt, "3.12.4", "bin", "python3")),
    list(root = empty, path = path, expected = file.path(path, "python3")),
    list(root = empty, path = empty, expected = "")
  )
  for (case in cases) {
    withr::with_envvar(c(PATH = case$path), {
      expect_identical(find_python(case$root), case$expected)
    })
  }
})

test_that("make_venv() names the Python that can't make a virtual environment", {
  python = file.path(withr::local_tempdir(), "python3")
  writeLines(c("#!/bin/sh", "echo 'ensurepip is not available' >&2", "exit 1"), python)
  Sys.chmod(python, "755")
  expect_error(make_venv(python, withr::local_tempdir()), "Can't make a virtual environment with")
})

test_that("render_quarto_python() needs a Python", {
  expect_error(render_quarto_python(".", debug_level = 0, python = ""), "Can't find Python")
})

test_that("check_quarto_python renders audit.base's Python document", {
  # Builds a virtual environment and renders, so it needs Python 3 and Quarto
  skip_if_not(nzchar(find_python()), "No Python 3")
  skip_if_not(nzchar(Sys.which("quarto")), "No Quarto")
  r6 = check_quarto_python$new(dir = withr::local_tempdir(), file = "none.yml")
  suppressMessages(r6$check(debug_level = 0))
  expect_true(r6$get_log()$passed)
  expect_false(dir.exists(file.path(tempdir(), "quarto-python-venv")))
})
