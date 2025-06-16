# 03_fit_bart_model.R

library(dbarts)
library(dplyr)

df <- read.csv("output/lead_time_model_data.csv")
df <- na.omit(df)

df$soil_type <- as.factor(df$soil_type)
df$ecoregion <- as.factor(df$ecoregion)

predictors <- df %>%
  select(sm_mean, slope, aspect_cos, aspect_sin, elevation, soil_type, ecoregion)

X <- model.matrix(~ ., data = predictors)[, -1]  # no intercept
Y <- df$lead_time

set.seed(123)
bart_model <- bart(x.train = X, y.train = Y)

save(bart_model, file = "output/bart_model_fit.RData")

# Variable importance summary
print(bart_model$varcount)
