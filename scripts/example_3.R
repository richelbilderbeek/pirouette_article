# Code of example 3
#
# Works under Windows
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

set.seed(314)

phylogeny  <- ape::read.tree(text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- list(create_experiment())

twinning_params <- create_twinning_params()

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  twinning_params = twinning_params
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  theme_wsj() +
  ggsave("/home/richel/GitHubs/pirouette_article/figure_example_3.png")

testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)

sink("/home/richel/GitHubs/pirouette_article/example_3_esses.latex")
xtable::xtable(esses, caption = "ESSes of example 3", label = "tab:esses_example_3", digits = 0)
sink()
