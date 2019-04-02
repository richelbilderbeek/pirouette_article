# Code of example 4
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article")
example_no <- 4
setwd(root_folder)
set.seed(314)

testit::assert(is_beast2_installed())

phylogeny  <- ape::read.tree(text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- create_all_experiments()
check_experiments(experiments)

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  twinning_params = create_twinning_params()
)

print("#######################################################################")
print("Settings to run on Peregrine cluster")
print("#######################################################################")
pir_params$alignment_params$fasta_filename <- file.path(root_folder, paste0("example_", example_no, "_true.fasta"))
for (i in seq_along(pir_params$experiments)) {
  pir_params$experiments[[i]]$beast2_options$input_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_input_best.xml"))
  pir_params$experiments[[i]]$beast2_options$output_log_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.log"))
  pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.trees"))
  pir_params$experiments[[i]]$beast2_options$output_state_filename <- file.path(root_folder, paste0("example_", example_no, "_beast2_output_best.xml.state"))
  pir_params$experiments[[i]]$errors_filename <- file.path(root_folder, paste0("example_", example_no, "_error_best.csv"))
}
pir_params$evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_true.csv"))
if (!is_one_na(pir_params$twinning_params)) {
  pir_params$twinning_params$twin_tree_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.tree"))
  pir_params$twinning_params$twin_alignment_filename <- file.path(root_folder, paste0("example_", example_no, "_twin.fasta"))
  pir_params$twinning_params$twin_evidence_filename <- file.path(root_folder, paste0("example_", example_no, "_evidence_twin.csv"))
}
print("#######################################################################")

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)


pir_plot(errors) +
  scale_y_continuous(breaks = seq(0.0, 0.11, by = 0.01), limits = c(0, 0.11)) +
  ggsave(file.path(root_folder, paste0("example_", example_no, "_errors.png")))

print("#######################################################################")
print("Evidence")
print("#######################################################################")

# Evidence, true
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

sink(file.path(root_folder, paste0("example_", example_no, "_evidence_true.latex")))
xtable::print.xtable(
  xtable::xtable(
    df_evidences,
    caption = "Evidences of example 5", label = "tab:evidences_example_5", digits = 3
  ),
  include.rownames = FALSE
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
  c(
    "yule" = "Yule",
    "birth_death" = "BD",
    "coalescent_bayesian_skyline" = "CBS",
    "coalescent_constant_population" = "CCP",
    "coalescent_exp_population" = "CEP"
  )
)
names(df_evidences) <- c("Site model", "Clock model", "Tree prior", "log(evidence)", "Weight")

sink(file.path(root_folder, paste0("example_", example_no, "_evidence_twin.latex")))
xtable::print.xtable(
  xtable::xtable(
    df_evidences,
    caption = "Evidences of example 5, twin tree", label = "tab:evidences_example_5_twin", digits = 3
  ),
  include.rownames = FALSE
)
sink()

print("#######################################################################")
print("ESSes")
print("#######################################################################")

esses_best <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[2]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)
esses_twin_best <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(to_twin_filename(pir_params$experiments[[2]]$beast2_options$output_log_filename)),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)

sink(file.path(root_folder, paste0("example_", example_no, "_esses_best.latex")))
xtable::print.xtable(
  xtable::xtable(
    esses_best,
    caption = paste0("ESSes of example ", example_no, " for best candidate model"),
    label = paste0("tab:esses_example_", example_no, "_best"),
    digits = 0
  ),
  include.rownames = FALSE
)
sink()


sink(file.path(root_folder, paste0("example_", example_no, "_esses_twin_best.latex")))
xtable::print.xtable(
  xtable::xtable(
    esses_twin_best,
    caption = paste0("ESSes of example ", example_no, " for best candidate model, twin tree"),
    label = paste0("tab:esses_example_", example_no, "_twin__best"),
    digits = 0
  ),
  include.rownames = FALSE
)
sink()

print("#######################################################################")
print("Appendix")
print("#######################################################################")
pir_to_pics(
  phylogeny = phylogeny,
  pir_params = pir_params,
  folder = root_folder
)
