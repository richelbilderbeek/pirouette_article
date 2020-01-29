# Plot tree in article nicely
#
#
# From https://github.com/richelbilderbeek/pirouette_article/issues/76

phylogeny <- ape::read.tree(text = 
"(((t5:1.476758646,(t6:0.6204090342,t1:0.6204090342):0.8563496113):5.035377242,(t4:1.817321178,t3:1.817321178):4.69481471):3.487864113,t2:10);
"
)
cex <- 1.5
edge.width <- 2
x <- 0.3
y <- 1.38
lwd <- 2
label.offset <- 0.25
ape::plot.phylo(phylogeny, cex = cex, edge.width = edge.width, label.offset = label.offset)
ape::add.scale.bar(x = x, y = y, lwd = lwd, cex = cex)
desktop <- "C:/users/p274829/Desktop"
filename <- file.path(desktop, "figure_2.png")
grDevices::png(
  filename = filename,
  width = 1000, height = 800
)
ape::plot.phylo(phylogeny, cex = cex, edge.width = edge.width, label.offset = label.offset)
ape::add.scale.bar(x = x, y = y, lwd = lwd, cex = cex)
grDevices::dev.off()

