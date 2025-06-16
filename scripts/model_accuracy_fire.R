library(dplyr)
library(mgcv)
library(pROC)

df <- read.csv("output/df_model_ready.csv")
df <- na.omit(df)

# Define fire-related transition (e.g., any fire severity > 0)
df <- df %>% mutate(fire_related = ifelse(fire_freq > 0, 1, 0))

# Fit GAM using EWS metrics
gam_mod <- gam(transformed ~ s(ac1) + s(variance) + s(ndvi_slope),
               data = df, family = binomial)

# Predict
df$predicted <- predict(gam_mod, type = "response")

# Evaluate overall
roc_obj <- roc(df$transformed, df$predicted)
print(auc(roc_obj))

# Fire vs Non-fire AUC
roc_fire <- roc(df$transformed[df$fire_related == 1], df$predicted[df$fire_related == 1])
roc_nofire <- roc(df$transformed[df$fire_related == 0], df$predicted[df$fire_related == 0])

cat("AUC (Fire):", auc(roc_fire), "\n")
cat("AUC (Non-Fire):", auc(roc_nofire), "\n")
