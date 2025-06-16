# Load and prep data
library(dbarts)
df <- read.csv("output/lead_time_model_data.csv")
df <- na.omit(df)

# Encode factors
df$soil_type <- as.factor(df$soil_type)
df$ecoregion <- as.factor(df$ecoregion)

# Set predictors
predictors <- df %>%
  select(sm_mean, slope, aspect_cos, aspect_sin, elevation, soil_type, ecoregion)

# Convert factor vars to dummies
predictors_matrix <- model.matrix(~ ., data = predictors)[, -1]  # remove intercept

# Fit BART model
set.seed(123)
bart_model <- bart(x.train = predictors_matrix, y.train = df$lead_time)

# Variable importance
print(bart_model$varcount)

# Plot partial dependence for top drivers
library(pdp)

par(mfrow = c(2, 2))
for (varname in c("sm_mean", "slope", "elevation")) {
  pd <- partial(bart_model, pred.var = varname, plot = TRUE)
}
