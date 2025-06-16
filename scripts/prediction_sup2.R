library(earlywarnings)

ndvi_ts <- ts(df$ndvi_ts, frequency = 1)
ews <- generic_ews(ndvi_ts[1:(trans_year - 1)],
                   indicators = c("variance", "autocor", "skewness"))


#classifier to detect transformation
glm_ews <- glm(transformed ~ autocor + variance + ndvi_slope,
               data = df, family = binomial)

#baysian to detect transformation

library(mgcv)
gam_ews <- gam(transformed ~ s(autocor) + s(variance) + s(ndvi_slope),
               data = df, family = binomial)


#Accuracy

#Compute Metrics:

library(pROC)

df$predicted <- predict(gam_ews, type = "response")
roc_obj <- roc(df$transformed, df$predicted)
auc(roc_obj)       # AUC


#B. Threshold-Based Accuracy:
conf <- table(Predicted = df$predicted > 0.5, Actual = df$transformed)
accuracy <- sum(diag(conf)) / sum(conf)

###fire non-fire

df_fire <- subset(df, fire_related == 1)
df_nofire <- subset(df, fire_related == 0)

# AUC for each
roc_fire <- roc(df_fire$transformed, predict(gam_ews, newdata = df_fire, type = "response"))
roc_nofire <- roc(df_nofire$transformed, predict(gam_ews, newdata = df_nofire, type = "response"))

auc(roc_fire)
auc(roc_nofire)

# You can also perform statistical tests to compare AUCs (e.g., DeLong test):
roc.test(roc_fire, roc_nofire)

