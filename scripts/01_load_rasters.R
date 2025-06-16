# 01_load_rasters.R

library(terra)

#create stack if need

# Load vegetation index stack (NDVI), soil moisture, fire severity
ndvi_stack <- rast("data/ndvi_stack.tif")                  # 2000–2015 (16 layers)
soil_moisture_stack <- rast("data/soil_moisture_stack.tif")# 2000–2015 (16 layers)
spei_stack <- rast("data/spei_stack.tif")# 2000–2015 (16 layers)

# Load transition raster (binary, e.g., transition in 2010)
transition <- rast("data/transition_2010.tif")              # 1 = changed, 0 = no change

# Load static drivers
slope <- rast("data/slope.tif")
aspect <- rast("data/aspect.tif")
elevation <- rast("data/elevation.tif")
soil_type <- rast("data/soil_type.tif")                     # categorical
ecoregion <- rast("data/ecoregion.tif")   
# Fire severity
fire_stack <- rast("data/fire_severity_2000_2015.tif")# categorical

# Check alignmentof all files
ndvi_stack <- align(ndvi_stack, transition)
soil_moisture_stack <- align(soil_moisture_stack, transition)
