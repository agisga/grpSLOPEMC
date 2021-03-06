% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lambdaMC.R
\name{lambdaMC}
\alias{lambdaMC}
\title{Monte Carlo based regularizing sequences for Group SLOPE}
\usage{
lambdaMC(fdr = 0.1, group, A, y = NULL, wt = NULL, method, n.MC,
  MC.reps = 5000)
}
\arguments{
\item{fdr}{Target gFDR (group false discovery rate)}

\item{group}{A vector describing the grouping structure. It should 
contain a group id for each predictor variable.}

\item{A}{The model matrix}

\item{y}{The response variable}

\item{wt}{A named vector of weights, one weight per group of predictors (named according to names as in vector \code{group})}

\item{method}{Possible values are "gaussianMC" and "chiMC". See details.}

\item{n.MC}{The corrections of the entries of lambda will be 
computed up to the index given by \code{n.MC} only. See details.}

\item{MC.reps}{The number of repetitions of the Monte Carlo procedure}
}
\description{
Generate the regularizing sequence \code{lambda} for the Group SLOPE
problem according to one of multiple Monte Carlo based methods.
}
\details{
Two Monte Carlo based methods are currently available to generate the regularizing sequence \code{lambda}:
\itemize{
  \item "gaussianMC" -- method introduced in Gossmann et. al. (2015)
  \item "chiMC" -- A Monte Carlo lambda selection method based on equation (G.10)
           in Brzyski et. al. (2016). Requires that rank(\code{A}) is greater than
           the sum of the number of elements in any \code{n.MC} groups. 
}
The corrections of the entries of lambda will be computed up to the index given 
by \code{n.MC} only (the remaining tail of the returned sequence will be flat). 
\code{n.MC} should be less than or equal to \code{n.group}. 
Since lambda sequences obtained via MC tend to flatten out quickly, 
it is reasonable to choose \code{n.MC} to be much smaller than the
number of groups.
}
\examples{
# generate some data
A <- matrix(rnorm(20000), 200, 100)
b <- c(rep(1, 10), rep(0, 90))
y <- A \%*\% b
# randomly divide 100 predictors into 30 groups
group <- sample(1:30, 100, repl = TRUE)
# set the weight for each group to the square root of the group's size
wt <- c(sqrt(table(group)))
# compute different lambda sequences
gaussianMC <- lambdaMC(fdr=0.1, group=group, A=A, method="gaussianMC",
                       n.MC=10, MC.reps=100)
chiMC <- lambdaMC(fdr=0.2, group=group, A=A, method="chiMC", 
                  y=y, wt=wt, n.MC=10, MC.reps=100)

}
\references{
D. Brzyski, A. Gossmann, W. Su, M. Bogdan (2016), \emph{Group SLOPE - adaptive selection of groups of predictors}, \url{https://arxiv.org/abs/1610.04960}

A. Gossmann, S. Cao, Y.-P. Wang (2015), \emph{Identification of Significant Genetic Variants via SLOPE, and Its Extension to Group SLOPE}, \url{http://dx.doi.org/10.1145/2808719.2808743}
}

