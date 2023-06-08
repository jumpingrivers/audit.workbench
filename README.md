
<!-- README.md is generated from README.Rmd. Please edit that file -->

# audit.connect

<!-- badges: start -->

[![R-CMD-check](https://github.com/jumpingrivers/audit.workbench/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jumpingrivers/audit.workbench/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This checks that Posit Workbench has been correctly installed.

## Installation

To install the R package, run

``` r
remotes::install_github("github/audit.workbench")
```

## Usage

Running the test is straightforward

``` r
library("audit.workbench")
check(server = "https://www.server.name/")
```
