#TODO qmd->HTML
testthat::test_that("qmd->HTML using Quarto", {
  testthat::expect_true(require(quarto))
  qmd_filepath = system.file("test_files", "notebook.qmd", package = "workbenchtest")
  output_filepath = tempfile("notebook", fileext=".html")
  quarto::quarto_render(qmd_filepath, output_format = "html", output_file = output_filepath) # Put in inst subdirectory of package root
  testthat::expect_true(file.exists(output_filepath))
  testthat::expect_true(file.info(output_filepath)$size>100)
  
})
# quarto_render("document.qmd") # defaults to html


# #TODO qmd->PDF (implicitly also tests for LaTeX)
# quarto_render("document.qmd", output_format = "pdf")
# test_that("qmd->HTML using Quarto", {

#TODO: Jupyter notebook: render using Quarto

#TODO: Jupyter notebook: built-in verify-installation check
