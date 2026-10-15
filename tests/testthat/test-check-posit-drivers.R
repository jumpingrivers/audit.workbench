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
