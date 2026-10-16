test_that("multiple installed Posit driver versions use the highest version", {
  local_mocked_bindings(
    get_installed_posit_driver = function() {
      c("2024.12.0", "2025.01.0")
    },
    .package = "audit.workbench"
  )
  local_mocked_bindings(
    get_posit_versions = function(type) {
      expect_identical(type, "drivers")
      data.frame(version = "2025.01.0")
    },
    .package = "audit.base"
  )

  result = check_posit_drivers(debug_level = 0)

  expect_identical(result$installed_version, "2025.01.0")
  expect_identical(result$upgrade, FALSE)
})

test_that("no installed Posit driver version is reported as not installed", {
  local_mocked_bindings(
    get_posit_versions = function(type) data.frame(version = "2025.01.0"),
    .package = "audit.base"
  )
  # NA: no odbcinst.ini.sample; character(0): the file has no RStudioVersion lines
  for (installed in list(NA_character_, character(0))) {
    local_mocked_bindings(
      get_installed_posit_driver = function() installed,
      .package = "audit.workbench"
    )
    result = check_posit_drivers(debug_level = 0)
    expect_identical(result$installed_version, NA_character_)
    expect_true(result$upgrade)
  }
})
