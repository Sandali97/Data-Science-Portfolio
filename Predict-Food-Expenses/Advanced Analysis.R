library(readr)
library(recipes) # for feature engineering
library(Matrix) # Modeling packages
# for implementing regularized regression
library(caret)
library(glmnet)
library(Rcpp)
# for automating the tuning process
# Model interpretability packages
library(vip) # for variable

library(ggplot2)
#for partial dependency plots
library(pdp)
library(Metrics)  # For RMSE and R2 functions

setwd("F:/New Volume/3rd Year_ii/Statistical Learning/Family Income and Expenditure")
#install.packages('Metrics')


Family_Income_and_Expenditure <- read_csv("Family Income and Expenditure.csv")
View(Family_Income_and_Expenditure)
colnames(Family_Income_and_Expenditure)
attach(Family_Income_and_Expenditure)
#creating subdata set
df=data.frame(`Bread and Cereals Expenditure`,`Total Rice Expenditure`,`Meat Expenditure`,
              `Total Fish and  marine products Expenditure`, `Fruit Expenditure`,`Vegetables Expenditure`,
              `Total Household Income`,Region,`Agricultural Household indicator`,
              `Medical Care Expenditure`,`Total Number of Family members`,
              `Members with age less than 5 year old`,`Members with age 5 - 17 years old`)
View(df)
colnames(df) <-
  c('brd_cer','rice','meat','fish','fruit','veg','income','region'
    ,
    'agri_ind','med','t_mem','babies','kids')
detach(Family_Income_and_Expenditure)
#splitting dataset into test and train
set.seed(111)
sample_size = round(nrow(df)*.80) # setting what is 80%
index = sample(seq_len(nrow(df)), size = sample_size)
train =df[index, ]
test = df[-index, ]
#excluding some outliers
train<-subset(train, income<=1.5*10^6)
test<- subset(test,income<=1.5*10^6)
#combine brd_cer and rice
train<-
  data.frame(train$brd_cer+train$rice,train$income,train$region,as.factor(train$agri_ind),train$med,(train$t_mem-train$babies-
                train$kids),train$babies,train$kids)

test<-
  data.frame(test$brd_cer+test$rice,test$income,test$region,as.factor(test$agri_ind),test$med,
             
             (test$t_mem-test$babies-
                test$kids),test$babies,test$kids)

#rename coloumns
colnames(train) <-
  c('food_exp','income','region','agri_ind','med','adults','babies
','kids')
colnames(test) <-
  c('food_exp','income','region','agri_ind','med','adults','babies
','kids')
#replace food_exp = 0 with median(food_expnd)
train$food_exp[train$food_exp==0] <- median(train$food_exp)
test$food_exp[test$food_exp==0] <- median(train$food_exp)
#3. Create training feature matrices,we use model.matrix(...)[, -1] to discardthe intercept
#creaTINg design matrix
x_train <- model.matrix(food_exp ~ .,train)[, -1]
x_test <- model.matrix(food_exp ~ ., test)[, -1]
# transform y with log transformation
y_train <- log(train$food_exp)
y_test <- log(test$food_exp)

#4. Modeling
library(glmnet)
# Apply CV ridge regression to train data
ridge <- cv.glmnet(x = x_train,y = y_train,alpha = 0)
# Apply CV lasso regression to train data
lasso <- cv.glmnet(x = x_train,y = y_train,alpha = 1)
# plot results
par(mfrow = c(1, 2))
plot(ridge, main = "Ridge penalty\n\n")
plot(lasso, main = "Lasso penalty\n\n")
# Compute R^2 for test set
eval_results <- function(predicted,true) {
  RMSE = RMSE(predicted,true)
  MSE = RMSE(predicted,true)^2
  R_square = as.vector(R2(predicted,true))
  # Model performance metrics
  data.frame(MSE = MSE,RMSE = RMSE,Rsquare
             = R_square)}
min(ridge$cvm) # minimum MSE
ridge$lambda.min # lambda for this min MSE
ridge$cvm[ridge$lambda == ridge$lambda.1se] 
ridge$lambda.1se # lambda for this MSE
# Prediction and evaluation on test data with

predictions_test <- predict(ridge, s = ridge$lambda.min, newx = x_test)
eval_results(y_test, predictions_test)
#coefficient of ridge
coef(ridge)

# Lasso model
min(lasso$cvm) # minimum MSE
lasso$lambda.min # lambda for this min MSE
lasso$nzero[lasso$lambda == lasso$lambda.min] 
#No. of coef | Min MSE
lasso$cvm[lasso$lambda == lasso$lambda.1se] # 1-SE rule
lasso$lambda.1se # lambda for this MSE
lasso$nzero[lasso$lambda == lasso$lambda.1se] #No. of coef | 1-SE MSE
# Prediction and evaluation on test data with
lasso
predictions_test <- predict(lasso, s =
                              lasso$lambda.min, newx = x_test)
eval_results(y_test, predictions_test)
#coefficient of lasso
coef(lasso)

set.seed(123)
# grid search across
cv_glmnet <- train(x = x_train,y = y_train,method = "glmnet",
                   preProc = c("zv", "center","scale"),
                   trControl = trainControl(method = "cv",number = 10),tuneLength = 10)
# model with lowest RMSE
cv_glmnet$bestTune
#plots for elastic net
fit.Eln = glmnet(x_train,y_train,alpha = 1)
set.seed(5)
cv.Eln = cv.glmnet(x_train,y_train,alpha = 1)
plot(fit.Eln, xvar="lambda",lw=2, label=TRUE)
plot(cv.Eln, main = "Elastic Nets Penalty\n\n")
# results for model with lowest RMSE
#MSE of elastic net
cv_glmnet$results %>%
  filter(alpha == cv_glmnet$bestTune$alpha,
         lambda == cv_glmnet$bestTune$lambda)
# Prediction and evaluation on test data with Elastic net
predictions_test <- predict(cv_glmnet,x_test)
eval_results(y_test, predictions_test)
# Coefficient Elastic net
coef(cv_glmnet$finalModel,
     cv_glmnet$bestTune$lambda)

#5. variable importance plots and PDP 
#ridge 
vip(ridge, num_features = 20, geom = "point") 
#lasso 
vip(lasso, num_features = 20, geom = "point") 
#Elastic net 
vip(cv_glmnet, num_features = 20, geom = "point") 

partial(cv_glmnet, "adults", grid.resolution = 20, plot = 
          TRUE) 
partial(cv_glmnet, "kids", grid.resolution = 20, plot = 
          TRUE) 
partial(cv_glmnet, "income", grid.resolution = 20, plot = 
          TRUE) 


#6. Another 3 models 
#linear model 
set.seed(123) 
cv_model3 <- train(log(food_exp) ~ ., data = train, 
                   method = "lm",trControl = trainControl(method = "cv", 
                                                          number = 10)) 
summary(cv_model3) 
cv_model3$results  
#principal component regression 
set.seed(123) 
cv_model_pcr <- train(log(food_exp) ~ ., data = train, 
                      method = "pcr",trControl = trainControl(method = "cv", 
                                                              number = 10),preProcess = c("zv", "center", 
                                                                                          "scale"),tuneLength = 100) 
# model with lowest RMSE 
cv_model_pcr$bestTune 
cv_model_pcr$results %>% 
  dplyr::filter(ncomp == pull(cv_model_pcr$bestTune)) 
# plot cross-validated RMSE 
ggplot(cv_model_pcr) 
# paritial least square method 
set.seed(123) 
cv_model_pls <- train(log(food_exp) ~ ., data = train, 
                      method = "pls",trControl = trainControl(method = "cv", 
                                                              number = 10),preProcess = c("zv", "center", 
                                                                                          "scale"),tuneLength = 30) 
cv_model_pls$results %>% 
  dplyr::filter(ncomp == pull(cv_model_pls$bestTune)) 