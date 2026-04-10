# ******************************************
#  2. Main task to run simulation
# ******************************************

freshr::freshr()

# Parse command-line arguments: seed, sample size, and model type
args      = commandArgs(trailingOnly=T)
seed      = as.numeric(args[1])
n         = as.numeric(args[2])
model     = as.character(args[3])

# For local testing (uncomment below):
# seed = 1; n= 500; model = "logistic"

# Load required packages
pacman::p_load(tibble)

# Load data generation function
source(here::here("Functions/1_data_generation.R"))


# Generate synthetic data
set.seed(seed)

data <- DGP(n = n)

# Fit model based on specified type
if(model == "logistic"){
  fit <- glm(y ~ x, data, family = binomial())
}


if(model == "lm"){
  fit <- glm(y ~ x, data, family = gaussian())
}


# Create results table with estimated coefficients and scenario info
tbl <- tibble(
  # Estimated coefficients
  beta0 = coef(fit)[["(Intercept)"]],
  beta1 = coef(fit)[["x"]],

  # Scenario parameters
  seed  = seed,
  n     = n,
  model = model
)


# Save results to file
save(tbl, file = here::here("HPC/HPC_Results", paste0("seed", seed, "_n", n, "_", model,".Rdata")))



