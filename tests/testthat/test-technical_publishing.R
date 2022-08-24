MINIMUM_SIZE_BYTES_OF_RENDERED_HTML_DOCUMENT = 100
MINIMUM_SIZE_BYTES_OF_RENDERED_PDF_DOCUMENT = 100

# Function which we will move into R/ in this package later:
render_example_quarto_document = function(output_file_extension,
                                          output_format,
                                          expected_minimum_file_size) {
  # Asserting that output_file_extension is something like ".html",
  # and that the output_format is something like "html"
  stopifnot(sub(".", "", output_file_extension) == output_format)
  # Test that we're able to load the quarto package:
  testthat::expect_true(require(quarto))
  # After package is installed, files from the inst directory are copied to the
  # package's installation directory. Then, this line accesses them:
  qmd_filepath = system.file("test_files", "notebook.qmd", package = "workbenchtest")
  # The tempfile() function doesn't create any files. But it gives us a string
  # of a filepath we can use for storing a file for this session:
  output_filepath = tempfile("notebook", fileext = output_file_extension)
  # If we have accidentially coded the input file to be the same as the output
  # file, we should stop:
  stopifnot(qmd_filepath != output_filepath)
  # Render the Quarto document, in the format specified in the output_format
  # argument to our function:
  withr::with_file(output_filepath, {
    quarto::quarto_render(input = qmd_filepath,
                          output_format = output_format,
                          output_file = output_filepath)
    #Check that the rendered document exists:
    testthat::expect_true(file.exists(output_filepath))
    #Check that the rendered document is greater than a certain number of bytes:
    testthat::expect_true(file.info(output_filepath)$size > expected_minimum_file_size)
    # print(paste("Output filepath", output_filepath))
  })
}

# qmd->HTML
testthat::test_that(
  "qmd->HTML using Quarto. Assumes that we have already installed the extra Quarto CLI tools",
  {
    render_example_quarto_document(
      output_file_extension = ".html",
      output_format = "html",
      expected_minimum_file_size = MINIMUM_SIZE_BYTES_OF_RENDERED_HTML_DOCUMENT
    )
  }
)

# qmd->PDF
#If you're getting errors saying tex isn't installed, try:
# install.packages('tinytex', type='source')
# tinytex::install_tinytex()
testthat::test_that(
  "qmd->PDF (via LaTeX) using Quarto. Assumes that we have already installed the extra Quarto CLI tools",
  {
    render_example_quarto_document(
      output_file_extension = ".pdf",
      output_format = "pdf",
      expected_minimum_file_size = MINIMUM_SIZE_BYTES_OF_RENDERED_PDF_DOCUMENT
    )
  }
)

#TODO: Jupyter notebook: render using Quarto

#TODO: Jupyter notebook: built-in verify-installation check
