# Code of example 2, yet now all experiments are run
#
# Works under Linux and MacOS only
library(pirouette)
library(ggplot2)
library(ggthemes)

phylogeny  <- ape::read.tree(text = "((A:4, B:4):1, (C:4, D:4) :1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- create_all_experiments()

if (1 == 2) {
  # Run all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$run_if <- "always"
    experiments[[1]]$errors_filename <- paste0("errors_", i, ".csv")
  }
} else {
  experiments[[1]]$run_if <- "always"
  experiments[[2]]$run_if <- "always"
  experiments[[3]]$run_if <- "always"
  experiments[[1]]$errors_filename <- paste0("errors_1.csv")
  experiments[[2]]$errors_filename <- paste0("errors_2.csv")
  experiments[[3]]$errors_filename <- paste0("errors_3.csv")
}

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

pir_plot(errors) + theme(
  panel.background = element_rect(
    fill = "white",
    colour = "black"
  ),
  panel.grid.major = element_line(colour = "black"),
  panel.grid.minor = element_line(color = "black")

)

pir_plot(errors) + theme_wsj() +
  ggsave("/home/richel/GitHubs/pirouette_article/figure_example_all.png")
