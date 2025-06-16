library(terra)

# List all files
file_list <- list.files("data/ndvi_annual", pattern = "\\.tif$", full.names = TRUE)

# Extract years using regex (assuming year is in filename)
extract_year <- function(f) {
  as.numeric(stringr::str_extract(basename(f), "\\d{4}"))
}


###if years need to extract using substring: 
# Extract year using substr (characters 9 to 12)
years <- as.numeric(substr(basename(file_list), 9, 12))
years <- sapply(file_list, extract_year)

# Check extracted years
print(years)


# Sort files and years together
sorted_index <- order(years)
file_list_sorted <- file_list[sorted_index]
years_sorted <- years[sorted_index]


ndvi_stack <- rast(file_list_sorted)
names(ndvi_stack) <- paste0("NDVI_", years_sorted)


print(names(ndvi_stack))      # Layer names
plot(ndvi_stack[[1]])         # First year
plot(ndvi_stack[[length(years_sorted)]])  # Last year


##### to check after sctacking

years_assigned <- as.numeric(stringr::str_extract(names(ndvi_stack), "\\d{4}"))
print(diff(years_assigned))  # Should be all 1s for sequential years
