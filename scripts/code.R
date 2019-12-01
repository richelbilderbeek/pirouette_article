remotes::install_github("richelbilderbeek/pirouette")
library(pirouette)
install_beast2()
install_beast2_pkg("NS")
phylogeny <- create_yule_tree(n_taxa = 6, crown_age = 10)
alignment_params <- create_alignment_params(
  sim_true_alignment_fun = get_sim_true_alignment_with_std_site_model_fun(
    mutation_rate = 0.1,
    site_model = create_jc69_site_model()
  ),
  root_sequence = create_blocked_dna(length = 1000)
)
generative_experiment <- create_experiment(
  inference_conditions = create_inference_conditions(
    model_type = "generative", 
    run_if = "always"
  ), 
  inference_model = create_inference_model(
    tree_prior = create_yule_tree_prior(),
    clock_model = create_strict_clock_model(), 
    site_model = create_jc69_site_model(),
    mcmc = create_mcmc()
  )
)
experiments <- list(generative_experiment)
error_measure_params <- create_error_measure_params(
  error_fun = get_nltt_error_fun(),
  burn_in_fraction = 0.1
)
pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  error_measure_params = error_measure_params
)
errors <- pir_run(
  phylogeny = phylogeny,
  pir_params = pir_params
)
pir_plot(errors)
candidate_experiments <- create_all_experiments(
  exclude_model = generative_experiment$inference_model
)
experiments <- c(
  list(generative_experiment),
  candidate_experiments
)
pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments
)
phylogeny  <- ape::read.tree(
  text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);"
)
twinning_params <- create_twinning_params(
  sim_twin_tree_fun = get_sim_bd_twin_tree_fun(),
  sim_twin_alignment_fun = get_sim_twin_alignment_with_std_site_model_fun()
)
pir_params <- create_pir_params(
  alignment_params = alignment_params,
  experiments = experiments,
  twinning_params = twinning_params
)
