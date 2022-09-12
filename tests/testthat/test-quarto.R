quarto_doc_tests = function(doc) {
  #Check that the rendered document exists:
  testthat::expect_true(file.exists(doc))

  #Check that the rendered document is greater than a certain number of bytes:
  testthat::expect_true(file.info(doc)$size > 100)
}

testthat::test_that(
  "Testing quarto rendering",
  {
    testthat::skip_on_ci()
    lapply(c("html", "pdf"),
           function(type) {
             doc = render_quarto_document(output_format = "html")
             quarto_doc_tests(doc)
           })
  })
