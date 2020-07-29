# Plot tree in article nicely
# From https://github.com/richelbilderbeek/pirouette_article/issues/76
#
# Usage:
#
#   Rscript scripts/create_figure_2.R

newick_filename <- "pirouette_example_30/example_30/phylogeny.newick"

library(testthat)
expect_true(file.exists(newick_filename))

phylogeny <- ape::read.tree(file = newick_filename)
cex <- 1.5
edge.width <- 2
x <- 0.5
y <- 2.5
lwd <- 2
label.offset <- 0.25
ape::plot.phylo(phylogeny, cex = cex, edge.width = edge.width, label.offset = label.offset)
ape::add.scale.bar(x = x, y = y, lwd = lwd, cex = cex)
png_filename <- file.path("figure_2.png")
grDevices::png(
  filename = png_filename,
  width = 1000, height = 800
)
ape::plot.phylo(phylogeny, cex = cex, edge.width = edge.width, label.offset = label.offset)
ape::add.scale.bar(x = x, y = y, lwd = lwd, cex = cex)
grDevices::dev.off()

