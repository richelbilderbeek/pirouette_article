# Code of example 2
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)

phylogeny  <- ape::read.tree(text = "((A:4, B:4):1, (C:4, D:4) :1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- create_all_experiments()

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) + theme(
  panel.background = element_rect(
    fill = "white",
    colour = "black"
  ),
  panel.grid.major = element_line(colour = "black"),
  panel.grid.minor = element_line(color = "black")

)

pir_plot(errors) + theme_wsj() + ggsave("figure_example_2.png")
