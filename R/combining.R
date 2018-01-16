
#' no_null
#'
#' computes association if significance level excludes the null hypothesis
#' @param x,y vectors to be correlated. Must be numeric.
#' @param sl level of significance for testing the null hypothesis. Default is
#'   0.05.
#' @param estimator string indicating how the parameters $p_{11}$, $p_{01}$,
#'   $p_{10}$, $p_{00}$ are to be estimated. The default is 'values', which
#'   indicates that they are estimated based on the entries of x and y. If
#'   estimates=='mean', each $p_ji$ is estimated as the mean of all pairs of
#'   column vectors in m1, and of m2 if needed. If estimates=='own', the
#'   $p_ji$'s must be given as arguments.
#' @param p11 probability that a bivariate observation is of the type (m,n),
#'   where m,n>0.
#' @param p01 probability that a bivariate observation is of the type (0,n),
#'   where n>0.
#' @param p10 probability that a bivariate observation is of the type (n,0),
#'   where n>0.
#' @return correlation value if significantly different from 0 or 0 otherwise.
#' @family combining functions
#' @keywords internal

no_null <- function(x, y, sl, estimator = "values", p11 = 0, p01 = 0, p10 = 0) {

    nz = which(apply(cbind(x, y), 1, function(row) all(row[1] > 0 & row[2] > 0)))
    nz_data = cbind(x, y)[nz, ]

    if (estimator == "values") {
        p11 <- prop_11(x, y)
        p01 <- prop_01(x, y)
        p10 <- prop_10(x, y)
    }

    p_00 = 1 - (p11 + p01 + p10)

    if (p11 == 1 | p11 == 0 | p01 == 1 | p01 == 0 | p10 == 1 | p10 == 0 | p_00 == 1 | p_00 == 0) {
        ### cases when variance formula cannot be applied
        if (length(which(!duplicated(x))) == 1 | length(which(!duplicated(y))) == 1) {
            return(0)
        } else {
            if (stats::cor.test(x, y, method = "kendall")$p.value >= sl & stats::cor.test(x, y, method = "kendall")$p.value <= 1 - sl) {
                return(0)
            } else {
                return(stats::cor(x, y, method = "kendall"))
            }
        }
    }
    if (length(nz) > 1) {
        if (length(which(!duplicated(nz_data[, 1]))) == 1 | length(which(!duplicated(nz_data[, 2]))) == 1) {
            t_11 = 0
        } else {
            t_11 = stats::cor(nz_data[, 1], nz_data[, 2], method = "kendall")
        }
    } else {
        t_11 = 0
    }

    tau_t = p11^2 * t_11 + 2 * (p_00 * p11 - p01 * p10)
    sigma = 2 * tau_t * (p_00 + p11) - ((p11^2) * t_11 * (2 * p11 - (6 * p_00) - (4 * p11 * t_11))) + 4 * p01 * p10 - (4 *
        tau_t^2)
    if (stats::pnorm(tau_t, mean = 0, sd = sqrt(sigma/length(x)), lower.tail = FALSE) >= sl & stats::pnorm(tau_t, mean = 0, sd = sqrt(sigma/length(x)),
        lower.tail = FALSE) <= 1 - sl) {
        return(0)
    } else {
        return(tau_t)
    }
}

#' combine
#'
#' Designed to combine the matrix of correlation values with the matrix of
#' p-values so that in the cases when the null hypothesis cannot be rejected
#' with a level of confidence indicated by the significance, the correlation is
#' set to zero. Thanks to the package foreach, computation can be done in
#' parallel using the desired number of cores.
#'
#' To test pairwise monotonic associations of vectors within one set \eqn{m}, run
#' combine(\eqn{m},\eqn{m}). Note that the values on the diagonal will not be necessarily
#' significant if the vectors contain 0's, as it can be seen by the formula
#' \eqn{p_{11}^2 t_{11} + 2 * (p_{00} p_{11} - p_{01} p_{10})}. The formula for the
#' variance of the estimator proposed by Pimentel(2009) does not apply in case
#' \eqn{p_{11}}, \eqn{p_{01}},\eqn{p_{10}}, \eqn{p_{00}} attain the values 0 or 1. In these cases the R
#' function cor.test is used. Note that while independence implies that the
#' estimator is 0, if the estimator is 0, it does not imply that the vectors are
#' independent.
#'
#' @param m1,m2 matrices whose columns are to be correlated. If no estimation
#'   calculations are needed, default is NA.
#' @param sl level of significance for testing the null hypothesis. Default is
#'   0.05.
#' @param parallel should the computations for associating the matrices be done
#'   in parallel? Default is FALSE
#' @param n_cor number of cores to be used if the computation is run in
#'   parallel. Default is 1
#' @param d1,d2 sets of vectors used to estimate \eqn{p_{ij}} parameters. If just one
#'   set is needed set \eqn{d_1}=\eqn{d_2}.
#' @param estimator string indicating how the parameters \eqn{p_{11}}, \eqn{p_{01}},
#'   \eqn{p_{10}}, \eqn{p_{00}} are to be estimated. The default is 'values', which
#'   indicates that they are estimated based on the entries of x and y. If
#'   estimates=='mean', each \eqn{p_{ij}} is estimated as the mean of all pairs of
#'   column vectors in \eqn{m_1}, and of \eqn{m_2} if needed. If estimates=='own', the
#'   \eqn{p_{ij}}'s must be given as arguments.
#' @param p11 probability that a bivariate observation is of the type (m,n),
#'   where m,n>0.
#' @param p01 probability that a bivariate observation is of the type (0,n),
#'   where n>0.
#' @param p10 probability that a bivariate observation is of the type (n,0),
#'   where n>0.
#' @return matrix of combined association values and p-values.
#' @import foreach
#' @family combining functions
#' v1=c(0,0,10,0,0,12,2,1,0,0,0,0,0,1)
#' v2=c(0,1,1,0,0,0,1,1,64,3,4,2,32,0)
#' combine(v1,v2)
#' m1=matrix(c(0,0,10,0,0,12,2,1,0,0,0,0,0,1,1,64,3,4,2,32,0,0,43,54,3,0,0,3,20,1),6)
#' combine(m1,m1)
#' m2=matrix(c(0,1,1,0,0,0,1,1,64,3,4,2,32,0,0,43,54,3,0,0,3,20,10,0,0,12,2,1,0,0),6)
#' combine(m1,m2)
#' m3= matrix(abs(rnorm(36)),6)
#' m4= matrix(abs(rnorm(36)),6)
#' combine(m3,m4)
#' @export

combine <- function(m1, m2, sl = 0.05, parallel = FALSE, n_cor = 1, estimator = "values", d1, d2, p11 = 0, p01 = 0, p10 = 0) {

    m1 <- as.matrix(m1)
    m2 <- as.matrix(m2)

    if (estimator == "mean") {
        p11 <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_11, d2[,
            index_of_group2]))
        p01 <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_01, d2[,
            index_of_group2]))
        p10 <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_10, d2[,
            index_of_group2]))
    }

    if (parallel == TRUE) {
        if (!requireNamespace("doMC", quietly = TRUE)) {
            stop("doMC needed for computing in parallel. Please install it.", call. = FALSE)
        }
        doMC::registerDoMC(cores = n_cor)
        m <- foreach(index_of_group2 = 1:ncol(m2), .combine = "cbind", .multicombine = TRUE, .inorder = TRUE) %dopar% {
            apply(m1, 2, no_null, m2[, index_of_group2], sl, estimator, p11 = 0, p01 = 0, p10 = 0)
        }
    } else {
        m <- foreach(index_of_group2 = 1:ncol(m2), .combine = "cbind", .multicombine = TRUE, .inorder = TRUE) %do% {
            apply(m1, 2, no_null, m2[, index_of_group2], sl, estimator, p11 = 0, p01 = 0, p10 = 0)
        }
    }
    row.names(m) = colnames(m1)
    colnames(m) = colnames(m2)
    return(m)
}
