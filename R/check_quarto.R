#' R6 classes
#'
#' Check classes
#' @export
check_quarto_pdf = R6::R6Class(
  "check_quarto_pdf",
  inherit = base_check,
  public = list(
    #' @description PDF rendering
    check = function() {
      private$checker(render_quarto(private$short))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Rendering",
    short = "pdf",
    group = "quarto"
  )
)

#' R6 classes
#'
#' Check classes
#' @export
check_quarto_html = R6::R6Class(
  "check_quarto_html",
  inherit = base_check,
  public = list(
    #' @description HTML rendering
    check = function() {
      private$checker(render_quarto(private$short))
      return(invisible(NULL))
    }
  ),
  private = list(
    context = "Rendering",
    short = "html",
    group = "quarto"
  )
)

#' Test rendering
#'
#' Simple test for rendering. In theory, the quarto
#' @param output_format File extension specifies the type to produce
render_quarto = function(output_format = c("pdf", "html")) {

  output_format = match.arg(output_format)
  qmd_filepath = system.file("extdata", "test-quarto-document.qmd",
                             package = "jrHealthCheckWorkbench", mustWork = TRUE)

  output_file = paste0("uat-notebook.", output_format)

  quarto::quarto_render(input = qmd_filepath,
                        output_format = output_format,
                        output_file = output_file, # Can't be a path
                        quiet = TRUE)
  doc = normalizePath(output_file)
  if (!(file.info(doc)$size > 100)) stop("Quarto file too small")
  return(invisible(TRUE))
}
