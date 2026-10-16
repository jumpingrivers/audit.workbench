test_that("python_pip_tests() installs numpy in a venv and leaves the user's Python alone", {
  expect_error(python_pip_tests(python = ""), "Can't find Python")

  python = find_python()
  skip_if_not(nzchar(python), "No Python 3")
  skip_if_offline()
  has_numpy = function() {
    processx::run(python, c("-c", "import numpy"), error_on_status = FALSE)$status == 0L
  }
  before = has_numpy()
  expect_true(python_pip_tests(python))
  expect_identical(has_numpy(), before)
})
