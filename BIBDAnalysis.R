# This is to analyse data from a BIBD
rm(list = ls())
library(agricolae)
library(dplyr)

# import data
dat <- readxl::read_excel("file.directory", sheet = "sheet")
  # temp
y = scan()
73 74 71 75 67 72 73 75 68 75 72 75

trt = gl(4, 3)
blk = scan(what = "")
1 2 4 2 3 4 1 2 3 1 3 4

out <- aov(y ~ blk + trt)
summary(out)
