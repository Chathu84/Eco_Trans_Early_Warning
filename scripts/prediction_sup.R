

library(mgcv)


##A. Predicting EWS Timing
#Use linear or non-linear models (e.g., GAM) to understand what factors correlate with earlier EWS detection.
# Predict lead time of EWS
gam_ews <- gam(lead_time ~ s(fire_freq_pre) + s(precip_pre) + s(biomass_pre) + s(slope),
               data = df, family = gaussian)
summary(gam_ews)
plot(gam_ews, pages = 1)


#Tranformation prediction

gam_transition <- gam(transformed ~ s(fire_freq_pre) + s(precip_pre) + s(biomass_pre),
                      data = df, family = binomial)

#can add ews metrics ToothGrowth
gam_transition2 <- gam(transformed ~ s(lead_time) + s(ndvi_slope) + s(fire_freq_pre) + s(biomass_pre),
                       data = df, family = binomial)

#causal factors:

library(bnlearn)

df_bn <- df[, c("lead_time", "fire_freq_pre", "precip_pre", "slope", "transformed")]
bn_structure <- hc(df_bn)  # Hill-Climbing structure learning
plot(bn_structure)
