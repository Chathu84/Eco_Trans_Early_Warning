# 02_extract_ews_and_drivers.R

source("scripts/01_load_rasters.R")

library(furrr)
library(dplyr)

years <- 2000:2015
transition_year <- 2010  # change if using a different year


compute_ews <- function(ts) {
  if (all(is.na(ts))) return(rep(NA, 3))
  ac1 <- acf(ts, lag.max = 1, plot = FALSE)$acf[2]
  var <- var(ts, na.rm = TRUE)
  slope <- coef(lm(ts ~ seq_along(ts)))[2]
  return(c(ac1 = ac1, variance = var, slope = slope))
}

# Add EWS Year Detection (Simple Thresholding Example)
detect_ews_year <- function(vi_ts, years) {
  ac_series <- sapply(3:(length(vi_ts) - 2), function(i) {
    window <- vi_ts[(i-2):(i+2)]
    if (sum(!is.na(window)) < 4) return(NA)
    acf(window, lag.max = 1, plot = FALSE)$acf[2]
  })
  ews_index <- which(ac_series > 0.6)[1]
  if (!is.na(ews_index)) return(years[ews_index + 2]) else return(NA)
}

get_pixel_features <- function(i) {
  ndvi_ts <- as.numeric(values(ndvi_stack)[i, ])
  sm_ts <- as.numeric(values(soil_moisture_stack)[i, ])
  spei_ts <- as.numeric(values(spei_stack)[i, ])
  trans_val <- values(transition)[i]
  
  if (is.na(trans_val) || trans_val != 1) return(NULL)
  
  ews_year <- detect_ews_year(ndvi_ts, years)
  ews_ndvi <- compute_ews(ndvi_ts)
  if (is.na(ews_year) || ews_year >= transition_year) return(NULL)
  
  lead_time <- transition_year - ews_year
  if (lead_time < 1 || lead_time > 5) return(NULL)
  
  sm_period <- which(years %in% ews_year:transition_year)
  sm_mean <- mean(sm_ts[sm_period], na.rm = TRUE)
  
  spei_period <- which(years %in% ews_year:transition_year)
  spei_mean <- mean(spei_ts[spei_period], na.rm = TRUE)
  
  fire_freq <- sum(!is.na(fire_ts) & fire_ts > 0)
  
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
    ecoregion = as.factor(ecoreg),
    fire_freq = fire_freq,
    ac1 = ews_ndvi[1],
    variance = ews_ndvi[2],
    ndvi_slope = ews_ndvi[3],
    
  ))
}


plan(multisession)
results <- future_map(1:ncell(transition), get_pixel_features, .progress = TRUE)
df <- bind_rows(results)

write.csv(df, "output/lead_time_model_data.csv", row.names = FALSE)

library(mgcv)

# Fit GAM to explain lead time (how early we can detect the transition)
gam_lead <- gam(lead_time ~ s(sm_mean) + s(slope) + s(elevation) + 
                  aspect_cos + aspect_sin +
                  soil_type + ecoregion,
                data = df, family = gaussian)

summary(gam_lead)

