---
title: Lead time prediction suite
---

# Lead time prediction suite

A modeling toolkit that quantifies how long managers have to act before a transition completes. By pairing Bayesian Additive Regression Trees with interpretable summaries, the suite uncovers which environmental drivers most influence warning lead times.

## Components

- **Model training:** [`scripts/03_fit_bart_model.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/03_fit_bart_model.R) ingests the engineered feature table, encodes categorical predictors, and fits a `dbarts` model with reproducible seeds.
- **Scenario exploration:** Supplementary scripts such as [`scripts/bart_to_predict.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/bart_to_predict.R) and [`scripts/prediction_sup2.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/prediction_sup2.R) apply the trained model to new data, enabling what-if analyses.
- **Spatial projection:** [`scripts/04_predict_lead_time_raster.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/04_predict_lead_time_raster.R) converts predictions back to raster products for mapping and reporting.

## Why BART?

BART handles non-linear interactions and mixed data types while providing uncertainty-aware predictions. Variable inclusion counts expose which predictors—such as slope, soil type, or drought intensity—consistently drive lead-time changes.

!!! tip "Interpreting outputs"
    Inspect the saved `output/bart_model_fit.RData` object to explore partial dependence, variable importance, and posterior predictive intervals.

## Deliverables

- Clean modeling matrix with categorical encoding for soil type and ecoregion.
- Serialized BART model suitable for reproducible deployment.
- Lead-time rasters ready for ingestion into dashboards or GIS workflows.
- Documentation for extending the model with new predictor sets.

## Future enhancements

- Integrate cross-validated hyperparameter tuning to balance accuracy and runtime.
- Add interpretability notebooks highlighting spatial hotspots of short warning windows.
- Package deployment scripts for cloud or batch processing environments.

Use this suite when you need defensible, data-driven estimates of when ecological change will occur—and how to prioritize interventions before it does.
