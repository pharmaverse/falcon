library(testthat)

pkg_name <- "cardinal"
library(pkg_name, character.only = TRUE)
testthat::test_check(pkg_name)
