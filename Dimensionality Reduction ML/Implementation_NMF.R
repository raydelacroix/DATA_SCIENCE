# Charger les packages nécessaires
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biobase")

library(NMF)
library(ggplot2)

# Etape 1 : Explorer les données
data(iris)
df <- iris
print(head(df))

# Etape 2 : Rechercher les valeurs nulles
print(sum(is.na(df)))

# Etape 3 : Normaliser les données
# L’erreur que vous rencontrez est due au fait que la factorisation de matrices non négatives (NMF) 
#ne peut pas être appliquée à des matrices contenant des valeurs négatives, car elle repose sur l’hypothèse que toutes les données sont non négatives. 
df_normalized <- df
min_val <- apply(df[-5], 2, min)
max_val <- apply(df[-5], 2, max)
df_normalized[-5] <- sweep(df[-5], 2, min_val, `-`)
df_normalized[-5] <- sweep(df_normalized[-5], 2, max_val - min_val, `/`)

# Etape 4 : Calculer la matrice de corrélation
correlation_matrix <- cor(df_normalized[-5])
print(correlation_matrix)

# Etape 5 : Application de NMF
rank <- 2
nmf_result <- nmf(df_normalized[-5], rank, method = "lee", seed = 123)

# Obtenir la matrice W (base)
W <- basis(nmf_result)

# Etape 6 : Visualisation des résultats
df_nmf <- as.data.frame(W)
df_nmf$Species <- df$Species

ggplot(df_nmf, aes(x=V1, y=V2, color=Species)) +
  geom_point() +
  labs(title="NMF Result", x="Dimension 1", y="Dimension 2") +
  theme_minimal()
