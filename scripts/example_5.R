# Code of example 5
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article/")
example_no <- 5
set.seed(314)

# An infintely rare Yule tree
phylogeny  <- ape::read.tree(text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

# JC69, strict, Yule
generative_experiment <- create_experiment(
  inference_conditions = create_inference_conditions(
    model_type = "generative",
    run_if = "always",
    do_measure_evidence = TRUE
  )
  inference_model = create_inference_model(
    site_model = create_jc69_site_model(),
    clock_model = create_strict_clock_model(),
    tree_prior = create_yule_tree_prior()
  )
)
check_experiment(generative_experiment)

# All non-Yule tree priors
candidate_experiments <- create_all_experiments(
  exclude_model = generative_experiment$inference_model
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
  pir_params$experiments[[i]]$beast2_options$input_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_input_best.xml"))
  pir_params$experiments[[i]]$beast2_options$output_log_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.log"))
  pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.trees"))
  pir_params$experiments[[i]]$beast2_options$output_state_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.xml.state"))
  pir_params$experiments[[i]]$errors_filename <- file.path(root_folder, paste0("example_", example_no, "_error_best.csv"))
}
pir_params$experiments[[1]]$beast2_options$input_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_input_gen.xml"))
pir_params$experiments[[1]]$beast2_options$output_log_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_gen.log"))
pir_params$experiments[[1]]$beast2_options$output_trees_filenames <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_gen.trees"))
pir_params$experiments[[1]]$beast2_options$output_state_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_gen.xml.state"))
pir_params$experiments[[1]]$errors_filename <- file.path(root_folder, paste0("example_", example_no, "_error_gen.csv"))
pir_params$evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_true.csv"))
if (!is_one_na(pir_params$twinning_params)) {
  pir_params$twinning_params$twin_tree_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.tree"))
  pir_params$twinning_params$twin_alignment_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.fasta"))
  pir_params$twinning_params$twin_evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_twin.csv"))
}
################################################################################

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)


pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_errors.png")))

## Evidence

# Evidence, true
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

sink(file.path(root_folder, paste0("example_", example_no, "_evidence_true.latex")))
xtable::xtable(
  df_evidences,
  caption = "Evidences of example 5", label = "tab:evidences_example_5", digits = 3
)
sink()

# Evidence, twin
df_evidences <- utils::read.csv(pir_params$twinning_params$twin_evidence_filename)[, c(-1, -6)]
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

sink(file.path(root_folder, paste0("example_", example_no, "_evidence_twin.latex")))
xtable::xtable(
  df_evidences,
  caption = "Evidences of example 5, twin tree", label = "tab:evidences_example_5_twin", digits = 3
)
sink()

# ESSes
testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses_gen <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
esses_best <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[2]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
esses_twin_gen <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(to_twin_filename(pir_params$experiments[[1]]$beast2_options$output_log_filename)),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
esses_twin_best <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(to_twin_filename(pir_params$experiments[[2]]$beast2_options$output_log_filename)),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)

sink(file.path(root_folder, paste0("example_", example_no, "_esses_gen.latex")))
xtable::xtable(
  esses_gen,
  caption = paste0("ESSes of example ", example_no, " for generative model"),
  label = paste0("tab:esses_example_", example_no, "_gen"),
  digits = 0
)
sink()

sink(file.path(root_folder, paste0("example_", example_no, "_esses_best.latex")))
xtable::xtable(
  esses_best,
  caption = paste0("ESSes of example ", example_no, " for best candidate model"),
  label = paste0("tab:esses_example_", example_no, "_best"),
  digits = 0
)
sink()

sink(file.path(root_folder, paste0("example_", example_no, "_esses_twin_gen.latex")))
xtable::xtable(
  esses_twin_gen,
  caption = paste0("ESSes of example ", example_no, " for generative model, twin tree"),
  label = paste0("tab:esses_example_", example_no, "_twin_gen"),
  digits = 0
)
sink()

sink(file.path(root_folder, paste0("example_", example_no, "_esses_twin_best.latex")))
xtable::xtable(
  esses_twin_best,
  caption = paste0("ESSes of example ", example_no, " for best candidate model, twin tree"),
  label = paste0("tab:esses_example_", example_no, "_twin__best"),
  digits = 0
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

png(
  filename = file.path(root_folder, paste0("example_", example_no, "_true_posterior_best.png")),
  width = 1000, height = 800
)
babette::plot_densitree(
  phylos = tracerer::parse_beast_trees(pir_params$experiments[[2]]$beast2_options$output_trees_filenames),
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

  png(
    filename = file.path(root_folder, paste0("example_", example_no, "_twin_posterior_best.png")),
    width = 1000, height = 800
  )
  babette::plot_densitree(
    phylos = tracerer::parse_beast_trees(to_twin_filename(pir_params$experiments[[2]]$beast2_options$output_trees_filenames)),
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

# True, gen
df_errors_gen <- data.frame(error = read.csv(pir_params$experiments[[1]]$errors_filename)$x)

ggplot2::ggplot(
  df_errors_gen,
  aes(x = error)
) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_histogram_gen.png")))

ggplot2::ggplot(
  df_errors_gen,
  aes(x = "", y = error)
) + geom_violin() +
  xlab("") +
  scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_violin_gen.png")))

# True, best
df_errors_best <- data.frame(error = read.csv(pir_params$experiments[[2]]$errors_filename)$x)

ggplot2::ggplot(
  df_errors_best,
  aes(x = error)
) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_histogram_best.png")))

ggplot2::ggplot(
  df_errors_best,
  aes(x = "", y = error)
) + geom_violin() +
  xlab("") +
  scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_error_violin_best.png")))


if (!is_one_na(pir_params$twinning_params)) {
  df_errors_twin_gen <- data.frame(error = read.csv(to_twin_filename(pir_params$experiments[[1]]$errors_filename))$x)

  ggplot2::ggplot(
    df_errors_twin_gen,
    aes(x = error)
  ) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_histogram_gen.png")))

  ggplot2::ggplot(
    df_errors_twin_gen,
    aes(x = "", y = error)
  ) + geom_violin() +
    xlab("") +
    scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
    ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_violin_gen.png")))


  df_errors_twin_best <- data.frame(error = read.csv(to_twin_filename(pir_params$experiments[[2]]$errors_filename))$x)

  ggplot2::ggplot(
    df_errors_twin_best,
    aes(x = error)
  ) + geom_histogram(binwidth = 0.01) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_histogram_best.png")))

  ggplot2::ggplot(
    df_errors_twin_best,
    aes(x = "", y = error)
  ) + geom_violin() +
    xlab("") +
    scale_y_continuous(breaks = seq(0.0, 1.0, by = 0.02)) +
    ggsave(file.path(root_folder, paste0("example_", example_no, "_twin_error_violin_best.png")))

}

