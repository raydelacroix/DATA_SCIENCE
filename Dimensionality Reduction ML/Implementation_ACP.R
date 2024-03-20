# Etape 1: Explorer les données
# Charger les données iris
data(iris)
head(iris)  # Afficher les premières lignes du dataset pour l'explorer

# Etape 2: Rechercher les valeurs nulles
sapply(iris, function(x) sum(is.na(x)))  # Rechercher les valeurs nulles dans le dataset

# Etape 3: Normaliser les données
iris_scaled <- scale(iris[,1:4])  # Normaliser les données en utilisant la fonction scale

# Etape 4: Calculer la matrice de corrélation
cor_matrix <- cor(iris_scaled)  # Calculer la matrice de corrélation des données normalisées

# Etape 5: Application de PCA et ACP
# PCA
iris_pca <- prcomp(iris_scaled)
summary(iris_pca)  # Afficher un résumé des résultats de la PCA

# ACP (Analyse en Composantes Principales)
library(FactoMineR)
res_acp <- PCA(iris_scaled, graph=FALSE)  # Effectuer l'ACP
summary(res_acp)  # Afficher un résumé des résultats de l'ACP
