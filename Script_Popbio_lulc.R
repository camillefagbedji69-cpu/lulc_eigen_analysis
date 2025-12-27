##Projet de matrice de transition

#Import des packages 

library(terra)
library(dplyr)
library(popbio)


##import des rasters 

raster_2015 <- rast("~/Mémoire Master 2025-2026/Data_folder/Rasters/Test/LULC_2015.tif")

raster_2019 <- rast("~/Mémoire Master 2025-2026/Data_folder/Rasters/Test/LULC_2019.tif")

##matrice de transition 

mat_transition <- crosstab(c(raster_2015, raster_2019))


ct <- as.matrix(mat_transition)

# si crosstab_result est un data frame
M <- matrix(as.numeric(ct), 
            nrow = nrow(ct),
            ncol = ncol(ct),
            byrow = TRUE)

##Normalisation 

P <- M / rowSums(M)

##Analyse matricielle

eigen.analysis(P)

##Import des rasters de carbone 

carbone_2015 <- rast("~/Mémoire Master 2025-2026/Data_folder/Rasters/Test/Invest_2015/c_storage_bas.tif")

carbone_2019 <- rast("~/Mémoire Master 2025-2026/Data_folder/Rasters/Test/Invest_2019/c_storage_bas.tif")

## Différence de carbone 

diff_C <- carbone_2019 - carbone_2015

##transition raster 

transi_raster <- raster_2015 * 1000 + raster_2019

##data 

df <- data.frame(transitions = values(transi_raster), 
                 carbone_diff = values(diff_C))

anyNA(df)

##groupage par transition 

transition_summary <- df %>%
  group_by(discrete_classification) %>%
  summarise(
    mean_diff = mean(c_storage_bas),
    total_diff = sum(c_storage_bas),
    n_pixels = n()
  ) %>%
  mutate(
    LULC_2015 = discrete_classification %/% 1000,
    LULC_2019 = discrete_classification %% 1000
  ) 

transition_summary <- as.data.frame(transition_summary)


##Heatmap

library(ggplot2)

# Transformer LULC en facteur pour garder l'ordre
transition_summary$LULC_2015 <- factor(transition_summary$LULC_2015)


transition_summary$LULC_2019 <- factor(transition_summary$LULC_2019)

# Heatmap avec total_diff

ggplot(transition_summary, aes(x = LULC_2015, y = LULC_2019, fill = total_diff)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "red", mid = "white", high = "darkgreen", 
                       midpoint = 0, name = "Δ Carbone") +
  theme_minimal() +
  labs(title = "Transitions LULC et changement de carbone (2015→2019)",
       x = "Classe LULC 2015",
       y = "Classe LULC 2019") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


## matrice de transition 

mat_carre <- transition_summary %>%
  dplyr::select(LULC_2015, LULC_2019, total_diff) %>%
  pivot_wider(
    names_from = LULC_2019,
    values_from = total_diff,
    values_fill = 0
  ) %>%
  column_to_rownames("LULC_2015") %>%
  as.matrix()

## Matrice gain 

mat_gain <- mat_carre

mat_gain [mat_gain < 0] <- 0

mat_gain_nonzero <- mat_gain[rowSums(mat_gain) > 0, colSums(mat_gain) > 0]

mat_gain_norm <- mat_gain_nonzero/rowSums(mat_gain_nonzero)

eigen.analysis(mat_gain_norm)

