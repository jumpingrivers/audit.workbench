# Create test config

This function creates an example config. By default all tests are TRUE.
Some RSC servers intentionally won't have some features implemented.

## Usage

``` r
create_config(dir = ".", default = TRUE, type = c("merge", "force", "error"))
```

## Arguments

- dir:

  Directory of the config file

- default:

  Default value for if a test should run (logical)

- type:

  Merge type, see details

## Details

If a test is missing from the config file, it is assume to be TRUE.
Therefore, the config file can be quite short and just list exceptions.
If the config file is missing, then all tests are carried out.

When merging configs, we either \* merge the new with existing \* force:
overwrite existing file \* error: if a config file exists, raise an
error
