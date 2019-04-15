# Code of example 3
#
# Works under Windows
library(pirouette)
library(ggplot2)
library(ggtree)

root_folder <- path.expand("~/GitHubs/pirouette_article")
example_no <- 3
example_folder <- file.path(root_folder, paste0("example_", example_no))
dir.create(example_folder, showWarnings = FALSE)
setwd(example_folder)
set.seed(314)

testit::assert(is_beast2_installed())

phylogeny  <- ape::read.tree(text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- list(create_gen_experiment())

# Testing
if (1 == 2) {
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mcmc <- create_mcmc(chain_length = 10000, store_every = 1000)
    experiments[[i]]$est_evidence_mcmc <- create_mcmc_nested_sampling(
      chain_length = 10000,
      store_every = 1000,
      epsilon = 100.0
    )
  }
}

twinning_params <- create_twinning_params(
  twin_model = "birth_death",
  method = "random_tree"
)

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  twinning_params = twinning_params
)

print("#######################################################################")
print("Settings to run on Peregrine cluster")
print("#######################################################################")
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
  pir_params$twinning_params$twin_tree_filename <- file.path(example_folder, "twin.tree")
  pir_params$twinning_params$twin_alignment_filename <- file.path(example_folder, "twin.fasta")
  pir_params$twinning_params$twin_evidence_filename <- file.path(example_folder, "evidence_twin.csv")
}
rm_pir_param_files(pir_params)
print("#######################################################################")

Sys.time()
# 11:24:52
errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)
Sys.time()

if (1 == 2) {
  errors <- utils::read.csv(
    file = file.path(example_folder, "errors.csv")
  )
  check_pir_out(errors)
  pir_plot(pir_out = errors)
}

utils::write.csv(
  x = errors,
  file = file.path(example_folder, "errors.csv"),
  row.names = FALSE
)

pir_plot(errors) +
  ggsave(file.path(example_folder, "errors.png"))

testit::assert(pir_params$experiments[[1]]$inference_model$mcmc$store_every != -1)
esses <- tracerer::calc_esses(
  traces = tracerer::parse_beast_log(pir_params$experiments[[1]]$beast2_options$output_log_filename),
  sample_interval = pir_params$experiments[[1]]$inference_model$mcmc$store_every
)

print("#######################################################################")
print("ESSes")
print("#######################################################################")
sink(file.path(example_folder, "esses.latex"))
xtable::print.xtable(
  xtable::xtable(
    esses,
    caption = paste0("ESSes of example ", example_no),
    label = paste0("tab:esses_example_", example_no),
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
  folder = example_folder
)
