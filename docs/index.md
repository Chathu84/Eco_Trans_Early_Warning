# Eco Trans Early Warning

Welcome to the documentation site for the Eco_Trans_Early_Warning project. This initiative focuses on detecting early warning signals of ecosystem transformations using remote sensing data products and statistical learning techniques.

## Project Goals
- Integrate multi-source remote sensing rasters (NDVI, soil moisture, drought indices, transition maps, fire history, and static drivers).
- Derive early warning indicators such as autocorrelation, variance, and vegetation trends to anticipate ecosystem changes.
- Model warning lead times with Bayesian Additive Regression Trees (BART) and Generalized Additive Models (GAMs).
- Produce spatial predictions that highlight areas at risk of rapid ecological transitions.

## Repository Highlights
- **Data management**: Raster inputs reside in the `data/` directory, while processed artifacts and model outputs are stored in `output/`.
- **Reproducible scripts**: The `scripts/` folder contains modular R scripts for loading data, engineering features, training models, and generating predictions.
- **End-to-end workflow**: `scripts/full_primary_workflow.R` orchestrates the key analytical steps for reproducibility.

## Getting Started
1. Review the tutorials in this documentation to understand how to run the workflow end-to-end.
2. Ensure required R packages (including `terra`, `dbarts`, and `mgcv`) are installed.
3. Update paths in the scripts to match your local raster data locations.
4. Execute the primary workflow script or individual stages as needed.

## Further Reading
- [Early warning signals in ecological systems](https://doi.org/10.1016/j.tree.2015.05.009)
- [Bayesian Additive Regression Trees](https://projecteuclid.org/journals/annals-of-applied-statistics/volume-4/issue-1/Bayesian-additive-regression-trees/10.1214/09-AOAS285.short)

