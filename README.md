# Eco_Trans_Early_Warning
Detection of early warning signs of ecosystem transformations using remote sensing

## Repository Overview
- **Core directories**: `data/` stores raster inputs, `output/` holds intermediate artifacts and model results, and `scripts/` contains the analysis workflow.
- **Primary workflow scripts**:
  - `scripts/01_load_rasters.R` loads and aligns NDVI, soil moisture, drought, transition, fire, and static driver rasters that support later processing steps.
  - `scripts/02_extract_ews_and_drivers.R` sources the raster loaders, computes early warning signals (autocorrelation, variance, NDVI slope), estimates signal emergence, and compiles pixel-level feature tables—including static drivers and fire frequency—before fitting an exploratory GAM for lead time.
  - `scripts/03_fit_bart_model.R` trains a Bayesian Additive Regression Trees (BART) model on the engineered features to predict warning lead times and saves the fitted model.
  - `scripts/04_predict_lead_time_raster.R` projects model predictions back into raster space for mapping.
- **End-to-end example**: `scripts/full_primary_workflow.R` ties together metric extraction, GAM modeling, and ROC evaluation with fire vs. non-fire stratification for reproducing the core analysis.
- **Supporting scripts**: variations such as `build_leadtime_bart_model.R`, `model_accuracy_fire.R`, `prediction_sup2.R`, and `bart_to_predict.R` explore alternate feature sets, diagnostics, accuracy comparisons, and partial dependence visualization.

## Next Steps for Newcomers
- Become familiar with the `terra` package for raster I/O, alignment, and pixel-wise time series extraction.
- Review early warning theory (autocorrelation, variance, NDVI trend) and how it is implemented through functions like `detect_ews_year` and `compute_ews`.
- Explore `dbarts` and `mgcv` to understand how Bayesian Additive Regression Trees and Generalized Additive Models are used to interpret environmental drivers and lead-time predictions.
- Investigate how fire dynamics are handled, as several scripts stratify analyses by fire vs. non-fire transitions.
- Consider automating the pipeline once comfortable (e.g., with `targets` or `drake`) and replace placeholder raster paths with actual datasets for reproducible large-scale processing.
