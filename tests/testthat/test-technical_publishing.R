#qmd->HTML
MINIMUM_SIZE_BYTES_OF_RENDERED_HTML_DOCUMENT = 100
testthat::test_that("qmd->HTML using Quarto. Assumes that we have already installed the extra Quarto CLI tools", {
  testthat::expect_true(require(quarto))
  # After package is installed, files from the inst directory are copied to package directory. Then, this line accesses them:
  qmd_filepath = system.file("test_files", "notebook.qmd", package = "workbenchtest")
  # The tempfile() function doesn't create any files. But it gives us a string of a filepath we can use for storing a file for this session
  output_filepath = tempfile("notebook", fileext = ".html")
  quarto::quarto_render(qmd_filepath,
                        output_format = "html",
                        output_file = output_filepath)
  testthat::expect_true(file.exists(output_filepath))
  testthat::expect_true(file.info(output_filepath)$size > MINIMUM_SIZE_BYTES_OF_RENDERED_HTML_DOCUMENT)
  
})
# quarto_render("document.qmd") # defaults to html


# #TODO qmd->PDF (implicitly also tests for LaTeX)
# quarto_render("document.qmd", output_format = "pdf")
# test_that("qmd->HTML using Quarto", {

#TODO: Jupyter notebook: render using Quarto

#TODO: Jupyter notebook: built-in verify-installation check
