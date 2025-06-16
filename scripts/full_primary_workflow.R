library(terra)
library(dplyr)
library(mgcv)
library(pROC)
library(randomForest)
library(furrr)        # for parallel raster operations

#Step 1: Compute EWS Metrics (AC1, Var, Slope)

compute_ews_metrics <- function(vi_ts) {
  # Exclude NA
  if (all(is.na(vi_ts))) return(c(NA, NA, NA))
  
  ac1 <- acf(vi_ts, lag.max = 1, plot = FALSE)$acf[2]
  var <- var(vi_ts, na.rm = TRUE)
  slope <- coef(lm(vi_ts ~ seq_along(vi_ts)))[2]
  
  return(c(ac1 = ac1, variance = var, ndvi_slope = slope))
}

#Step 2: Extract Data at Each Pixel
# Assume all rasters aligned and in same CRS
trans_year <- rast("transition_year.tif")
ndvi_stack <- rast("ndvi_2001_2020.tif")  # time stack of NDVI
fire_stack <- rast("fire_2001_2020.tif")
precip <- rast("precip_mean.tif")
slope <- rast("slope.tif")

# Initialize output list
results <- list()

# For each pixel (or chunk via terra::app)
extract_metrics <- function(cell_index) {
  ty <- values(trans_year)[cell_index]
  if (is.na(ty) || ty < 2005 || ty > 2018) return(rep(NA, 8))
  
  # Extract NDVI time series before transition
  years <- 2001:(ty - 1)
  ndvi_ts <- values(ndvi_stack[[which(2001:2020 %in% years)]])[cell_index, ]
  
  # Compute EWS
  metrics <- compute_ews_metrics(ndvi_ts)
  
  # Fire frequency before transition
  fire_years <- which(2001:2020 %in% years)
  fire_ts <- values(fire_stack[[fire_years]])[cell_index, ]
  fire_freq <- sum(fire_ts, na.rm = TRUE)
  
  # Static drivers
  pcp <- values(precip)[cell_index]
  slp <- values(slope)[cell_index]
  
  return(c(metrics, fire_freq = fire_freq, precip = pcp, slope = slp, trans_year = ty))
}

# Apply across pixels (use terra::app or purrr/furrr)
plan(multisession)
results <- future_map_dfr(1:ncell(trans_year), extract_metrics, .progress = TRUE)


# Step 3: Label Fire/Non-Fire Transitions
results <- results %>%
  mutate(transformed = !is.na(trans_year),
         fire_related = ifelse(fire_freq >= 1, 1, 0))


#Step 4: Fit Prediction Model Using EWS
# Remove NA
df <- na.omit(results)

gam_model <- gam(transformed ~ s(ac1) + s(variance) + s(ndvi_slope),
                 data = df, family = binomial)

summary(gam_model)


#Step 5: Evaluate Prediction Accuracy by Fire Class
df$predicted <- predict(gam_model, type = "response")

# ROC AUC overall
roc_obj <- roc(df$transformed, df$predicted)
auc(roc_obj)

# Stratified AUC
roc_fire <- roc(df$transformed[df$fire_related == 1], df$predicted[df$fire_related == 1])
roc_nofire <- roc(df$transformed[df$fire_related == 0], df$predicted[df$fire_related == 0])

auc(roc_fire)    # how well EWS predicts fire-driven transitions
auc(roc_nofire)  # how well EWS predicts non-fire transitions
