# 04_predict_lead_time_raster.R

library(terra)
library(dbarts)

# Load trained model
load("output/bart_model_fit.RData")

# Load predictor rasters
stack_predictors <- c(
  rast("data/sm_mean_raster.tif"),
  rast("data/slope.tif"),
  rast("data/aspect_cos.tif"),
  rast("data/aspect_sin.tif"),
  rast("data/elevation.tif"),
  rast("data/soil_type_dummies.tif"),
  rast("data/ecoregion_dummies.tif")
)

vals <- as.data.frame(terra::values(stack_predictors))
vals_complete <- na.omit(vals)

# Predict
preds <- predict(bart_model, newdata = vals_complete)

# Reconstruct raster
lead_time_raster <- rast(stack_predictors, nlyrs = 1)
lead_time_raster[] <- NA
lead_time_raster[!is.na(vals$sm_mean)] <- rowMeans(preds)

writeRaster(lead_time_raster, "output/predicted_lead_time.tif", overwrite = TRUE)
