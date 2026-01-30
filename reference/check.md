# Run UAT Checks

This functions runs all UAT tests. To skip tests, set check to \`no\` in
the config yaml file. See \`create_config()\`

## Usage

``` r
check(server, dir = ".", debug_level = 0:2)
```

## Arguments

- server:

  Posit Workbench server. If NULL, use the ENV variable WORKBENCH_SERVER

- dir:

  directory location of the the config file

- debug_level:

  Integer, 0 to 2.

## Details

Debug level description \* 0: clean-up all files; suppress all noise \*
1: clean-up all files, but display build steps \* 2: No clean-up and
display build steps
