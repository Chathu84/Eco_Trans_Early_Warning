# Workflow Overview

This tutorial outlines the primary R scripts that drive the Eco_Trans_Early_Warning analysis pipeline. Use it as a reference for running the project end-to-end or focusing on individual processing stages.

## 1. Load and Prepare Rasters
- **Script**: `scripts/01_load_rasters.R`
- **Purpose**: Aligns NDVI, soil moisture, drought indices, transition labels, fire history, and static driver rasters. Ensures all inputs share a common projection, resolution, and extent.
- **Tips**:
  - Inspect raster metadata before processing to confirm spatial alignment.
  - Cache intermediate rasters in `output/` to avoid repeated expensive reads.

## 2. Extract Early Warning Signals and Drivers
- **Script**: `scripts/02_extract_ews_and_drivers.R`
- **Purpose**: Sources the raster-loading utilities, computes early warning indicators (autocorrelation, variance, NDVI slope), estimates signal emergence, and compiles a pixel-level feature table.
- **Tips**:
  - Review helper functions like `detect_ews_year` and `compute_ews` to understand how indicators are derived.
  - Adjust rolling window parameters to tune sensitivity to transitions.

## 3. Fit Predictive Models
- **Script**: `scripts/03_fit_bart_model.R`
- **Purpose**: Trains a Bayesian Additive Regression Trees (BART) model on engineered features to predict lead time before transitions.
- **Tips**:
  - Experiment with hyperparameters such as the number of trees to balance accuracy and interpretability.
  - Evaluate partial dependence plots to interpret driver effects.

## 4. Generate Spatial Predictions
- **Script**: `scripts/04_predict_lead_time_raster.R`
- **Purpose**: Projects BART predictions back onto raster space, creating spatial maps of anticipated lead time.
- **Tips**:
  - Validate predictions against held-out regions or historical events.
  - Export GeoTIFF outputs to share with collaborators.

## 5. Run the Full Workflow
- **Script**: `scripts/full_primary_workflow.R`
- **Purpose**: Integrates all steps to deliver a reproducible pipeline from raw rasters to prediction maps and evaluation metrics.
- **Tips**:
  - Start with a small spatial subset to verify the pipeline before scaling up.
  - Consider orchestrating the workflow with `targets` or `drake` for large-scale automation.

