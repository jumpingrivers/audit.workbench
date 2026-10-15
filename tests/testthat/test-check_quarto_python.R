test_that("find_python() falls back to the newest Python in /opt/python", {
  root = withr::local_tempdir()
  for (v in c("3.9.1", "3.12.4", "3.10.2", "current")) {
    dir.create(file.path(root, v, "bin"), recursive = TRUE)
    file.create(file.path(root, v, "bin", "python3"))
  }
  withr::local_envvar(PATH = "")
  expect_identical(find_python(root), file.path(root, "3.12.4", "bin", "python3"))
  expect_identical(find_python(withr::local_tempdir()), "")
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
