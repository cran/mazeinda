if(getRversion() >= "2.15.1")  utils::globalVariables("index_of_group2")

#' p_11 estimator
#'
#' computes estimate of parameter p_11 based on sample proportions.
#' @param x,y vectors to be correlated. Must be numeric.
#' @return p_11 estimator
#' @keywords internal
prop_11 <- function(x, y) {
    return((length(which(apply(cbind(x, y), 1, function(row) all(row[1] > 0 & row[2] > 0)))))/length(x))
}

#' p_01 estimator
#'
#' computes estimate of parameter p_01 based on sample proportions.
#' @param x,y vectors to be correlated. Must be numeric.
#' @return p_01 estimator
#' @keywords internal
prop_01 <- function(x, y) {
    return((length(which(apply(cbind(x, y), 1, function(row) all(row[1] == 0 & row[2] > 0)))))/length(x))
}

#' p_10 estimator
#'
#' computes estimate of parameter p_01 based on sample proportions.
#' @param x,y vectors to be correlated. Must be numeric.
#' @return p_10 estimator
#' @keywords internal
prop_10 <- function(x, y) {
    return((length(which(apply(cbind(x, y), 1, function(row) all(row[1] > 0 & row[2] == 0)))))/length(x))
}

#' Pimentel's tau_b
#'
#' Computes the estimator for Kendall's tau_b for zero inflated continuous data
#' proposed by Pimentel(2009).
#' @param x,y vectors to be correlated. Must be numeric and have the same
#'   length.
#' @param estimator string indicating how the parameters $p_{11}$, $p_{01}$,
#'   $p_{10}$ are to be estimated. The default is 'values', which indicates that
#'   they are estimated based on the entries of x and y. If estimates=='own',
#'   the $p_ji$'s must be given as arguments.
#' @param p11 probability that a bivariate observation is of the type (m,n),
#'   where m,n>0. Default is 0.
#' @param p01  probability that a bivariate observation is of the type (0,n),
#'   where n>0.Default is 0.
#' @param p10 probability that a bivariate observation is of the type (n,0),
#'   where n>0.Default is 0.
#' @return correlation values
#' @family associating functions
#' @keywords internal


tau_p <- function(x, y, estimator = "values", p11 = 0, p01 = 0, p10 = 0) {

    nz <- which(apply(cbind(x, y), 1, function(row) all(row[1] > 0 & row[2] > 0)))
    nz_data <- cbind(x, y)[nz, ]

    if (length(nz) > 1) {
        if (length(which(!duplicated(nz_data[, 1]))) == 1 | length(which(!duplicated(nz_data[, 2]))) == 1) {
            t_11 <- 0  #positive ties treated as in Kendall's tau-b; i.e. they bring no contribution
        } else {
            t_11 <- stats::cor(nz_data[, 1], nz_data[, 2], method = "kendall")
        }
    } else {
        t_11 <- 0  #in case of only one positive entry, it is impossible to measure concordance or discordance
    }

    if (estimator == "values") {
        p11 <- prop_11(x, y)
        p01  <- prop_01(x, y)
        p10  <- prop_10(x, y)
    }

    p_00 <- 1 - (p11 + p01  + p10 )
    if (p11 == 1 | p11 == 0 | p01  == 1 | p01  == 0 | p10  == 1 | p10  == 0 | p_00 == 1 | p_00 == 0) {
        ### cases when variance formula cannot be applied
        return(stats::cor(x, y, method = "kendall"))
    }
    return(p11 ^2 * t_11 + 2 * (p_00 * p11 - p01  * p10 ))
}



#' Associate pairwise vectors form one or two sets
#'
#' Given two matrices \eqn{m_1} and \eqn{m_2}, computes all pairwise correlations of each
#' vector in \eqn{m_1} with each vector in \eqn{m_2}. Thanks to the package foreach,
#' computation can be done in parallel using the desired number of cores.
#'
#'
#' To find pairwise monotonic associations of vectors within one set \eqn{m}, run
#' associate(\eqn{m},\eqn{m}). Note that the values on the diagonal will not be necessarely
#' 1 if the vectors contain 0's, as it can be seen by the formula \eqn{p_{11}^2 t_{11} + 2 * (p_{00} p_{11} - p_{01} p_{10})}
#'
#' @param m1,m2 matrices whose columns are to be correlated. If no estimation
#'   calculations are needed, default is NA.
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
#' @return matrix of correlation values.
#' @import foreach
#' @export
#' @examples
#' v1=c(0,0,10,0,0,12,2,1,0,0,0,0,0,1)
#' v2=c(0,1,1,0,0,0,1,1,64,3,4,2,32,0)
#' associate(v1,v2)
#' m1=matrix(c(0,0,10,0,0,12,2,1,0,0,0,0,0,1,1,64,3,4,2,32,0,0,43,54,3,0,0,3,20,1),6)
#' associate(m1,m1)
#' m2=matrix(c(0,1,1,0,0,0,1,1,64,3,4,2,32,0,0,43,54,3,0,0,3,20,10,0,0,12,2,1,0,0),6)
#' associate(m1,m2)

associate <- function(m1, m2, parallel = FALSE, n_cor = 1, estimator = "values", d1, d2, p11 = 0, p01  = 0, p10  = 0) {
    m1 <- as.matrix(m1)
    m2 <- as.matrix(m2)

    if (estimator == "mean") {
        p11 <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_11, d2[,
            index_of_group2]))
        p01  <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_01 , d2[,
            index_of_group2]))
        p10  <- mean(foreach(index_of_group2 = 1:ncol(d2), .combine = "c", .multicombine = TRUE) %do% apply(d1, 2, prop_10, d2[,
            index_of_group2]))
    }

    if (parallel == TRUE) {
        if (!requireNamespace("doMC", quietly = TRUE)) {
            stop("doMC needed for computing in parallel. Please install it.", call. = FALSE)
        }
        doMC::registerDoMC(cores = n_cor)
        matrix_of_taus <- foreach(index_of_group2 = 1:ncol(m2), .combine = "cbind", .multicombine = TRUE, .inorder = TRUE) %dopar%
            {
                apply(m1, 2, tau_p, m2[, index_of_group2], estimator, p11 , p01 , p10 )
            }
    } else {
        matrix_of_taus <- foreach(index_of_group2 = 1:ncol(m2), .combine = "cbind", .multicombine = TRUE, .inorder = TRUE) %do%
            {
                apply(m1, 2, tau_p, m2[, index_of_group2], estimator, p11 , p01 , p10 )
            }
    }
    row.names(matrix_of_taus) = colnames(m1)
    colnames(matrix_of_taus) = colnames(m2)
    return(matrix_of_taus)
}


