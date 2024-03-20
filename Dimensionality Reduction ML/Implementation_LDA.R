# LINEAR DISCREMINANT ANALYSIS

library(MASS)

installed.packages('tidyverse')
library(tidyverse)
library(caret)
theme_set(theme_classic())

# Load the data
data("iris")

# Split the data into training (80%) and test set (20%)
set.seed(123)
training.individuals <- iris$Species %>% 
  createDataPartition(p = 0.8, list = FALSE)
train.data <- iris[training.individuals, ]
test.data <- iris[-training.individuals, ]

# Estimate preprocessing parameters
preproc.parameter <- train.data %>% 
  preProcess(method = c("center", "scale"))

# Transform the data using the estimated parameters
train.transform <- preproc.parameter %>% predict(train.data)
test.transform <- preproc.parameter %>% predict(test.data)

# Fit the model
model <- lda(Species~., data = train.transform)

# Make predictions
predictions <- model %>% predict(test.transform)

# Model accuracy
mean(predictions$class==test.transform$Species)

model <- lda(Species~., data = train.transform)
model


####################graphique
library(ggplot2)
library(mvtnorm)
# Variance Covariance matrix for random bivariate gaussian sample
var_covar = matrix(data = c(1.5, 0.4, 0.4, 1.5), nrow = 2)

# Random bivariate Gaussian samples for class +1
Xplus1 <- rmvnorm(400, mean = c(5, 5), sigma = var_covar)

# Random bivariate Gaussian samples for class -1
Xminus1 <- rmvnorm(600, mean = c(3, 3), sigma = var_covar)

# Samples for the dependent variable
Y_samples <- c(rep(1, 400), rep(-1, 600))

# Combining the independent and dependent variables into a dataframe
dataset <- as.data.frame(cbind(rbind(Xplus1, Xminus1), Y_samples))
colnames(dataset) <- c("X1", "X2", "Y")
dataset$Y <- as.character(dataset$Y)

# Plot the above samples and color by class labels
ggplot(data = dataset) + geom_point(aes(X1, X2, color = Y))

