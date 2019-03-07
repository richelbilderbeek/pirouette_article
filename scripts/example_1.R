# Code of example 1
#
# Works under Windows
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article/")
example_no <- 1
set.seed(314)

# Should run one day, https://github.com/richelbilderbeek/pirouette/issues/192
#phylogeny <- create_yule_tree(n_taxa = 6, crown_age = 10)
phylogeny  <- ape::read.tree(
  text = "(((((A:2, B:2):2, C:4):2, D:6):2, E:8):2, F:10);"
)

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- list(create_experiment())

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
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
sink("/home/richel/GitHubs/pirouette_article/example_1_esses.latex")
xtable::xtable(esses, caption = "ESSes of example 1", label = "tab:esses_example_1", digits = 0)
sink()

ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() + ggtitle("Faked Yule tree, #192") +
  ggsave("/home/richel/GitHubs/pirouette_article/tree_yule.png")

# Appendix figure
################################################################################
# trees
################################################################################

# True tree
ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() +
  ggtitle(paste0("Example ", example_no, "'s faked Yule tree, #192")) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_true_tree.png")))

# Twin tree
if (!is.na(pir_params$twinning_params)) {
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

if (!is.na(pir_params$twinning_params)) {
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

if (!is.na(pir_params$twinning_params)) {
  png(
    filename = file.path(root_folder, paste0("example_", example_no, "_twin_posterior_gen.png")),
    width = 1000, height = 800
  )
  babette::plot_densitree(
    phylos = tracerer::parse_beast_trees(to_twin_filename(pir_params$experiments[[1]]$beast2_options$output_trees_filenames)),
    alpha = 0.01,
    consensus = as.character(c(1:4)),
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

if (!is.na(pir_params$twinning_params)) {
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
