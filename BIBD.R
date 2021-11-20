# This is to generate a BIBD and its field trial spacial plots
rm(list = ls())
library(ibd)
library(tidyr)
library(dplyr)

# generate a BIBD data table
  # or see agricolae design.bib()
ntrt = 4
nblk = 4
r = 3
k = 3
set.seed(10)
d = bibd(ntrt, nblk, r, k, r*(k-1)/(ntrt-1))

n = 3 # define sample size
df <- data.frame(blk = gl(nblk, k), trt = as.vector(t(d$design)))
df <- df %>% uncount(n) %>% mutate(sample = rep(seq_len(n), length.out = n())) %>% mutate(y = rep(NA))
openxlsx::write.xlsx(df, "file.directory")

# generate BIBD field trial spatial plots
map <- d$design
set.seed(100)
for (i in 1:nrow(map)) {
  map[i,] <- sample(map[i,])
}
map
openxlsx::write.xlsx(map, "file.directory")

