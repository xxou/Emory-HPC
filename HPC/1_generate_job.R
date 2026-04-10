# *****************************************************
#  1. Generate simulation jobs
# *****************************************************

# Number of simulation replicates per scenario
sims = 1000


# Generate parameter grid: all combinations of seed, sample size, and model
param_grid <- expand.grid(seed = 1:sims,
                          n = c(500, 1000, 2000),
                          model = c("logistic","lm")
)


# Create job list: command to run each simulation task
# Format: "Rscript 2_task.R <seed> <n> <model>"
param_grid$joblist<-paste("Rscript 2_task.R",
                          param_grid$seed,
                          param_grid$n,
                          param_grid$model)

# Emory HPC limits: maximum 1000 jobs per job array chunk
# Split total jobs into chunks of at most 1000 jobs each
n_list <- nrow(param_grid) / sims


# Generate job list files (one per chunk)
for (i in 1:n_list) {
  # Calculate row indices for the i-th chunk
  start_row <- ((i - 1) * sims) + 1
  end_row <- i * sims

  # Write job list to a text file for HPC submission
  write.table(param_grid[start_row:end_row, 'joblist'],
            file =here::here("HPC/", paste0("joblist_n",i,".txt")),
            row.names = FALSE, col.names = FALSE, quote = F)
}

