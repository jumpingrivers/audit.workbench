# R6 classes

Check classes

## Super classes

[`audit.base::logger`](https://rdrr.io/pkg/audit.base/man/logger.html)
-\>
[`audit.base::base_check`](https://rdrr.io/pkg/audit.base/man/base_check.html)
-\> `check_test_config`

## Methods

### Public methods

- [`check_test_config$check()`](#method-check_test_config-check)

- [`check_test_config$clone()`](#method-check_test_config-clone)

Inherited methods

- [`audit.base::logger$get_log()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-get_log)
- [`audit.base::logger$start_logger()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-start_logger)
- [`audit.base::logger$stop_logger()`](https://jumpingrivers.github.io/audit.base/html/logger.html#method-logger-stop_logger)
- [`audit.base::base_check$info()`](https://jumpingrivers.github.io/audit.base/html/base_check.html#method-base_check-info)
- [`audit.base::base_check$initialize()`](https://jumpingrivers.github.io/audit.base/html/base_check.html#method-base_check-initialize)

------------------------------------------------------------------------

### `check_test_config$check()`

Run Posit's own configuration check

#### Usage

    check_test_config$check(debug_level)

#### Arguments

- `debug_level`:

  See check() for details

------------------------------------------------------------------------

### `check_test_config$clone()`

The objects of this class are cloneable with this method.

#### Usage

    check_test_config$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
