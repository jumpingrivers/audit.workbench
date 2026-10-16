test_that("check_posit_drivers() compares the highest installed version", {
  local_mocked_bindings(
    get_posit_versions = function(type) data.frame(version = "2025.01.0"),
    .package = "audit.base"
  )
  # character(0): odbcinst.ini.sample has no RStudioVersion lines; NA: there's no file
  cases = list(
    list(
      installed = c("2024.12.0", "2025.01.0", "2024.06.0"),
      version = "2025.01.0",
      upgrade = FALSE
    ),
    list(installed = "2024.12.0", version = "2024.12.0", upgrade = TRUE),
    list(installed = character(0), version = NA_character_, upgrade = TRUE),
    list(installed = NA_character_, version = NA_character_, upgrade = TRUE)
  )
  for (case in cases) {
    local_mocked_bindings(
      get_installed_posit_driver = function() case$installed,
      .package = "audit.workbench"
    )
    result = check_posit_drivers(debug_level = 0)
    expect_identical(result$installed_version, case$version)
    expect_identical(result$upgrade, case$upgrade)
  }
})
