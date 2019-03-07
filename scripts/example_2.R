# Code of example 2
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

set.seed(314)

phylogeny  <- ape::read.tree(
  text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);"
)

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

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  theme_wsj() +
  ggsave("/home/richel/GitHubs/pirouette_article/figure_example_2.png")


testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
sink("/home/richel/GitHubs/pirouette_article/example_2_esses.latex")
xtable::xtable(esses, caption = "ESSes of example 2", label = "tab:esses_example_2", digits = 0)
sink()


df_evidences <- utils::read.csv(pir_params$evidence_filename)[, c(-1, -6)]
df_evidences$site_model_name <- plyr::revalue(df_evidences$site_model_name, c("JC69" = "JC", "TN93" = "TN"))
df_evidences$clock_model_name <- plyr::revalue(
  df_evidences$clock_model_name,
  c("strict" = "Strict", "relaxed_log_normal" = "RLN")
)
df_evidences$tree_prior_name <- plyr::revalue(
  df_evidences$tree_prior_name,
  c("yule" = "Yule", "birth_death" = "BD", "coalescent_constant_population" = "CCP", "coalescent_exp_population" = "CEP")
)
names(df_evidences) <- c("Site model", "Clock model", "Tree prior", "log(evidence)", "Weight")


sink("/home/richel/GitHubs/pirouette_article/example_2_evidences.latex")
xtable::xtable(
  df_evidences,
  caption = "Evidences of example 2", label = "tab:evidences_example_2", digits = 3
)
sink()

ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() +
  ggsave("/home/richel/GitHubs/pirouette_article/tree_unknown.png")
