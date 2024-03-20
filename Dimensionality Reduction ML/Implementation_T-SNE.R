# Charger les bibliothèques nécessaires
library(Rtsne)
library(ggplot2)
library(gridExtra)
#install.packages("gridExtra")

# Charger les données depuis le fichier CSV
data <- read.csv("C:/Users/ray/Documents/data/protein.csv")

# Séparer les étiquettes de classe
labels <- data$Country
data <- data[, -1]  # Supprimer la colonne des étiquettes

# Appliquer PCA
pca_result <- prcomp(data, center = TRUE, scale. = TRUE)

# Appliquer t-SNE
tsne_result <- Rtsne(data, dims = 2, perplexity = 5, verbose = TRUE)

# Créer un dataframe avec les résultats de PCA et t-SNE
pca_df <- data.frame(x = pca_result$x[, 1], y = pca_result$x[, 2], label = labels)
tsne_df <- data.frame(x = tsne_result$Y[, 1], y = tsne_result$Y[, 2], label = labels)

# Créer les graphiques pour PCA et t-SNE
pca_plot <- ggplot() +
  geom_point(data = pca_df, aes(x = x, y = y, color = label), size = 3) +
  labs(title = "PCA") +
  theme_minimal() +
  theme(legend.position = "none")

tsne_plot <- ggplot() +
  geom_point(data = tsne_df, aes(x = x, y = y, color = label), size = 3) +
  labs(title = "t-SNE") +
  theme_minimal() +
  theme(legend.position = "none")

# Afficher les graphiques côte à côte
grid.arrange(pca_plot, tsne_plot, ncol = 2)

View(data)
