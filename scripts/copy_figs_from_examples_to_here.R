# Copy files from the pirouette example to this folder
#
# [from_root/]pirouette_example_9/example_9_314/errors.png
#                          ->
# [to_root/]pirouette_example_9/example_9_314/errors.png
#
# Usage:
#
#  Rscript scripts/copy_figs_from_examples_to_here.R
#

from_root <- "~/GitHubs"
to_root <- "~/GitHubs/pirouette_article"

# Rough search
files <- list.files(path = from_root, pattern = "errors.png", recursive = TRUE)
files

# Only pirouette examples
files <- stringr::str_match(string = files, pattern = ".*pirouette_example_.*")
files

# Remove NA's
files <- as.character(na.omit(files[, 1]))
files

from_files <- file.path(from_root, files)
to_files <- file.path(to_root, files)
for (dir_name in dirname(to_files)) dir.create(dir_name, recursive = TRUE)
file.copy(from_files, to_files, overwrite = TRUE)
