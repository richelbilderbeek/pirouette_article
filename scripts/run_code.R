setwd("~/GitHubs/pirouette_article")
filename <- list.files(pattern = "content.tex", full.names = TRUE)

# Extract the code from the TeX file
text <- readLines(filename)
start_lines <- which(grepl(pattern = "begin.*lstlisting", x = text))
text[start_lines]
end_lines <- which(grepl(pattern = "end.*lstlisting", x = text))
text[end_lines]
testit::assert(length(start_lines) == length(end_lines))

code <- c()

# Extract the code, with LaTeX stuff
for (i in seq_along(start_lines)) {
  from <- start_lines[i] + 1
  to <- end_lines[i] - 1
  code <- c(code, text[seq(from, to)])
}
code

remove_lines <- which(grepl(pattern = "(]|  })", x = code))
code <- code[-remove_lines]
remove_lines <- which(grepl(pattern = "  (language|floatplacement|frame|label|caption) = .*", x = code))
code <- code[-remove_lines]
remove_lines <- which(grepl(pattern = "> .*", x = code))
code <- code[-remove_lines]
remove_lines <- which(
  grepl(
    pattern = "(resulting tree|Create a|generative model|Create the|that will|using explicit)",
    x = code
  )
)
code <- code[-remove_lines]
# Do not assume pirouette is on CRAN yet
remove_lines <- which(grepl(pattern = "install.packages", x = code))
code <- code[-remove_lines]
code

writeLines(text = code, con = "~/GitHubs/pirouette_article/scripts/code.R")

# Do so, because the script will install it
library(pirouette)
uninstall_beast2_pkg("NS")
uninstall_beast2()
source("~/GitHubs/pirouette_article/scripts/code.R")
