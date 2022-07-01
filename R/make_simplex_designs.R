
# Generate simplex designs ------------------------------------------------

library(mixexp)

# Make a simplex-lattice design ------------------------------------------
simplex_lattice_desing <- SLD(
  fac = 3, # Number of components (factors)
  lev = 2  # Number of levels besides 0
)

# Display the design
simplex_lattice_desing

# Visualize the design experimental region
DesignPoints(simplex_lattice_desing)

# Export the design
write.csv(
  simplex_lattice_desing, file = "data/simplex_lattice_desing.csv", 
  row.names = FALSE
)

# Make a simplex-centroid design -------------------------------------------
simplex_centroid_design <- SCD(
  fac = 3  # Number of components (factors)
)

# Export the design
write.csv(
  simplex_centroid_design, file = "data/simplex_centroid_design.csv", 
  row.names = FALSE
  )

# Display the design
simplex_centroid_design

# Visualize the design experimental region
DesignPoints(simplex_centroid_design)

# Make a mixture design with restrictions -----------------------------------
simplex_restrictions <- Xvert(
  nfac = 3,                       # Number of components (maximum 12)
  uc   = c(0.612, 0.765, 0.109),  # Upper constrains
  lc   = c(0.153, 0.306, 0.053),  # Lower constrains
  plot = FALSE,                   # Automatic plot when TRUE and nfac = 3
  ndm  = 1                        # Order of centroids included
)

# Export the design
write.csv(
  simplex_restrictions, file = "data/simplex_restrictions.csv", 
  row.names = FALSE
  )

# Display the design
simplex_restrictions

# Visualize the design
DesignPoints(simplex_restrictions)