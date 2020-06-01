# Create the 'compare_mut_rates.png' figure
library(testthat)
library(tibble)
library(ggplot2)
library(png)
library(grid)
library(gridExtra)

mutation_rates <- c(0.25, 0.50, 0.75, 1.0, 1.25, 1.50, 2.0)

df <- tibble::tibble(
  mutation_rate = mutation_rates,
  filename  = c(
    file.path("..", "pirouette_example_35", "errors.png"), # 0.25
    file.path("..", "pirouette_example_36", "errors.png"), # 0.50
    file.path("..", "pirouette_example_37", "errors.png"), # 0.75
    file.path("..", "pirouette_example_28", "errors.png"), # 1.00
    file.path("..", "pirouette_example_38", "errors.png"), # 1.25
    file.path("..", "pirouette_example_39", "errors.png"), # 1.50
    file.path("..", "pirouette_example_40", "errors.png")  # 2.00
  )
)
n_figs <- nrow(df)
expect_true(all(file.exists(df$filename)))

# Create the figure
# Dumb, but works
plot1 <- readPNG(df$filename[1])
plot2 <- readPNG(df$filename[2])
plot3 <- readPNG(df$filename[3])
plot4 <- readPNG(df$filename[4])
plot5 <- readPNG(df$filename[5])
plot6 <- readPNG(df$filename[6])
plot7 <- readPNG(df$filename[7])
ggsave(
  "compare_mut_rates_graphs.png",
  grid.arrange(
    rasterGrob(plot1),
    rasterGrob(plot2),
    rasterGrob(plot3),
    rasterGrob(plot4),
    rasterGrob(plot5),
    rasterGrob(plot6),
    rasterGrob(plot7),
    ncol = 7
  ),
  width = 49,
  height = 7
)

# Collect the medians by eye, using a screen ruler :-/
df_wide <- tibble::tibble(
  mutation_rate = mutation_rates,
  gen_true = c(0.020, 0.021, 0.021, 0.028, 0.030, 0.031, 0.077),
  gen_twin = c(0.020, 0.020, 0.021, 0.022, 0.033, 0.036, 0.070),
  best_true = c(0.0192, 0.018, 0.019, 0.026, 0.028, 0.028, 0.073),
  best_twin = c(0.0182, 0.018, 0.019, 0.019, 0.030, 0.032, 0.066)
)

df <- tidyr::pivot_longer(
  data = df_wide,
  -mutation_rate
)
df$name <- as.factor(df$name)
ggplot(df, aes(x = mutation_rate, y = value, col = name)) +
  geom_point() +
  geom_smooth(method = "loess") +
  coord_cartesian(ylim = c(0.0, 0.1)) +
  facet_grid(cols = vars(name)) +
  ggsave("compare_mut_rates_graphs.png", width = 7, height = 7)
