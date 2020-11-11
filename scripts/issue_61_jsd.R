# Test the Jensen-Shannon distance
library(RPANDA)

# reprex
tree_1 <- ape::read.tree(text = "(t4:0.2969950169,((t1:0.06457926296,t2:0.06457926296):0.0824593208,(t5:0.1346457881,t3:0.1346457881):0.01239279566):0.1499564331);")
tree_2 <- ape::read.tree(text = "((t2:0.07486817339,t5:0.07486817339):0.8541436693,(t1:0.08605484639,(t4:0.06379297152,t3:0.06379297152):0.02226187487):0.8429569963);")
trees <- c(tree_1, tree_2)
jsd <- RPANDA::JSDtree(phylo = trees)[1, 2]
testthat::expect_false(is.nan(jsd))

message(ape::write.tree(trees[1]))
message(ape::write.tree(trees[2]))

# Plot
png("~/plot.png")
par(mfrow = c(1,2))
ape::plot.phylo(trees[[1]])
ape::add.scale.bar()
ape::plot.phylo(trees[[2]])
ape::add.scale.bar()
dev.off()

# Brute force search
for (i in seq(1, 100000)) {
  set.seed(i)
  trees <- c(
    ape::rcoal(n = 5),
    ape::rcoal(n = 5)
  )
  jsd <- RPANDA::JSDtree(phylo = trees)[1, 2]
  if (is.nan(jsd)) {
    message(i)
    message(ape::write.tree(trees[1]))
    message(ape::write.tree(trees[2]))
    stop("ERROR")
  }
  #if (jsd > max_jsd) {
  #  max_jsd <- jsd
  #  babette::plot_densitree(trees)
  #}
}

