# *****************************************************
#   Data Generation Process
# *****************************************************


#' Data Generating Process (DGP)
#'
#' Generates synthetic binary outcome data for simulation studies.
#'
#' @param n Sample size
#' @param beta0 Intercept term (default: 1)
#' @param beta1 Slope coefficient for x (default: 2)
#'
#' @return Data frame with columns: x (predictor), y (binary outcome), p (probability)
DGP <- function(n, beta0 = 1, beta1 = 2){
  # Generate predictor variable from standard normal distribution
  x <- rnorm(n)

  # Calculate probability using logistic link function
  p <- plogis(beta0 + beta1 * x)

  # Generate binary outcome from Bernoulli distribution
  y <- rbinom(n, size = 1, prob = p)

  # Return data frame with all variables
  data.frame(x = x, y = y, p = p)
}