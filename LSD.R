# This is to generate Latin Square Design
rm(list = ls())
library(agricolae)
library(tidyr)
library(dplyr)

# generate a LSD data table
trt = as.factor(LETTERS[1:4])
d <- design.lsd(trt, serie = 1, seed = 0)

n = 3 # define sample size
df <- d$book 
df <- df %>% uncount(n) %>% mutate(sample = rep(seq_len(n), length.out = n())) %>% mutate(y = rep(NA))
openxlsx::write.xlsx(df, "file.directory")

# generate LSD field trial plot map
map <- d$sketch
openxlsx::write.xlsx(map, "file.directory")

# simulate data
df$y <- rnorm(length(df$y), 10, 5)

# analyse data
df.agg <- aggregate(y ~ row + col + trt, mean, data = df)
mod <- lm(y ~ row + col + trt, data = df.agg)
plot(mod)
anova(mod)
LSD.test(mod, trt = "trt",
         DFerror = model$df.residual,
         MSerror = deviance(model)/model$df.residual,
         alpha = 0.05,
         group = TRUE,
         console = TRUE)

# replicated latin square, see https://online.stat.psu.edu/stat503/lesson/4/4.4
