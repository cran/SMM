\name{estimMk}
\alias{estimMk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimation of a k-th order Markov chain
}
\description{
Estimation of the transition matrix and initial law of a k-th order Markov chain starting from one or several sequences.
}
\usage{
estimMk(file = NULL, seq, E, k)

estimMk(file, seq = NULL, E, k)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{
Path of the file in fasta format which contains the sequences from which to estimate  
}
  \item{seq}{
List of sequence(s)
}
  \item{E}{
Vector of state space
}
  \item{k}{
Order of the Markov chain
}
}
\details{
Let \eqn{X_1, X_2, ..., X_n} be a trajectory of length \eqn{n} of the Markov chain \eqn{X = (X_m)_{m \in N}}
of order k=1 with transition matrix \eqn{Ptrans(i,j) = P(X_{m+1} = j | X_m = i).}
The estimation of the transition matrix is
\eqn{\widehat{Ptrans}(i,j) = N_{ij}/N_{i.},} where \eqn{N_{ij}} is the number of transitions from state i to state j and 
\eqn{N_{i.}} is the number of transition from state i to any state. For k > 1 we have similar expressions.

The initial distribution of a k-th order Markov chain is defined as  
\eqn{init = P(X_1 = i).}
An estimation of the initial law for a first order Markov chain is assumed to be the estimation of the stationary law. 
If the order of the Markov is greater than 1, then an estimation of the initial law is 
\eqn{init = N_i/N}, where \eqn{N_i} is the number occurences of state i in the sequences and \eqn{N} is the sum of the sequence lengths.
}
\value{
estimMk returns the transition probability matrix of size (S^{k})xS (with S = length(E)) 
and the initial law of size S estimated from the sequence(s) with a Markov model of order k.

The transition matrix is always given in the alphabetical and numerical order, even if the vector of state space is not given in this order.
}
%%\references{
%% ~put references to the literature/web site here ~
%%}

\author{
Vlad Stefan Barbu, barbu@univ-rouen.fr \cr Caroline Berard, caroline.berard@univ-rouen.fr \cr Dominique Cellier, dominique.cellier@laposte.net \cr Mathilde Sautreuil, mathilde.sautreuil@etu.univ-rouen.fr \cr Nicolas Vergne, nicolas.vergne@univ-rouen.fr 
}


%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
simulMk, 
estimSM,
simulSM
}
\examples{
### Example 1 ###
# Second order model on the state space {a,c,g,t}
E <- c("a","c","g","t")
S = length(E)
init.distribution <- c(1/6,1/6,5/12,3/12)
k<-2
p <- matrix(0.25, nrow = S^k, ncol = S)

## simulation of 3 sequences with the simulMk function
seq3 = simulMk(E = E, nbSeq = 3, lengthSeq = c(1000, 10000, 2000), Ptrans = p,
 init = init.distribution, k = 2)

## estimation of simulated sequences
res3 = estimMk(seq = seq3, E = E, k = 2)

## results of estimation
# initial law 
res3$init 
# [1] 0.2469048 0.2573333 0.2483810 0.2473810

# transition matrix 
res3$Ptrans 
#           [,1]      [,2]      [,3]      [,4]
# [1,] 0.2690616 0.2338710 0.2602639 0.2368035
# [2,] 0.2507553 0.2673716 0.2651057 0.2167674
# [3,] 0.2517758 0.2533544 0.2588792 0.2367798
# [4,] 0.2522376 0.2432872 0.2481692 0.2563059
# [5,] 0.2501949 0.2595479 0.2595479 0.2307093
# [6,] 0.2492775 0.2492775 0.2586705 0.2427746
# [7,] 0.2337662 0.2792208 0.2438672 0.2445887
# [8,] 0.2381306 0.2833828 0.2292285 0.2492582
# [9,] 0.2462745 0.2627451 0.2384314 0.2525490
#[10,] 0.2259760 0.2530030 0.2424925 0.2785285
#[11,] 0.2469512 0.2423780 0.2599085 0.2507622
#[12,] 0.2318393 0.2673879 0.2403400 0.2604328
#[13,] 0.2866192 0.2668250 0.2185273 0.2280285
#[14,] 0.2237711 0.2553191 0.2611886 0.2597212
#[15,] 0.2465863 0.2465863 0.2441767 0.2626506
#[16,] 0.2511346 0.2541604 0.2420575 0.2526475

### Example 2 ###
E <- c(1,2,3)
S <- length(E)
init.distr <- rep(1/S, 3)
p <- matrix(c(0.3,0.2,0.5,0.1,0.6,0.3,0.2,0.4,0.4), nrow = 3, byrow = TRUE)

## simulation with the simulMk function
seq1 = simulMk(E = E, nbSeq = 1, lengthSeq = 100, Ptrans = p, init = init.distr, k = 1)

## estimation
res1 = estimMk(seq = seq1, E = E, k = 1)

## results of estimation
# initial law
res1$init
# [1] 0.1507212 0.4062408 0.4430380

# transition matrix
res1$Ptrans
#          [,1]      [,2]      [,3]
# [1,] 0.2500000 0.1875000 0.5625000
# [2,] 0.0500000 0.5500000 0.4000000
# [3,] 0.2093023 0.3488372 0.4418605

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Estimation}
\keyword{Markov models}% __ONLY ONE__ keyword per line
