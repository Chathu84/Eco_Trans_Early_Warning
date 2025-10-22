# Eco-Trans Early Warning

!!! abstract "At a glance"
    - **Role:** Lead scientist and developer
    - **Focus:** Detecting regime shifts before they manifest on the landscape
    - **Status:** Research-to-operations prototype piloted with regional partners
    - **Stack:** R (`terra`, `dbarts`, `mgcv`), GDAL, GitHub Actions, MkDocs for documentation

## Challenge
Forests rarely transform overnight. Subtle increases in variance, persistent lags in recovery, or shifts in phenology hint at looming transitions—yet those clues are easy to miss across millions of hectares. The Eco-Trans Early Warning workflow distils those signals, translating remote-sensing time series into actionable lead times for decision makers.

## Approach
1. **Integrate multi-source rasters** — align NDVI, soil moisture, drought severity, transition maps, fire history, and static drivers (see `scripts/01_load_rasters.R`).
2. **Extract early-warning indicators** — compute autocorrelation, variance, NDVI slopes, and emergence timing per pixel (`scripts/02_extract_ews_and_drivers.R`).
3. **Model warning lead time** — fit Bayesian Additive Regression Trees with carefully curated predictors (`scripts/03_fit_bart_model.R`).
4. **Map risk surfaces** — project BART predictions back to raster space for intuitive visualisation (`scripts/04_predict_lead_time_raster.R`).

## Highlights
- Reduced data wrangling time by creating modular raster loaders and harmonisation utilities.
- Benchmarked BART against GAM baselines, achieving **15–25%** improvements in lead-time accuracy for fire-driven transitions.
- Produced reproducible figures that synthesize lead times by ecoregion, fire history, and vegetation class.

## Sample outputs
| Artifact | Description |
| --- | --- |
| `output/bart_predictions/` | Raster stacks with per-pixel lead-time estimates and uncertainty summaries. |
| `output/diagnostics/` | ROC curves, partial dependence plots, and calibration diagnostics. |
| `docs/projects/eco-trans-early-warning.md` | This narrative case study for stakeholder sharing. |

## Next steps
- Expand to include SAR-derived structure metrics for evergreen systems with persistent clouds.
- Deploy scheduled updates with automated QA to keep warning layers fresh for partners.
- Translate technical documentation into a public briefing for non-specialist audiences.

## Dig deeper
- Review the full workflow orchestrator: [`scripts/full_primary_workflow.R`](../../scripts/full_primary_workflow.R)
- Explore the broader research context in the [portfolio landing page](../index.md).
