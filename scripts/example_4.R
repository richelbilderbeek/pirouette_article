# Code of example 4
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article/")
example_no <- 4
set.seed(314)

phylogeny  <- ape::read.tree(text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);")
# phylogeny <- create_ideal_tree(n_taxa = 5, crown_age = 10)

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





testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
sink("/home/richel/GitHubs/pirouette_article/example_4_esses.latex")
xtable::xtable(esses, caption = "ESSes of example 4", label = "tab:esses_example_4", digits = 0)
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


sink("/home/richel/GitHubs/pirouette_article/example_4_evidences.latex")
xtable::xtable(
  df_evidences,
  caption = "Evidences of example 4", label = "tab:evidences_example_4", digits = 3
)
sink()


