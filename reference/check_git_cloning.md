# R6 classes

Check classes

## Super classes

[`audit.base::logger`](https://rdrr.io/pkg/audit.base/man/logger.html)
-\>
[`audit.base::base_check`](https://rdrr.io/pkg/audit.base/man/base_check.html)
-\> `check_git_cloning`

## Methods

### Public methods

- [`check_git_cloning$check()`](#method-check_git_cloning-check)

- [`check_git_cloning$clone()`](#method-check_git_cloning-clone)

Inherited methods

- [`audit.base::logger$get_log()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-get_log)
- [`audit.base::logger$start_logger()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-start_logger)
- [`audit.base::logger$stop_logger()`](https://rdrr.io/pkg/audit.base/man/logger.html#method-stop_logger)
- [`audit.base::base_check$info()`](https://rdrr.io/pkg/audit.base/man/base_check.html#method-info)
- [`audit.base::base_check$initialize()`](https://rdrr.io/pkg/audit.base/man/base_check.html#method-initialize)

------------------------------------------------------------------------

### `check_git_cloning$check()`

Checking that we can access and clone from github.com

#### Usage

    check_git_cloning$check(debug_level)

#### Arguments

- `debug_level`:

  See \`check()\` for details

------------------------------------------------------------------------

### `check_git_cloning$clone()`

The objects of this class are cloneable with this method.

#### Usage

    check_git_cloning$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
