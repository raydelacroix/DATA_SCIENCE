#############Exemple concret de PCA dans R

#installation paquet corrr
#install.packages("corrr")
library('corrr')

#installation Paquet ggcorrplot
#install.packages("ggcorrplot")
library(ggcorrplot)

#Package FactoMineR
####Principalement utilisé pour l'analyse de données
####exploratoires multivariées ; le package factoMineR 
#####donne accès au module PCA pour effectuer une analyse en composantes principales. 
#install.packages("FactoMineR")
library("FactoMineR")



#####Etqpe 1 : Explorer les données
protein_data <- read.csv("C:/Users/ray/Documents/data/protein.csv")
str(protein_data)

#####Etqpe 2 : Rechercher les valeurs nulles 

colSums(is.na(protein_data))


####Etapes 3: Normaliser les données
numerical_data <- protein_data[,2:10]

head(numerical_data)
############Désormais, la normalisation peut être appliquée à l’aide de la fonction scale(). 
data_normalized <- scale(numerical_data)
head(data_normalized)


#Etape 4 Calculer la matrice de corrélation
corr_matrix <- cor(data_normalized)
ggcorrplot(corr_matrix)

#Etape 5 Application de l'ACP
data.pca <- princomp(corr_matrix)
summary(data.pca)


#C'est bien d'avoir les deux 
#premiers composants, mais que signifient-ils vraiment ? 

#On peut répondre à cette question en explorant leur relation 
#avec chaque colonne en utilisant les chargements de chaque composant principal. #####
library(factoextra)

fviz_eig(data.pca, addlabels = TRUE)

