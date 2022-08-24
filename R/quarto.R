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