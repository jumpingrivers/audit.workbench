# R6 classes

R6 classes

R6 classes

## Details

Checks that core R packages are pre-installed as described in
https://docs.posit.co/ide/server-pro/reference/r_package_dependencies.html

## Super classes

[`audit.base::logger`](https://rdrr.io/pkg/audit.base/man/logger.html)
-\>
[`audit.base::base_check`](https://rdrr.io/pkg/audit.base/man/base_check.html)
-\> `check_core_r_pkgs`

## Methods

### Public methods

- [`check_core_r_pkgs$check()`](#method-check_core_r_pkgs-check)

- [`check_core_r_pkgs$clone()`](#method-check_core_r_pkgs-clone)

Inherited methods

- [`audit.base::logger$get_log()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-get_log)
- [`audit.base::logger$start_logger()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-start_logger)
- [`audit.base::logger$stop_logger()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-stop_logger)
- [`audit.base::base_check$info()`](https://jumpingrivers.github.io/audit.base/html/base_check.html#method-base_check-info)
- [`audit.base::base_check$initialize()`](https://jumpingrivers.github.io/audit.base/html/base_check.html#method-base_check-initialize)

------------------------------------------------------------------------

### Method [`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md)

Test for core R packages

#### Usage

    check_core_r_pkgs$check(debug_level)

#### Arguments

- `debug_level`:

  See check() for details

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    check_core_r_pkgs$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
