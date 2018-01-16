<!-- README.md is generated from README.Rmd. Please edit that file -->
mazeinda
========

The goal of mazeinda is to provide functions to compute the monotonic association of zero-inflated vectors, according to the generalization of the tau-b formula proposed by Pimentel(2009).

Example
-------

Mazeinda provides for the user three functions: for obtaining a matrix of association values, $test \\textunderscore associations$ for obtaining the p-values of the output of associate and which gives non-zero values only if the association is significantly different from 0. The vectors to be associated can be given as a pair or as columns in matrices.

``` r
library(mazeinda)
library(gamlss.dist)
#> Loading required package: MASS
set.seed(224)

### two vectors as imput

x=abs(rBEZI(50, mu = 0.9, sigma = 1, nu = 0.7))
y=abs(rBEZI(50, mu = 0.9, sigma = 1, nu = 0.5))
associate(x,y)
#> [1] 0.07373333
test_associations(x,y)
#> [1] 0.1119453
combine(x,y)
#> [1] 0

### two matrices as imput

m1=matrix(abs(rBEZI(50, mu = 0.9, sigma = 1, nu = 0.7)),5)
m2=matrix(abs(rBEZI(30, mu = 0.9, sigma = 1, nu = 0.5)),5)

associate(m1,m2)
#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero

#> Warning in cor(x, y, method = "kendall"): the standard deviation is zero
#>             [,1]       [,2]       [,3]       [,4] [,5]       [,6]
#>  [1,] -0.4444444  0.1259882 -0.0800000 -0.0800000   NA -0.0800000
#>  [2,]  0.8819171  0.0800000 -0.0800000 -0.0800000   NA  0.8819171
#>  [3,]  0.7777778 -0.0800000 -0.0800000 -0.0800000   NA -0.0800000
#>  [4,]  0.0000000 -0.3779645  0.6666667  0.3333333   NA -0.5000000
#>  [5,]  0.1054093 -0.3585686  0.9486833  0.1054093   NA -0.1054093
#>  [6,] -0.5000000 -0.3779645  0.0000000 -0.5000000   NA  0.0000000
#>  [7,] -0.0800000 -0.5714286  0.6299408 -0.0800000   NA -0.0800000
#>  [8,]  0.2400000 -0.7559289  0.2400000 -0.4444444   NA  0.2400000
#>  [9,]         NA         NA         NA         NA   NA         NA
#> [10,]  0.6299408  0.0800000 -0.0800000 -0.0800000   NA  0.6299408
test_associations(m1,m2)
#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties
#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties
#>             [,1]       [,2]      [,3]      [,4] [,5]       [,6]
#>  [1,] 0.29791112 0.77554227 0.6453059 0.6453059  0.5 0.64530594
#>  [2,] 0.04594145 0.35469406 0.6453059 0.6453059  0.5 0.04594145
#>  [3,] 0.06851329 0.64530594 0.6453059 0.6453059  0.5 0.64530594
#>  [4,] 1.00000000 0.42919530 0.1467931 0.4681599  0.5 0.27650048
#>  [5,] 0.80054211 0.40538056 0.0229774 0.8005421  0.5 0.80054211
#>  [6,] 0.27650048 0.42919530 1.0000000 0.2765005  0.5 1.00000000
#>  [7,] 0.64530594 0.21263450 0.1539651 0.6453059  0.5 0.64530594
#>  [8,] 0.23210716 0.08711844 0.2321072 0.2979111  0.5 0.23210716
#>  [9,] 0.50000000 0.50000000 0.5000000 0.5000000  0.5 0.50000000
#> [10,] 0.15396510 0.35469406 0.6453059 0.6453059  0.5 0.15396510
combine(m1,m2)
#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties

#> Warning in cor.test.default(x, y, method = "kendall"): Cannot compute exact
#> p-value with ties
#>            [,1] [,2]      [,3] [,4] [,5]      [,6]
#>  [1,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [2,] 0.8819171    0 0.0000000    0    0 0.8819171
#>  [3,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [4,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [5,] 0.0000000    0 0.9486833    0    0 0.0000000
#>  [6,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [7,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [8,] 0.0000000    0 0.0000000    0    0 0.0000000
#>  [9,] 0.0000000    0 0.0000000    0    0 0.0000000
#> [10,] 0.0000000    0 0.0000000    0    0 0.0000000
```
