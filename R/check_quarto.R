#' @rawNamespace export(check_quarto_beamer)
#' @rawNamespace export(check_quarto_docx)
#' @rawNamespace export(check_quarto_html)
#' @rawNamespace export(check_quarto_observable)
#' @rawNamespace export(check_quarto_pdf)
#' @rawNamespace export(check_quarto_rsvg_convert)
NULL
types = c("beamer", "docx", "html", "observable", "pdf", "rsvg_convert")
longs = paste0("Checking that quarto can render a document (type: `", types, "`)")
longs[6] = "Checking that quarto can render SVG image within a PDF"

for (i in seq_along(types)) {
  assign(
    paste0("check_quarto_", types[i]),
    R6::R6Class(
      paste0("check_quarto_", types[i]),
      inherit = audit.base::base_check,
      public = list(
        check = function(debug_level) {
          quarto_dir = system.file("extdata", private$group, private$short,
                                   package = "audit.base", mustWork = TRUE)
          private$checker(
            render_quarto(quarto_dir, debug_level = debug_level))

          return(invisible(NULL))
        }
      ),
      private = list(
        context = paste("Rendering", types[i]),
        short = types[i],
        group = "render_quarto",
        long = longs[i]
      )
    )
  )
}

render_quarto = function(quarto_dir, debug_level) {
  suppress = audit.base::get_suppress(debug_level) #nolint

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
