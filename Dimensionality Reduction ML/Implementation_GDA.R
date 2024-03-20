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

# Etape 5 : Application du GDA
gda_result <- lda(Species~., data=df_normalized)
print(gda_result)

# Etape 6 : Visualisation des résultats
df_gda <- as.data.frame(predict(gda_result)$x)
df_gda$Species <- df$Species

ggplot(df_gda, aes(x=LD1, y=LD2, color=Species)) +
  geom_point() +
  labs(title="GDA Result", x="LD1", y="LD2") +
  theme_minimal()
