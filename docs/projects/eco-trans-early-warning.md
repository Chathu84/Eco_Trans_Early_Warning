---
title: Eco-Trans Early Warning
---

# Eco-Trans Early Warning

A reproducible workflow for detecting early warning signals of ecosystem transformation in forested landscapes. The project integrates multi-sensor remote sensing products, statistical feature engineering, and advanced modeling to estimate how much lead time managers have before transitions occur.

## Why it matters

- Forest-to-shrubland conversions are accelerating under drought stress, altered fire regimes, and climate change.
- Reliable early warning signals allow agencies to deploy treatments and restoration crews before resilience thresholds are crossed.
- Open, well-documented tooling ensures results can be validated, extended, and scaled across regions.

## Workflow architecture

1. **Raster ingestion and harmonization** using [`scripts/01_load_rasters.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/01_load_rasters.R) ensures NDVI, soil moisture, drought indices, fire history, and static drivers share a common grid.
2. **Early warning metric extraction** ([`scripts/02_extract_ews_and_drivers.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/02_extract_ews_and_drivers.R)) computes lag-1 autocorrelation, variance, NDVI slope, and fire frequency for each pixel, then assembles a modeling-ready table.
3. **Lead-time modeling** with Bayesian Additive Regression Trees in [`scripts/03_fit_bart_model.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/03_fit_bart_model.R) estimates intervention windows while quantifying variable influence.
4. **Spatial prediction** ([`scripts/04_predict_lead_time_raster.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/04_predict_lead_time_raster.R)) projects model outputs back into raster space for decision-ready mapping.

!!! info "Reproducible pipeline"
    The [`scripts/full_primary_workflow.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/full_primary_workflow.R) script orchestrates the end-to-end process and serves as the fastest way to reproduce results from raw rasters to evaluation metrics.

## Data sources

- **Vegetation:** Annual NDVI stacks covering two decades of seasonal dynamics.
- **Hydroclimate:** Soil moisture, drought indices, and precipitation layers describing resource availability.
- **Disturbance:** Fire history composites capturing frequency and severity prior to transition events.
- **Static drivers:** Elevation, slope, aspect, ecoregion, and soil type inform baseline vulnerability.

## Deliverables

- Harmonized raster archives ready for rapid metric extraction.
- Pixel-level feature tables stored in `output/` for reuse in exploratory analyses.
- BART model objects (`output/bart_model_fit.RData`) and variable importance reports.
- Lead-time prediction rasters for visualization platforms or GIS overlays.

## Roadmap

- Expand the indicator suite with vegetation structure, phenology, and soil moisture anomalies.
- Integrate explainable AI diagnostics to communicate uncertainty to field teams.
- Publish interactive dashboards that pair predictions with management recommendations.

## Get involved

Interested in piloting the workflow in a new region or augmenting it with additional predictors? Open an issue on [GitHub](https://github.com/eco-trans/Eco_Trans_Early_Warning/issues) or connect via the [About page](../about/#connect).
