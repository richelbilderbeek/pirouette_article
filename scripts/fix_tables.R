# Fix tables by adding the labels if these are absent

# Copied from beautier::get_file_base_sans_ext
get_file_base_sans_ext <- function(filename) {
  basename(tools::file_path_sans_ext(filename))
}


tex_filenames <- list.files(
  "pirouette_example_30",
  recursive = TRUE,
  pattern = "latex",
  full.names = TRUE
)

testthat::expect_true(length(tex_filenames) > 2)

for (tex_filename in tex_filenames) {
  text <- readr::read_lines(tex_filename)

  # Only add label when it is absent
  if (length(stringr::str_which(text, "\\label\\{tab:.*\\}")) == 1) {
    message("File '", tex_filename, "' already had a label")
    next()
  }


  last_line <- tail(text, n = 1)
  label <- paste0(
    "  \\label{tab:", get_file_base_sans_ext(tex_filename),"}"
  )
  text[length(text)] <- label
  text <- c(text, last_line)
  readr::write_lines(x = text, path = tex_filename)
  message("File '", tex_filename, "' now has a label")
}

