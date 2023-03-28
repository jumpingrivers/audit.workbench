#' @rawNamespace export(check_quarto_beamer)
#' @rawNamespace export(check_quarto_docx)
#' @rawNamespace export(check_quarto_html)
#' @rawNamespace export(check_quarto_observable)
#' @rawNamespace export(check_quarto_pdf)
NULL
types = c("beamer", "docx", "html", "observable", "pdf")
for (type in types) {

  assign(
    paste0("check_quarto_", type),
    R6::R6Class(
      paste0("check_quarto_", type),
      inherit = uatBase::base_check,
      public = list(
        check = function(debug_level) {
          quarto_dir = system.file("extdata", private$group, private$short,
                                   package = "uatBase", mustWork = TRUE)
          private$checker(
            render_quarto(quarto_dir, debug_level = debug_level))

          return(invisible(NULL))
        }
      ),
      private = list(
        context = paste("Rendering", type),
        short = type,
        group = "render_quarto"
      )
    )
  )
}

render_quarto = function(quarto_dir, debug_level) {
  suppress = uatBase::get_suppress(debug_level) #nolint

  tmp_dir = file.path(tempdir(), "quarto")
  on.exit({if (fs::dir_exists(tmp_dir)) fs::dir_delete(tmp_dir)}) #nolint
  dir.create(tmp_dir, showWarnings = FALSE)
  lapply(list.files(quarto_dir, full.names = TRUE),
         function(f) file.copy(f, tmp_dir))

  qmd_filepath = file.path(tmp_dir, "index.qmd")
  quarto::quarto_render(input = qmd_filepath,
                        execute_dir = tmp_dir,
                        quiet = (debug_level == 0),
                        cache = FALSE,
                        as_job = FALSE
  )
  return(invisible(TRUE))
}