# Changelog

## audit.workbench 0.6.25

### Bug fixes and minor improvements

- [`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md)
  no longer stops outside the RStudio IDE when `rstudio-server` isn’t on
  the `PATH`. It also looks in `/usr/lib/rstudio-server/bin`, and
  otherwise reports the Workbench version as unknown. Requires
  audit.base 0.7.8 (#38).

## audit.workbench 0.6.24

### Bug fixes and minor improvements

- CI uses `actions/checkout@v5`, read-only permissions, and installs
  Quarto, so the Quarto Python test runs on CI (#45).

## audit.workbench 0.6.23

### Bug fixes and minor improvements

- `debug_level = 2` keeps the Quarto and R Markdown render folders, as
  documented (#45).
- `check_python_pip` and `check_python_reticulate` have their own R6
  class names; both were `check_python` (#45).
- [`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md)
  no longer claims a `NULL` server falls back to `WORKBENCH_SERVER`
  (#45).
- Fix the `check_rmd` help title and description, import R6 and re-knit
  README.md (#45).

## audit.workbench 0.6.22

### Bug fixes and minor improvements

- [`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md)
  no longer stops when `/opt/R`, `/opt/python` or `/opt/quarto` is
  missing; it reports the folder as not found (#37).
- `check_file_permissions` fails when new files in the home directory
  are writable by other users, or not readable and writable by their
  owner. It no longer deletes `~/tmp-file-creating.txt` (#42).
- `check_cran` and `check_github` install their test packages into a
  temporary library, so the user’s library is left as it was (#43).

## audit.workbench 0.6.21

### Bug fixes and minor improvements

- `check_posit_drivers()` compares the highest installed driver version
  when multiple versions are present, and reports none found as not
  installed (#45).

## audit.workbench 0.6.20

### Bug fixes and minor improvements

- `check_verify_installation` is now `check_test_config`, and runs
  `rstudio-server test-config`. `verify-installation` refuses to run
  while the server is up, so the old check always failed inside a
  session. Use `test_config` in place of `verify_installation` in config
  files (#36).

## audit.workbench 0.6.19

### New features

- `check_quarto_python` builds a virtual environment from audit.base’s
  Quarto Python document and renders it with the Jupyter engine. It uses
  `python3` on the `PATH`, or the newest Python in `/opt/python`.
  Requires audit.base 0.7.2 (#3).

### Bug fixes and minor improvements

- Remove the unused `inst/extdata/python` example, whose 2023 pins don’t
  install on Python 3.14.

## audit.workbench 0.6.18

### New features

- `check_reticulate_r_versions` runs each R in `/opt/R` with its own
  site settings, and fails if any lacks {reticulate} or has a
  `RETICULATE_PYTHON` that is unset or not an executable file (#5).

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
