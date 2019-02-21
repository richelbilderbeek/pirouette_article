# Code of example 2
#
# Works under Linux and MacOS only
library(pirouette)

phylogeny  <- ape::read.tree(text = "((A:4, B:4):1, (C:4, D:4) :1);")

alignment_params <- create_alignment_params(
  root_sequence = create_blocked_dna(length = 1000),
  mutation_rate = 0.1
)

experiments <- create_all_experiments()

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

