
# Data Analysis for mixture designs ------------------------------------------


# Import data -----------------------------------------------------------
data_sausage <- read.csv("data/data_sausage.csv")

# Display the data
data_saudage


# Model adjustment --------------------------------------------------------

# with lm() function
# -1 indicates to skip the intercept 
hardness_model_lm <- lm(
  Hardness ~ -1 + MCC + RS + OF + MCC:RS + RS:OF + MCC:OF + MCC:RS:OF, # Model
  data = data_sausage
)

# with MixModel() function
hardness_model_mm <- MixModel(
  frame = data_sausage,                # Data
  response = "Hardness",               # Response name   
  mixcomps = c("MCC", "RS", "OF"),     # Factor names
  model = 4                            # Model to be fit, type ?MixModel
)


# Model coefficients, their interpretation and determination coeff --------

# Display a summary
summary(hardness_model_lm)

# Export summary as a TXT file
capture.output(
  summary(hardness_model_lm),
  file = "data/sum_hardness_model.txt"
)


# step() function to improve the model ------------------------------------

step(hard_mod_3)

# Export results for step()
capture.output(
  step(hardness_model_lm),
  file = "data/step_results.txt"
)

# Fit simplified model model
hardness_model_simp <- lm(
  Hardness ~ -1 + MCC + RS + OF + MCC:RS + MCC:OF,
  data = data_sausage
)

# Export summary
capture.output(
  summary(hardness_model_simp),
  file = "data/sum_hardness_simplified_model.txt"
)

# Display summary
summary(hardness_model_simp)

# Lack-of-fit test ----------------------------------------------------------

library(alr3)

## For complete model
lof_complete_hardness_model <- pureErrorAnova(hardness_model_lm)

# Export results
write.csv(
  lof_complete_hardness_model, 
  file = "data/lof_complete_hardness_model.csv", na = ""
  )

# Display ANOVA
lof_complete_hardness_model


## For simplified model
lof_simp_hardness_model <- pureErrorAnova(hardness_model_simp)

# Export results
write.csv(
  lof_simp_hardness_model, 
  file = "data/lof_simp_hardness_model.csv", na = ""
  )

# Display ANOVA
lf_simp_hardness_model


#  Visualization of the simplified model in two dimensions ----------------

## Contour pplot for simplified model
ModelPlot(
  hardness_model_simp,                                  # Our model
  dimensions = list(x1 = "MCC", x2 = "RS", x3 = "OF"),  # Variable names
  contour = TRUE,                                       # Add contour lines
  fill = TRUE,                                          # Add color
  axislabs = c("MCC", "RS", "OF"),                      # Axis labels
  cornerlabs = c("MCC", "RS", "OF")                     # Corner labels
)

# Save the graph as a png file
png("graphs/contour_hardnees_model.png", 
    units = "cm", width = 15, height = 10, res = 150)
ModelPlot(
  hardness_model_simp,                                  # Our model
  dimensions = list(x1 = "MCC", x2 = "RS", x3 = "OF"),  # Variable names
  contour = TRUE,                                       # Add contour lines
  fill = TRUE,                                          # Add color
  axislabs = c("MCC", "RS", "OF"),                      # Axis labels
  cornerlabs = c("MCC", "RS", "OF")                     # Corner labels
)
dev.off()

## Effect plot for complete model
ModelEff(
  nfac = 3,                   # Number of components (factors)
  mod  = 4,                   # Type of model, type ?MixModel for more information
  ufunc = hardness_model_mm   # Model fitted by MixModel() function
)

# Save the graph as a png file
png("graphs/effects_hardnees_model.png", 
    units = "cm", width = 15, height = 10, res = 150)
ModelEff(
  nfac = 3,                   # Number of components (factors)
  mod  = 4,                   # Type of model, type ?MixModel for more information
  ufunc = hardness_model_mm   # Model fitted by MixModel() function
)
dev.off()

