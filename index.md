# audit.workbench

This checks that Posit Workbench has been correctly installed.

## Installation

To install the R package, run

``` r

install.packages(
  "audit.workbench",
  repos = c('https://jumpingrivers.r-universe.dev', options("repos")$repos)
)
```

## Usage

Running the test is straightforward

``` r

library("audit.workbench")
check(server = "https://www.server.name/")
```

## Rendering the report

Save the output of
[`check()`](https://jumpingrivers.github.io/audit.workbench/reference/check.md),
then render the Quarto report that comes with the package. The report
needs {gt} and {gtExtras}, so install those first.

``` r

out = check(server = "https://www.server.name/")
saveRDS(out, "auditworkbench.rds")

install.packages(c("gt", "gtExtras"))
report = system.file("extdata", "report", "report.qmd", package = "audit.workbench")
file.copy(report, ".")
quarto::quarto_render(
  "report.qmd",
  execute_params = list(input = normalizePath("auditworkbench.rds"))
)
```
