# Copy files from the pirouette example to this folder
#
# [from_root/]pirouette_example_9/example_9_314/errors.png
#                          ->
# [to_root/]pirouette_example_9/example_9_314/errors.png
#
# Usage, from any folder:
#
#  Rscript copy_figs_from_examples_to_here.R
#

from_root <- "~/GitHubs"
to_root <- "~/GitHubs/pirouette_article"

# Rough search
png_and_latex_files <- list.files(
  path = from_root,
  pattern = "*.(png|latex)",
  recursive = TRUE
)

# Only pirouette examples
files <- stringr::str_subset(
  string = png_and_latex_files,
  pattern = ".*pirouette_example_.*(likilihoods|true|twin|errors|esses).*(png|latex)$"
)

files <- stringr::str_subset(
  string = files,
  pattern = "(pirouette_article|thesis)",
  negate = TRUE
)

from_files <- file.path(from_root, files)
to_files <- file.path(to_root, files)
for (dir_name in dirname(to_files)) {
  dir.create(dir_name, recursive = TRUE, showWarnings = FALSE)
}
file.copy(from_files, to_files, overwrite = TRUE)
