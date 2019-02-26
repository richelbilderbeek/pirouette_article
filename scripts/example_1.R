# Code of example 1
#
# Works under Windows
library(pirouette)
library(ggplot2)
library(ggthemes)

phylogeny <- create_ideal_tree(n_taxa = 5, crown_age = 10)

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- list(create_experiment())

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) + theme_wsj() + ggsave("figure_example_1.png")
