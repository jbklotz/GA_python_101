library(ggplot2)
library(dplyr)

set.seed(1234)
n <- 100
x1 <- runif(n)
x2 <- x1 + rnorm(n, 0, 0.1)
df <- data.frame(x1, x2)

theme_ga <- theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

ga_red <- "#FC2B3C"
p1 <- ggplot(df, aes(x1, x2)) +
  theme_ga +
  labs(x = '', y = '') +
  geom_point()
p1

pc <- prcomp(~ x1 + x2, data = df, center = FALSE)

sc1 <- 1/pc$sdev[1]
sc2 <- pc$sdev[2]
pc1_mat <- data.frame(z = c(0, 0), pc1 = -sc1 * pc$rotation[, 1]) %>%
  t() %>%
  data.frame()

pc2_mat <- data.frame(z = c(0, 0), pc2 = sc2 * pc$rotation[, 2]) %>%
  t() %>%
  data.frame()

p2 <- p1 +
  geom_line(data = pc1_mat,
            aes(x1, x2),
            arrow = arrow(length = unit(0.2, 'cm')),
            color = ga_red,
            size = 1) +
  geom_line(data = pc2_mat,
            aes(x1, x2),
            arrow = arrow(length = unit(0.2, 'cm'), ends = 'first'),
            color = ga_red,
            size = 1)

ggsave(file = "p1.png", plot = p1, dpi = 600)
ggsave(file = "p2.png", plot = p2, dpi = 600)
