# Load fitted BART model
load("output/bart_model_fit.RData")

# Stack of predictor rasters (align these with model variables)
stack_predictors <- c(sm_mean_raster, slope, aspect_cos, aspect_sin, elevation,
                      soil_type_dummies, ecoregion_dummies)

# Convert to data frame
vals <- as.data.frame(terra::values(stack_predictors))
vals_complete <- na.omit(vals)

# Predict lead time
predicted_lt <- predict(bart_model, newdata = vals_complete)

# Create empty raster and insert predictions
lead_time_raster <- rast(stack_predictors, nlyrs = 1)
lead_time_raster[] <- NA
lead_time_raster[!is.na(vals$sm_mean)] <- rowMeans(predicted_lt)  # mean of posterior draws

writeRaster(lead_time_raster, "output/predicted_lead_time.tif", overwrite = TRUE)
