library(mazeinda)
context("associate")

test_that("prop functions work", {
  x=rnorm(10, 300,1)
  y=rnorm(10, 300,1)
  expect_equal(prop_11(x,y), 1)
  expect_equal(prop_01(x,y), 0)
  expect_equal(prop_10(x,y), 0)
  x=c(0,0,0,0,1,1,1,1,0)
  y=c(1,1,1,5,5,5,0,0,1)
  expect_equal(prop_11(x,y), 2/length(x))
  expect_equal(prop_01(x,y), 5/length(x))
  expect_equal(prop_10(x,y), 2/length(x))
  x=c(1,1,1,1,1,11,1,12,2)
  y=c(0,0,0,0,0,0,0,0,0)
  expect_equal(prop_11(x,y), 0)
  expect_equal(prop_01(x,y), 0)
  expect_equal(prop_10(x,y), 1)
  x=c(0,0,0,0,0,0,0,0,0)
  y=c(1,1,1,1,1,11,1,12,2)
  expect_equal(prop_11(x,y), 0)
  expect_equal(prop_01(x,y), 1)
  expect_equal(prop_10(x,y), 0)
})


