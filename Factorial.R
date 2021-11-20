## This is to generate factorial design
rm(list = ls())
library(agricolae)
library(dplyr)
library(ggplot2)

# design
factors <-c(2,2,2,2) # factorial 2^4
outdesign <-design.ab(factors, r=4, serie=1, seed = 10)
book<-outdesign$book
book <- book[order(book$A, book$B, book$C, book$D),]
book$trt <- rep(1:prod(factors), each = length(factors))
book <- book[order(book$plots),]
book <- book %>% relocate(trt, .after = block)
writexl::write_xlsx(book, "directory.xlsx")

# field plot
field <- data.frame()
for (i in 1:outdesign$parameters$r) {
  block <- matrix(book[book$block == i, "trt"], nrow = 2, ncol = 8, byrow = T) 
  field <- rbind(field, block)
}
writexl::write_xlsx(field, "directory.xlsx")

