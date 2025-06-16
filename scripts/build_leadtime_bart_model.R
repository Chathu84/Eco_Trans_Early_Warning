# Load packages
library(terra)
library(dbarts)
library(dplyr)
library(furrr)

# Years covered
years <- 2000:2015

# Functions
detect_ews_year <- function(vi_ts, years) {
  ac_series <- sapply(3:(length(vi_ts) - 2), function(i) {
    window <- vi_ts[(i-2):(i+2)]
    if (sum(!is.na(window)) < 4) return(NA)
    acf(window, lag.max = 1, plot = FALSE)$acf[2]
  })
  # Threshold for early warning
  ews_index <- which(ac_series > 0.6)[1]  # adjust threshold as needed
  if (!is.na(ews_index)) return(years[ews_index + 2]) else return(NA)
}

get_pixel_features <- function(i) {
  # Load time series and static variables
  ndvi_ts <- as.numeric(values(ndvi_stack)[i, ])
  sm_ts <- as.numeric(values(soil_moisture_stack)[i, ])
  trans_val <- values(transition)[i]
  
  if (is.na(trans_val) || trans_val != 1) return(NULL)  # Skip non-transition pixels
  
  trans_year <- 2010  # Update if your transition raster year is different
  
  ews_year <- detect_ews_year(ndvi_ts, years)
  if (is.na(ews_year) || ews_year >= trans_year) return(NULL)
  
  lead_time <- trans_year - ews_year
  if (lead_time < 1 || lead_time > 10) return(NULL)
  
  # Mean soil moisture from ews_year to trans_year
  period_idx <- which(years %in% ews_year:trans_year)
  sm_mean <- mean(sm_ts[period_idx], na.rm = TRUE)
  
  # Static environmental variables
  slope_val <- values(slope)[i]
  aspect_val <- values(aspect)[i]
  elev_val <- values(elevation)[i]
  stype <- values(soil_type)[i]
  ecoreg <- values(ecoregion)[i]
  
  return(data.frame(
    pixel = i,
    lead_time = lead_time,
    sm_mean = sm_mean,
    slope = slope_val,
    aspect_cos = cos(aspect_val * pi / 180),
    aspect_sin = sin(aspect_val * pi / 180),
    elevation = elev_val,
    soil_type = as.factor(stype),
    ecoregion = as.factor(ecoreg)
  ))
}

# Extract features
plan(multisession)
results <- future_map(1:ncell(transition), get_pixel_features, .progress = TRUE)
df <- bind_rows(results)

write.csv(df, "output/lead_time_model_data.csv", row.names = FALSE)
