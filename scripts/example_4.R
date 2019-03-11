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

################################################################################
# Settings to run on Peregrine cluster
################################################################################
pir_params$alignment_params$fasta_filename <- file.path(root_folder, paste0("example_", example_no, "_true.fasta"))
for (i in seq_along(pir_params$experiments)) {
  pir_params$experiments[[i]]$beast2_options$input_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_input.xml"))
  pir_params$experiments[[i]]$beast2_options$output_log_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output.log"))
  pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- file.path(root_folder, paste0("example_", example_no, "_beast2_output.trees"))
  pir_params$experiments[[i]]$beast2_options$output_state_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output.xml.state"))
  pir_params$experiments[[i]]$errors_filename <- file.path(root_folder, paste0("example_", example_no, "_error.csv"))
}
pir_params$evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_true.csv"))
if (!is_one_na(pir_params$twinning_params)) {
  twinning_params$twin_tree_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.tree"))
  twinning_params$twin_alignment_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.fasta"))
  twinning_params$twin_evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_twin.csv"))
}
################################################################################

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_errors.png")))

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

# Appendix figure
################################################################################
# trees
################################################################################

# True tree
ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_true_tree.png")))

# Twin tree
if (!is_one_na(pir_params$twinning_params)) {
  ggtree::ggtree(ape::read.tree(pir_params$twinning_params$twin_tree_filename)) + theme_tree2() + geom_tiplab() +
    ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_tree.png")))
}

################################################################################
# alignment
################################################################################


png(
  filename = file.path(root_folder, paste0("example_", example_no, "_true_alignment.png")),
  width = 800,
  height = 300
)
ape::image.DNAbin(
  ape::read.FASTA(file = pir_params$alignment_params$fasta_filename),
  grid = TRUE,
  show.bases = FALSE,
  legend = FALSE,
  cex.lab = 2.0,
  cex.axis = 2.0
)
dev.off()

if (!is_one_na(pir_params$twinning_params)) {
  png(
    filename = file.path(root_folder, paste0("example_", example_no, "_twin_alignment.png")),
    width = 800,
    height = 300
  )
  ape::image.DNAbin(
    ape::read.FASTA(file = pir_params$twinning_params$twin_alignment_filename),
    grid = TRUE,
    show.bases = FALSE,
    legend = FALSE,
    cex.lab = 2.0,
    cex.axis = 2.0
  )
  dev.off()
}
################################################################################
# posteriors
################################################################################

png(
  filename = file.path(root_folder, paste0("example_", example_no, "_true_posterior_gen.png")),
  width = 1000, height = 800
)
babette::plot_densitree(
  phylos = tracerer::parse_beast_trees(pir_params$experiments[[1]]$beast2_options$output_trees_filenames),
  alpha = 0.01,
  consensus = rev(LETTERS[1:6]),
  cex = 2.0,
  scaleX = TRUE,
  scale.bar = FALSE
)
dev.off()

if (!is_one_na(pir_params$twinning_params)) {
  png(
    filename = file.path(root_folder, paste0("example_", example_no, "_twin_posterior_gen.png")),
    width = 1000, height = 800
  )
  babette::plot_densitree(
    phylos = tracerer::parse_beast_trees(to_twin_filename(pir_params$experiments[[1]]$beast2_options$output_trees_filenames)),
    alpha = 0.01,
    consensus = rev(LETTERS[1:6]),
    cex = 2.0,
    scaleX = TRUE,
    scale.bar = FALSE
  )
  dev.off()
}

################################################################################
# histogram of errors
################################################################################

df_errors <- data.frame(error = read.csv(pir_params$experiments[[1]]$errors_filename)$x)

ggplot2::ggplot(
  df_errors,
  aes(x = error)
) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_histogram.png")))

ggplot2::ggplot(
  df_errors,
  aes(x = "", y = error)
) + geom_violin() +
  xlab("") +
  scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_violin.png")))

if (!is_one_na(pir_params$twinning_params)) {
  df_errors_twin <- data.frame(error = read.csv(to_twin_filename(pir_params$experiments[[1]]$errors_filename))$x)

  ggplot2::ggplot(
    df_errors_twin,
    aes(x = error)
  ) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_histogram.png")))

  ggplot2::ggplot(
    df_errors_twin,
    aes(x = "", y = error)
  ) + geom_violin() +
    xlab("") +
    scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
    ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_violin.png")))
}

