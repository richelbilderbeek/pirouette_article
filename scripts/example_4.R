# Code of example 4
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)

set.seed(314)

phylogeny <- create_ideal_tree(n_taxa = 5, crown_age = 10)

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

# JC69, strict, Yule
generative_experiment <- create_experiment(
  model_type = "generative",
  run_if = "always",
  do_measure_evidence = TRUE
)
check_experiment(generative_experiment)

# All non-Yule tree priors
candidate_experiments <- create_all_experiments(
  site_models = list(create_jc69_site_model()),
  clock_models = list(create_strict_clock_model()),
  tree_priors = list(create_bd_tree_prior(), create_ccp_tree_prior(), create_cep_tree_prior())
)
check_experiments(candidate_experiments)

experiments <- c(list(generative_experiment), candidate_experiments)
check_experiments(experiments)

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  twinning_params = create_twinning_params()
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  theme_wsj() +
  ggsave("/home/richel/GitHubs/pirouette_article/figure_example_4.png")
