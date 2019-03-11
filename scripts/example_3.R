# Code of example 3
#
# Works under Windows
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article/")
example_no <- 3
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

sink("/home/richel/GitHubs/pirouette_article/example_3_esses.latex")
xtable::xtable(esses, caption = "ESSes of example 3", label = "tab:esses_example_3", digits = 0)
sink()


# Appendix figure
################################################################################
# trees
################################################################################

# True tree
ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() +
  ggtitle(paste0("Example ", example_no, "'s faked Yule tree, #192")) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_true_tree.png")))

# Twin tree
if (!is_one_na(pir_params$twinning_params)) {
  ggtree::ggtree(ape::read.tree(pir_params$twinning_params$twin_tree_filename)) + theme_tree2() + geom_tiplab() +
    ggtitle(paste0("Example ", example_no, "'s faked Yule tree, #192")) +
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
