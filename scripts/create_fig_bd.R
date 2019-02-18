#' Estimates best lambda for a given n_taxa and n_0 and then
#'   calculates likelihood of a tree, given its branching times
#' @inheritParams default_params_doc
#' @author Giovanni Laudanno
#' @return the likelihood
#' @noRd
calc_likelihood <- function(
    brts,
    t_0 = 10,
    n_taxa = 5,
    n_0 = 2
  ) {
  cond_1 <- (length(brts) != length(unique(brts)))
  cond_2 <- (length(brts) != (n_taxa - n_0))
  cond_3 <- (any(brts < 0))
  cond_4 <- (any(brts > t_0))
  if (cond_1 | cond_2 | cond_3 | cond_4) {
    loglik <- -Inf
  } else {
    lambda <- (log(n_taxa) - log(n_0) ) / t_0
    mu <- 0
    r <- -(lambda - mu)
    lik <- (1 - exp(2 * r * (t_0 - brts[1]))) *
      (1 - exp(3 * r * (brts[1] - brts[2]))) *
      (1 - exp(4 * r * (brts[2] - brts[3]))) *
      (1 - exp(5 * r * brts[3]))
    loglik <- log(lik)
  }
  out <- -loglik
  return(out)
}

#' Create figure bd for pirouette article
#' @inheritParams default_params_doc
#' @return a ggplot2 plot
#' @author Giovanni Laudanno
#' @export
create_fig_bd <- function(
  t_0 = 10,
  n_taxa = 5,
  n_0 = 2
) {
  start_brts <- seq(from = 0, to = t_0, by = t_0 / (n_taxa - n_0 + 1))
  start_brts <- sort(start_brts[2:(length(start_brts) - 1)], decreasing = TRUE)
  x <- subplex::subplex(
    par = start_brts,
    fn = calc_likelihood,
    t_0 = t_0,
    n_taxa = n_taxa,
    n_0 = n_0
  )
  brts <- sort(c(rep(t_0, n_0), x$par), decreasing = TRUE)
  brts <- signif(brts, digits = 2)
  l_table <- matrix(NA, nrow = 5, ncol = 4)
  l_table[, 4] <- -1
  l_table[, 3] <- c(1, -2, 3, -4, 5)
  l_table[, 2] <- c(0, 1, 1, -2, 3)
  l_table[, 1] <- brts
  tree <- DDD::L2phylo(L = l_table)
  tree$tip.label <- c("A", "B", "C", "D", "E")
  figure_bd <- ggtree::ggtree(tree) +
    ggtree::theme_tree2() +
    ggtree::geom_tiplab()
  figure_bd
}

#' Create figure bd file
#' @inheritParams default_params_doc
#' @return the name of the file the plot is saved to
#' @author Richel J.C. Bilderbeek, Giovanni Laudanno
#' @export
create_fig_bd_file <- function(
  fig_bd_filename = "figure_bd.png"
) {
  # create figure
  fig_bd <- create_fig_bd() # nolint internal function

  # save output
  ggplot2::ggsave(
    filename = fig_bd_filename,
    plot = fig_bd
  )
  fig_bd_filename
}

# Run
library(pirouette)
create_fig_bd_file()
