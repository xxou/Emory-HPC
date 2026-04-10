# ******************************************
#  3. Summarize simulation results
# ******************************************

sims = 1000

# Reconstruct parameter grid to match job specifications
param_grid <- expand.grid(seed = 1:sims,
                          n = c(500, 1000, 2000),
                          model = c("logistic","lm")
)

# Construct expected output filenames
param_grid$file_name <-paste0("seed", param_grid$seed,
                              "_n",   param_grid$n,
                              "_",    param_grid$model,
                              ".Rdata")


# For failed jobs: create rerun commands
param_grid$rerun_name<-paste("Rscript 2_task.R",
                             param_grid$seed,
                             param_grid$n,
                             param_grid$model)


# Load all results, handling potential job failures
AllResults<- list()
false_index = c()

for (i in 1:dim(param_grid)[1]) {

  file_name = param_grid$file_name[i]

  # Attempt to load the data file
  load_status <- tryCatch({
    load(here::here("HPC/HPC_Results", file_name))
    TRUE
  }, error = function(e) {
    FALSE
  })

  if(load_status==F){
    false_index = c(false_index,i)
  }


  if (load_status) {
    AllResults[[i]] = tbl
  }
}


# Save combined results
save(AllResults, file = here::here("HPC/HPC_Results", "AllResults.Rdata"))

# Write list of failed jobs for rerunning
write.table(unique(param_grid[false_index, 'rerun_name']),
            file = here::here("HPC", "rerun1.txt"),
            row.names = FALSE, col.names = FALSE, quote = F)
