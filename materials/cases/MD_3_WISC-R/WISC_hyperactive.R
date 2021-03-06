rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

#### Input data ####

# enter the observed scored into a vector object
(iq <- c(96, 102, 104, 104, 108, 110))
# compute the variance of iq
(sigma <- sum(iq))
# compute the mean of iq
(ybar <- mean(iq))
# choose the value of reference for iq
(mu0 <- 98)
#  transform the vector iq into a dataset 
ds <- as.data.frame(iq)



#### FULL model ####
# Create a column containing the predictions of the FULL model
(ds$full <- ybar)
# compute discrepancy between observed data and prediction of the FULL model 
(ds$ef <- ds$iq - ds$full)
# compute square errors of the FULL
(ds$ef2 <- ds$ef^2)



#### RESTRICTED model  ####
# Create a column containing the predictions of the RESTRICTED model
ds$restricted <- mu0
# compute discrepancy between observed data and prediction of the RESTRICTED model 
ds$er <- ds$iq - ds$restricted 
# compute square errors of the RESTRICTED
ds$er2 <- ds$er^2



#### MISFIT ####
# compute sum of squared discrepancies from the FULL 
EF <- sum(ds$ef2)
SSE <- EF
# compute sum of squared discrepancies from the RESTRICTED 
ER <- sum(ds$er2) 
SST <- ER
# compute the loss of misfit
SSR <- SST - SSE


#### PARSIMONY ####
# count the number of parameters in the FULL model
parsF <- 1 # because we estimated the mean
# count the number of parameters in the RESTRICTED model
parsR <- 0 

# compute degrees of freedom of the Full model
dfF <- nrow(ds) - parsF 

# compute degrees of freedom of the Restricted model
dfR <- nrow(ds) - parsR 


#### MEAN SQUARES ####
# compute mean squared error of the FULL model 
(MSE <- EF / dfF) 
# compute mean squared error of RESTRICTED model 
(MST <- ER / dfR) 
# compute mean square error of the DIFFERENCE
(MSR <- (ER - EF) / (dfR - dfF))



#### F test ####
# Compute the observed value of the F statistics
(Ftest <- MSR / MSE)

# estimate the model using lm() function from the stats package
sm <-  lm(formula = iq ~ 1, data = ds)
# estimate the model using glm() function from the stats package
sm <- glm(formula = iq ~ 1, data =  ds)
# print brief results of the fitted model
print(sm)
# print summary of the fitted model
summary(sm)
# create a column that stores the predicted values of the FULL model from lm() and glm() 
ds$yhat <- predict(sm)






  
  