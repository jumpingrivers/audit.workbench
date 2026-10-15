# Changelog

## audit.workbench 0.6.17

### New features

- [`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md)
  runs
  [`audit.base::check_timezone()`](https://rdrr.io/pkg/audit.base/man/check_timezone.html),
  and the report says whether R can determine the server’s timezone.
  Requires audit.base 0.7.1 (#32).

## audit.workbench 0.6.16

### Bug fixes and minor improvements

- Add an `air.toml`, so air formats with `=` assignment and
  100-character lines.

## audit.workbench 0.6.15

### New features

- `check_verify_installation` runs `rstudio-server verify-installation`
  and fails if it does (#6).

## audit.workbench 0.6.14

### New features

- `check_r_options` fails when the `HTTPUserAgent` or
  `download.file.extra` R option is unset (#4).

## audit.workbench 0.6.13

### Bug fixes and minor improvements

- Remove the `core_r_pkgs` check, which always failed.
  `check_sys_libs()` already covers system libraries (#19).

## audit.workbench 0.6.12

### Bug fixes and minor improvements

- Issues now use the Jumping Rivers organisation templates.

## audit.workbench 0.6.11 *2026-10-13*

- fix: `check_posit_version()` no longer errors outside RStudio when
  {rstudioapi} is installed
- fix:
  [`create_config()`](https://jumpingrivers.github.io/audit.workbench/reference/create_config.md)
  referenced the old package name `jrHealthCheckWorkbench`

## audit.workbench 0.6.10 *2026-09-29*

- fix: check rvest is installed or code chunk never runs (#19)
- fix: Correction to URL containing required package list (#19)
- feat: Allow code to run outside of RStudio, but provide message when
  running outside RStudio

## audit.workbench 0.6.9 *2026-06-15*

- feat: Better R/Python detection
- Bump roxygen2 version

## audit.workbench 0.6.8 *2026-03-11*

- fix: debug_level now properly passed

## audit.workbench 0.6.7 *2026-02-23*

- fix: Use remote versions of software if possible
- fix: Printing drivers to screen
- fix: Suppress some BioConductor noise
- fix: Check cran didn’t work

## audit.workbench 0.6.6 *2026-01-22*

- fix: Parsing Posit versions \#20
- chore: Linting and air’ing

## audit.workbench 0.6.5 *2025-02-22*

- feat: The {rstudioapi} package is now optional

## audit.workbench 0.6.4 *2023-01-11*

- fix: Return `TRUE`, when `testing_core_r_pkgs()` passes

## audit.workbench 0.6.3 *2023-10-01*

- feat: Check for posit name leakage

## audit.workbench 0.6.2 *2023-09-26*

- feat: Add “All tests complete” message

## audit.workbench 0.6.1 *2023-09-23*

- feat: Improved CLI output

## audit.workbench 0.6.0 *2023-06-30*

- feat: Longer test descriptions

## audit.workbench 0.5.0 *2023-06-21*

- feat: Use %\>% instead of \|\>
- feat: Add initial report
- feat: Standardise function names with

## audit.workbench 0.4.0 *2023-06-11*

- feat: Initial version
