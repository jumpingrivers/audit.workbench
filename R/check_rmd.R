#' @rawNamespace export(check_rmd_word)
#' @rawNamespace export(check_rmd_html)
#' @rawNamespace export(check_rmd_pdf)
#' @name check_rmd
#' @title R6 Quarto checks
#' @rdname check_rmd_word
#' @description
#' A short description...
#'
#' @aliases check_rmd_word check_rmd_html check_rmd_pdf
types = c("word", "html", "pdf")
for (type in types) {

  assign(paste0("check_rmd_", type), R6::R6Class(
    paste0("check_rmd_", type),
    inherit = uatBase::base_check,
    public = list(
      check = function(debug_level) {
        rmd_dir = system.file("extdata", private$group, private$short,
                              package = "uatBase", mustWork = TRUE)
        private$checker(
          render_rmd(rmd_dir, debug_level = debug_level))

        return(invisible(NULL))
      }
    ),
    private = list(
      context = paste("Rendering", type),
      short = type,
      group = "render_rmd"
    )
  ))

}

render_rmd = function(rmd_dir, debug_level) {
  tmp_dir = file.path(tempdir(), "rmd")
  on.exit({if (fs::dir_exists(tmp_dir)) fs::dir_delete(tmp_dir)}) #nolint

  dir.create(tmp_dir, showWarnings = FALSE)
  lapply(list.files(rmd_dir, full.names = TRUE),
         function(f) file.copy(f, tmp_dir))

  rmarkdown::render(file.path(tmp_dir, "index.Rmd"),
                    quiet = (debug_level == 0)
                    )
  return(invisible(TRUE))
}
