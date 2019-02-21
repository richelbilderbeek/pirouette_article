# Code of example 1
#
# Works under Windows
library(pirouette)

#phylogeny <- create_ideal_tree(n_taxa = 5, crown_age = 10)
# STUB
phylogeny <- create_stunning_tree(n_taxa = 5, t_0 = 10)

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- list(create_experiment())

pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
)

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)


library(ggplot2)

pir_plot(errors) + theme(
  panel.background = element_rect(
    fill = "white",
    colour = "black"
  ),
  panel.grid.major = element_line(colour = "black"),
  panel.grid.minor = element_line(color = "black")

)

library(ggthemes)
pir_plot(errors) + theme_wsj() + ggsave("/home/richel/GitHubs/pirouette_article/figure_2.png")

pir_plot(errors) + theme_tufte()
pir_plot(errors) + theme_economist()
pir_plot(errors) + theme_economist_white()
pir_plot(errors) + theme_excel() # The irony!
pir_plot(errors) + theme_few() # Like
pir_plot(errors) + theme_fivethirtyeight()

