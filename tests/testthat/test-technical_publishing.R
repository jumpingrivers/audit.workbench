MINIMUM_SIZE_BYTES_OF_RENDERED_HTML_DOCUMENT = 100
MINIMUM_SIZE_BYTES_OF_RENDERED_PDF_DOCUMENT = 100

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
# And then you might need to restart your computer
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
