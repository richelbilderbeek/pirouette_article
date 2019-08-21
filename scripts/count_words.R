# Get the text
lines <- readLines("content.tex")
lines

n_lines <- length(lines)
n_lines

# Find beginning of code blocks
begin_lines <- grep(pattern = "begin\\{lstlisting\\}", x = lines)
lines[begin_lines]

# Find end of code blocks
end_lines <- grep(pattern = "end\\{lstlisting\\}", x = lines)
lines[end_lines]

testit::assert(length(begin_lines) == length(end_lines))

# Collect the line number of the blocks to be excluded
exclude_lines <- c()
for (i in seq_along(begin_lines)) {
  block_lines <- seq(begin_lines[i], end_lines[i])
  exclude_lines <- c(exclude_lines, block_lines)
}

# Obtain text without code blocks
text_without_code <- lines[ -exclude_lines ]

# Use texcount on file
filename <- tempfile()
writeLines(text = text_without_code, con = filename)
system2(command = "texcount", args = c("-total", filename))
