# Emory HPC R Simulation Example

A sample R project demonstrating how to run large-scale simulation studies on the Emory University High Performance Computing (HPC) cluster.

## Overview

This project provides a template for running simulation studies on Emory HPC. It demonstrates:
- Generating parameter grids for simulation studies
- Submitting jobs to the HPC cluster in chunks
- Running R scripts as parallel tasks
- Collecting and summarizing results


## Research Questions

This project investigates the performance of logistic regression and linear regression for analyzing binary outcomes. We simulate data across three sample sizes (500, 1000, 2000) and evaluate the estimated regression coefficients. Each scenario is replicated 1000 times.


## Directory Structure

```
Emory-HPC/
├── Functions/
│   └── 1_data_generation.R   # Data generating process (DGP) function
├── HPC/
│   ├── 1_generate_job.R      # Generate job list files for HPC submission
│   ├── 2_task.R              # Main task script (runs one simulation)
│   ├── 3_summarize_results.R # Collect and summarize all results
│   ├── joblist_n*.txt        # Job list files (generated)
│   └── HPC_Results/          # Output directory for simulation results
├── Analysis/                 # Placeholder for post-hoc analysis scripts
├── report/                   # Placeholder for reports/figures
└── Emory-HPC.Rproj           # RStudio project file
```

