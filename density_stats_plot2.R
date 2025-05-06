#!/usr/bin/env Rscript
# Usage: cut -d ' ' -f 4 AllChrGenes2.cir |Rscript density_stats_plot2.R

# Read data from stdin
data <- scan(file("stdin"), what = numeric(), quiet = TRUE)

# Compute statistics
mean_val <- mean(data)
sd_val <- sd(data)
var_val <- var(data)

# Generate density
dens <- density(data)

# Create the plot
png("density_stats_plot.png", width = 800, height = 600)
par(scipen = 6)  # Avoid scientific notation
plot(dens, main = "Density Plot with Statistical Annotations",
     xlab = "Values", ylab = "Density", col = "black", lwd = 2)

# Fill the density area with light color
polygon(dens, col = "lightblue", border = "black")

# Add mean line
abline(v = mean_val, col = "red", lwd = 2, lty = 2)

# Add ±SD lines
sd_left <- mean_val - sd_val
sd_right <- mean_val + sd_val
abline(v = sd_left, col = "green", lwd = 2, lty = 3)
abline(v = sd_right, col = "green", lwd = 2, lty = 3)

# Place SD labels with offset to avoid overlap
label_y <- max(dens$y) * 0.85
text(sd_left, label_y, paste0("Mean - SD = ", round(sd_left, 2)),
     col = "green", pos = 2, cex = 1.0)
text(sd_right, label_y, paste0("Mean + SD = ", round(sd_right, 2)),
     col = "green", pos = 4, cex = 1.0)

# Add variance annotation in blue above mean
text(x = mean_val, y = max(dens$y) * 0.95,
     labels = paste("Variance =", round(var_val, 2)),
     col = "blue", cex = 1.2)

dev.off()

