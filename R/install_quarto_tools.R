#' Test rendering
#'
#' If you're getting errors saying tex isn't installed, try running
#' `tinytex::install_tinytex(force = TRUE)`
#' @param output_format File extension specifies the type to produce
render_quarto_document = function(output_format = c("pdf", "html")) {

  output_format = match.arg(output_format)
  qmd_filepath = system.file("extdata", "test-quarto-document.qmd",
                             package = "workbenchtest", mustWork = TRUE)

  # The tempfile() function doesn't create any files. But it gives us a string
  # of a file path we can use for storing a file for this session:
  output_filepath = tempfile("notebook", fileext = output_format)

  quarto::quarto_render(input = qmd_filepath,
                        output_format = output_format,
                        output_file = output_filepath,
                        quiet = TRUE)
  return(invisible(output_filepath))
}
