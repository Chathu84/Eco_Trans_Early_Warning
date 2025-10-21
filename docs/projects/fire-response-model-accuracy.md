---
title: Fire-response model accuracy
---

# Fire-response model accuracy

How do early warning indicators behave when forest transitions are driven by fire? This project examines model performance across disturbance regimes to ensure alerts remain trustworthy in dynamic, high-severity environments.

## Objectives

- Quantify the predictive power of early warning metrics for fire-related versus non-fire transitions.
- Identify gaps where additional indicators or recalibrated models are required.
- Provide actionable diagnostics for teams planning mitigation and recovery strategies.

## Analytical approach

1. **Labeling fire pathways:** [`scripts/model_accuracy_fire.R`](https://github.com/eco-trans/Eco_Trans_Early_Warning/blob/main/scripts/model_accuracy_fire.R) classifies pixels as fire-related when pre-transition fire frequency exceeds zero, using data assembled in `output/df_model_ready.csv`.
2. **Generalized additive modeling:** `mgcv::gam` fits smooth relationships between autocorrelation, variance, NDVI slope, and transition likelihood.
3. **Performance evaluation:** Stratified ROC curves generated with `pROC` reveal how accuracy differs between fire and non-fire contexts.

!!! note "Key outputs"
    The script prints overall AUC along with class-specific scores. These diagnostics guide whether to tune thresholds, add new predictors, or spin up custom models for fire-adapted landscapes.

## Insights so far

- Fire-driven transitions often exhibit sharper increases in variance and NDVI slope magnitude, requiring flexible smoothers to capture non-linear effects.
- Non-fire transitions benefit from early detection of subtle autocorrelation shifts, highlighting the value of multi-metric monitoring.
- Stratified reporting uncovers where intervention windows are shorter, informing resource allocation for prescribed burns or restoration.

## Next steps

- Extend the analysis with spatial cross-validation to assess regional generalizability.
- Compare GAM results with tree-based classifiers to balance interpretability and raw predictive power.
- Integrate forecast-ready visualizations that communicate confidence intervals to field partners.

Interested in adapting the evaluation to your disturbance regime? Start with the documented script, then customize metrics or thresholds to suit your landscape.
