# Code of example 2
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article")
example_no <- 2
example_folder <- file.path(root_folder, paste0("example_", example_no))
dir.create(example_folder, showWarnings = FALSE)
setwd(example_folder)
set.seed(314)

testit::assert(is_beast2_installed())

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

################################################################################
# Settings to run on Peregrine cluster
################################################################################
pir_params$alignment_params$fasta_filename <- file.path(example_folder, "true.fasta")
for (i in seq_along(pir_params$experiments)) {
  pir_params$experiments[[i]]$beast2_options$input_filename <- file.path(example_folder, "beast2_input.xml")
  pir_params$experiments[[i]]$beast2_options$output_log_filename <- file.path(example_folder, "beast2_output.log")
  pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- file.path(example_folder, "beast2_output.trees")
  pir_params$experiments[[i]]$beast2_options$output_state_filename <- file.path(example_folder, "beast2_output.xml.state")
  pir_params$experiments[[i]]$errors_filename <- file.path(example_folder, "error.csv")
}
pir_params$evidence_filename <- file.path(example_folder, "evidence_true.csv")
if (!is_one_na(pir_params$twinning_params)) {
  twinning_params$twin_tree_filename <- file.path(example_folder, "twin.tree")
  twinning_params$twin_alignment_filename <- file.path(example_folder, "twin.fasta")
  twinning_params$twin_evidence_filename <- file.path(example_folder, "evidence_twin.csv")
}
################################################################################

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  ggsave(file.path(example_folder, "errors.png"))


testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
sink(file.path(example_folder, "esses.latex"))
xtable::xtable(
  esses,
  caption = paste0("ESSes of example ", example_no),
  label = paste0("tab:esses_example_", example_no),
  digits = 0
)
sink()


df_evidences <- utils::read.csv(pir_params$evidence_filename)[, c(-1, -6)]
df_evidences$site_model_name <- plyr::revalue(df_evidences$site_model_name, c("JC69" = "JC", "TN93" = "TN"))
df_evidences$clock_model_name <- plyr::revalue(
  df_evidences$clock_model_name,
  c("strict" = "Strict", "relaxed_log_normal" = "RLN")
)
df_evidences$tree_prior_name <- plyr::revalue(
  df_evidences$tree_prior_name,
  c(
    "yule" = "Yule",
    "birth_death" = "BD",
    "coalescent_bayesian_skyline" = "CBS",
    "coalescent_constant_population" = "CCP",
    "coalescent_exp_population" = "CEP"
  )
)
names(df_evidences) <- c("Site model", "Clock model", "Tree prior", "log(evidence)", "Weight")


sink(file.path(example_folder, "evidences.latex"))
xtable::print.xtable(
  xtable::xtable(
    df_evidences,
    caption = "Evidences of example 2", label = "tab:evidences_example_2", digits = 3
  ),
  include.rownames = FALSE
)
sink()

ggtree::ggtree(phylogeny) + theme_tree2() + geom_tiplab() +
  ggsave(file.path(example_folder, "tree_unknown.png"))

print("#######################################################################")
print("Appendix")
print("#######################################################################")
pir_to_pics(
  phylogeny = phylogeny,
  pir_params = pir_params,
  folder = example_folder
)
