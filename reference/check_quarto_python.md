# R6 classes

Check classes

## Super classes

[`audit.base::logger`](https://rdrr.io/pkg/audit.base/man/logger.html)
-\>
[`audit.base::base_check`](https://rdrr.io/pkg/audit.base/man/base_check.html)
-\> `check_quarto_python`

## Methods

### Public methods

- [`check_quarto_python$check()`](#method-check_quarto_python-check)

- [`check_quarto_python$clone()`](#method-check_quarto_python-clone)

Inherited methods

- [`audit.base::logger$get_log()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-get_log)
- [`audit.base::logger$start_logger()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-start_logger)
- [`audit.base::logger$stop_logger()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-stop_logger)
- [`audit.base::base_check$info()`](https://rdrr.io/pkg/audit.base/man/base_check.html#method-info)
- [`audit.base::base_check$initialize()`](https://rdrr.io/pkg/audit.base/man/base_check.html#method-initialize)

------------------------------------------------------------------------

### `check_quarto_python$check()`

Check that Quarto can render a document with Python

#### Usage

    check_quarto_python$check(debug_level)

#### Arguments

- `debug_level`:

  See check() for details

------------------------------------------------------------------------

### `check_quarto_python$clone()`

The objects of this class are cloneable with this method.

#### Usage

    check_quarto_python$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
