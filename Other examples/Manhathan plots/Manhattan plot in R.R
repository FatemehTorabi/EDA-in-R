# Simulated larger dataset
set.seed(42)
chromosomes <- rep(1:22, each = 1000) # 22 chromosomes, each with 1000 positions
positions <- unlist(lapply(1:22, function(x) seq(1, 1e6, length.out = 1000))) # Scaled positions
p_values <- runif(22 * 1000, min = 1e-8, max = 1) # Uniformly distributed p-values

# Create a data frame
data <- data.frame(chromosomes, positions, p_values)

# Calculate negative log10 p-values
data$log_p <- -log10(data$p_values)

# Manhattan plot
library(ggplot2)
ggplot(data, aes(x = positions, y = log_p, color = factor(chromosomes))) +
  geom_point(alpha = 0.6, size = 0.5) + # Add transparency and smaller points
  scale_color_manual(values = rep(rainbow(22), length.out = 22)) + # Color by chromosomes
  labs(x = "Genomic Positions", y = "-log10(p-value)",
       title = "Manhattan plot template for MicroMasters in HDS") +
  theme_minimal() +
  theme(legend.position = "none") # Hide legend for cleaner visualization
