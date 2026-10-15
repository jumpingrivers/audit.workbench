#' R6 classes
#'
#' Check classes
#' @export
check_reticulate_r_versions = R6::R6Class(
  "check_reticulate_r_versions",
  inherit = audit.base::base_check,
  public = list(
    #' @description Check reticulate in every installed R version
    #' @param debug_level See check() for details
    check = function(debug_level) {
      private$checker(testing_reticulate_r_versions(), debug_level)
      invisible(NULL)
    }
  ),
  private = list(
    context = "Checking reticulate in every R version",
    short = "reticulate_r_versions",
    group = "python",
    long = "Checking that every R version in /opt/R has {reticulate}, and that RETICULATE_PYTHON
    points to a Python executable"
  )
)

testing_reticulate_r_versions = function(root_dir = "/opt/R") {
  rscripts = Sys.glob(file.path(root_dir, "*", "bin", "Rscript"))
  # Skip links such as /opt/R/current, which repeat a numbered version
  rscripts = rscripts[grepl("^[0-9]+\\.[0-9]+", basename(dirname(dirname(rscripts))))]
  if (length(rscripts) == 0L) {
    cli::cli_abort("No R installations found in {.path {root_dir}}")
  }
  problems = unlist(lapply(rscripts, reticulate_problems))
  if (length(problems) > 0L) {
    names(problems) = rep("x", length(problems))
    cli::cli_abort(c("reticulate isn't set up in every R version", problems))
  }
  invisible(TRUE)
}

# Runs each R without --vanilla, so its Renviron.site and Rprofile.site apply
reticulate_problems = function(rscript) {
  r_version = basename(dirname(dirname(rscript)))
  # Tag the result, as Rprofile.site can print its own lines
  code = paste0(
    'cat("\\nRETICULATE_CHECK", requireNamespace("reticulate", quietly = TRUE),',
    ' Sys.getenv("RETICULATE_PYTHON"), sep = "\\t")'
  )
  # Drop the calling R's settings, such as R_HOME and R_LIBS_USER, so each R
  # reads its own. RETICULATE_PYTHON goes too, or it would hide the R's own value.
  env = Sys.getenv()
  env = env[!grepl("^R_|^RETICULATE_PYTHON$", names(env))]
  res = processx::run(rscript, c("-e", code), env = env, error_on_status = FALSE, timeout = 60)
  if (res$status != 0L) {
    return(glue::glue("R {r_version}: Rscript failed to run"))
  }
  lines = strsplit(res$stdout, "\n")[[1]]
  tagged = grep("^RETICULATE_CHECK\t", lines, value = TRUE)
  if (length(tagged) == 0L) {
    return(glue::glue("R {r_version}: couldn't read the result from Rscript"))
  }
  result = strsplit(tagged[1], "\t")[[1]]
  has_reticulate = identical(result[2], "TRUE")
  python = if (length(result) >= 3L) result[3] else ""
  problems = character(0)
  if (!has_reticulate) {
    problems = c(problems, glue::glue("R {r_version}: reticulate isn't installed"))
  }
  if (!nzchar(python)) {
    problems = c(problems, glue::glue("R {r_version}: RETICULATE_PYTHON isn't set"))
  } else if (!file.exists(python) || file.access(python, 1) != 0L) {
    problems = c(
      problems,
      glue::glue("R {r_version}: RETICULATE_PYTHON is {python}, which isn't an executable file")
    )
  }
  problems
}
