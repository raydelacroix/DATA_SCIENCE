# Charger les packages nécessaires
library(caret)
library(MASS)
library(ggplot2)

# Etape 1 : Explorer les données
data(iris)
df <- iris
print(head(df))

# Etape 2 : Rechercher les valeurs nulles
print(sum(is.na(df)))

# Etape 3 : Normaliser les données
df_normalized <- df
df_normalized[-5] <- scale(df[-5])

# Etape 4 : Calculer la matrice de corrélation
correlation_matrix <- cor(df_normalized[-5])
print(correlation_matrix)

# Etape 5 : Application de SVD
svd_result <- svd(df_normalized[-5])

# Créer un nouveau dataframe avec les résultats de SVD
df_svd <- as.data.frame(svd_result$u[, 1:2])
colnames(df_svd) <- c("SV1", "SV2")

# Assurez-vous que df_svd a le même nombre de lignes que df
if(nrow(df_svd) == nrow(df)) {
  df_svd$Species <- df$Species
}

# Etape 6 : Visualisation des résultats
ggplot(df_svd, aes(x=SV1, y=SV2, color=Species)) +
  geom_point() +
  labs(title="SVD Result", x="SV1", y="SV2") +
  theme_minimal()
