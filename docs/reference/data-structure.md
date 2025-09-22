# Data and Output Structure

Understanding the repository layout makes it easier to locate inputs, intermediate artifacts, and final results.

## `data/`
Stores raw and preprocessed raster inputs, including NDVI, soil moisture, drought metrics, land-transition labels, historical fire data, and static environmental drivers.

## `output/`
Holds derived artifacts produced by the workflow, such as cleaned rasters, extracted feature tables, model fits, and prediction maps. Intermediate caches can also be saved here to accelerate repeated analyses.

## `scripts/`
Contains the R scripts that implement data processing, feature engineering, modeling, and prediction steps. See the [Workflow Overview](../tutorials/workflow-overview.md) tutorial for details on each script.

## Suggested Additions
Consider adding the following folders as the project grows:
- `docs/` — houses MkDocs documentation pages (this site).
- `reports/` — stores rendered notebooks or analytical summaries.
- `config/` — captures parameter files or environment settings for reproducibility.

