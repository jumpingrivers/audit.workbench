test_that("render_rmd and render_quarto keep their folder only at debug_level 2", {
  local_mocked_bindings(render = function(...) NULL, .package = "rmarkdown")
  local_mocked_bindings(quarto_render = function(...) NULL, .package = "quarto")
  src = withr::local_tempdir()
  renderers = list(rmd = render_rmd, quarto = render_quarto)
  for (name in names(renderers)) {
    tmp_dir = file.path(tempdir(), name)
    withr::defer(unlink(tmp_dir, recursive = TRUE))
    for (debug_level in 0:2) {
      renderers[[name]](src, debug_level = debug_level)
      expect_identical(dir.exists(tmp_dir), debug_level == 2L, label = paste(name, debug_level))
    }
  }
})
