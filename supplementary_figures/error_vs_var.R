#' Download the data and create a plot of error vs variable
#' @param var variable to plot on the x-axis
#' @param datafolder folder to download the data in
#' @param resultsfolder folder to save the results in
#' @author Giovanni Laudanno
#' @return a plot
plot_error_vs_var = function(
  var,
  datafolder,
  resultsfolder
) {
  data_filename = paste0("errors_vs_", var, ".RData")

  # Download data
  path = file.path(resultsfolder, var)
  if (!dir.exists(path)) {dir.create(path)}
  setwd(datafolder)

  if (var == "n_taxa") {
    examples <- c(28, 32, 33, 41, 42)
    var_values <- c(6, 12, 24, 32, 40)
  } else if (var == "sequence_length") {
    examples <- c(19, 28, 34)
    var_values <- c(500, 1000, 2000)
  } else if (var == "mutation_rate") {
    examples <- c(35, 36, 37, 28, 38, 39, 40)
    var_values <- c(0.25, 0.50, 0.75, 1.00, 1.25, 1.50, 2.00)
  } else {
    stop("This variable cannot be used")
  }
  testit::assert(length(examples) == length(var_values))
  for (example in examples) {
    stringa = paste0("pirouette_example_", example)
    if (!any(grepl(x = list.files(datafolder), pattern = stringa))) {
      zipfile = file.path(datafolder, paste0(stringa, ".zip"))
      utils::download.file(
        url = paste0("http://www.richelbilderbeek.nl/pirouette_example_", example, ".zip"),
        destfile = zipfile
      )
      utils::unzip(zipfile)
    }
  }

  # Collect data
  if (file.exists(data_filename)) {
    load(file = data_filename)
  } else {
    ee = f = 1; seed = 314
    maxseed = 100
    errors = data.frame(matrix(NA, nrow = 9001 * 4 * maxseed * length(examples), ncol = 3))
    colnames(errors) = c("value", "model", var)
    i = 0
    for (ee in seq_along(examples)) {
      example = examples[ee]
      var_value = var_values[ee]
      cat(var, "is", var_value, "\n")
      xx = file.path(datafolder, paste0("pirouette_example_", example), paste0("example_", example))
      testit::assert(dir.exists(xx))
      seeds = list.files(xx)
      for (seed in seeds) {
        cat("seed is", seed, "\n")
        folder = file.path(datafolder, paste0("pirouette_example_", example), paste0("example_", example), seed)
        testit::assert(dir.exists(folder))
        files = list.files(path = folder, pattern = "errors", full.names = T)
        files = files[grepl(files, pattern = ".csv")]
        files = files[grepl(files, pattern = "best") | grepl(files, pattern = "gen")]
        testit::assert(file.exists(files))
        for (f in seq_along(files)) {
          pir_out_filename = files[f]
          pir_out <- utils::read.csv(pir_out_filename)
          len = nrow(pir_out)
          indici = i + 1:len
          {
            if (basename(pir_out_filename) == "best_errors.csv") {
              model = "best_true"
            } else if (basename(pir_out_filename) == "best_errors_twin.csv") {
              model = "best_twin"
            } else if (basename(pir_out_filename) == "gen_errors.csv") {
              model = "gen_true"
            } else if (basename(pir_out_filename) == "gen_errors_twin.csv") {
              model = "gen_twin"
            } else {next}
          }
          errors$value[indici] = pir_out$x
          errors$model[indici] = model
          errors[[var]][indici] = var_value
          i = max(indici)
        }
      }
    }
    if (sum(!is.na(errors$value)) == nrow(errors)) {
      errors2 = errors
    } else {
      errors2 = errors[1:(min(which(is.na(errors$value))) - 1), ]
    }
    resultsfolder2 = file.path(resultsfolder, var)
    setwd(resultsfolder2)
    save(errors2, file = data_filename)
  }

  # Summarize data
  models = unique(errors2$model)
  var_values = unique(errors2[[var]])
  jj = 1
  df = data.frame(matrix(NA, ncol = 3, nrow = length(models) * length(var_values)))
  for (model in models) {
    for (var_value in var_values) {
      message(jj)
      df$median[jj] = median(errors2[errors2$model == model & errors2[[var]] == var_value, "value"])
      df$model[jj] = model
      df$var[jj] = var_value
      jj = jj + 1
    }
  }
  df = df %>% dplyr::select_if(function(x) any(!is.na(x)))
  df2 = data.frame(matrix(NA, ncol = 3, nrow = length(var_values) * 2))
  jj = 1
  for (var_value in var_values) {
    df2$diff[jj] =
      df[df$model == "best_true" & df$var == var_value, "median"] -
      df[df$model == "best_twin" & df$var == var_value, "median"]
    df2$Model[jj] = "Best"
    df2$var[jj] = var_value
    jj = jj + 1
    df2$diff[jj] =
      df[df$model == "gen_true" & df$var == var_value, "median"] -
      df[df$model == "gen_twin" & df$var == var_value, "median"]
    df2$Model[jj] = "Generative"
    df2$var[jj] = var_value
    jj = jj + 1
  }
  df2 = df2 %>% dplyr::select_if(function(x) any(!is.na(x)))
  var2name <- function(y) {
    y = gsub(y, pattern = "_", replacement = " ")
    c <- strsplit(y, " ")[[1]]
    paste(toupper(substring(c, 1,1)), substring(c, 2),
          sep="", collapse=" ")
  }

  # Plot data
  fillcolors <- linecolors <- c("red", "royalblue3")
  plot = ggplot2::ggplot(data = df2); ggplot2::geom_point(
      ggplot2::aes(x = var, y = diff, color = Model, fill = Model),
      alpha = 0.4, shape = 21, size = 6 # shape = 7
    ); ggplot2::ylab("True Median - Twin Median"); ggplot2::xlab(
      var2name(var)
    ); ggplot2::theme_bw(); ggplot2::scale_color_manual(values = linecolors); ggplot2::scale_fill_manual(values = fillcolors); plot

  ggplot2::ggsave(
    filename = paste0("plot_error_vs_", var, ".png"),
    plot = plot,
    width = 6.5, height = 3.55
  )
  plot
}
