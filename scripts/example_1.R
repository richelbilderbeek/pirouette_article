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

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  theme_wsj() +
  ggsave("/home/richel/GitHubs/pirouette_article/figure_example_1.png")
