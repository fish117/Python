mydata<-final_project_real_estate_data
str(mydata)
names(mydata)<-c('p','s','a','b')
################
# VISUALIZE DATA
################
# plot y against each of your x variables to check if the relationship is linear

plot(p ~ s, data=mydata, pch = 16)
plot(p ~ a, data=mydata, pch = 16)
plot(p ~ b, data=mydata, pch = 16)
#Plots with square root transformation of sale price
mydata$p.sq <- sqrt(mydata$p)
plot(p.sq ~ s, data=mydata, pch = 16)
plot(p.sq ~ a, data=mydata, pch = 16)
plot(p.sq ~ b, data=mydata, pch = 16)

#Plots with log transformation of sale price
mydata$p.log <- log(mydata$p)
mydata$s.log <- log(mydata$s)
mydata$a.log <- log(mydata$a)
plot(p.log ~ s.log, data=mydata, pch = 16)
plot(p.log ~ a.log, data=mydata, pch = 16)
plot(p.log ~ b, data=mydata, pch = 16)

#Model A£º
z1 <- lm(p.sq ~ a, data=mydata)
predict1 <- predict(z1)
resid1 <- resid(z1)

# Residual plot - use to check for violations to assumptions of linearity and equal variance
plot(resid1 ~ predict1, pch=16)
abline(h=0,v=c(400,600,800) ,lty=2,col='red')
# Check assumption of normality
hist(resid1)
# Normality plot
qqnorm(resid1, ylab= "standardized residuals", xlab = "Normal scores")
qqline(resid1)
shapiro.test(resid1) #Shapiro-Wilk test
plot(resid1~a,data=mydata)
summary(z1)
anova(z1)


confint(z1, level=0.95)
#################################
# CALCULATIONS IN ORIGINAL UNITS
#################################

mydata2 <- cbind(mydata, predict1)
str(mydata2)

# Get the predicted values in the original units, using (predicted values)^2
mydata2$predict.orig <- (mydata2$predict1)^2

SSY <- sum((mydata2$p- mean(mydata2$p))^2)
SSY
SSE <- sum((mydata2$p - mydata2$predict.orig)^2)
SSE
SSreg <- sum((mydata2$predict.orig - mean(mydata2$p))^2)
SSreg


# When we have done the backtransformation of the predicted values, the equation SSY = SSreg + SSE is no longer true.

# Calculate measures of goodness of fit in original units
pseudo.R2 <- 1 - SSE/SSY # Always use this formula when calculating the Pseudo-R2
pseudo.R2



nrow(mydata) # 1200 observations
rootMSE <- sqrt(SSE/1198)# sqaure root of mean square error 19-2=17,in the original units
rootMSE




t2<-mydata2
str(t2)
xnew <- seq(min(t2$a), max(t2$a),length.out = 100)
xnew

ynew.ci <- data.frame(predict(z1, newdata = data.frame(a=xnew), interval = "prediction", level = 0.95))
ynew.ci

new.values <- cbind(xnew,ynew.ci) # combine the vector with the new x-values and the dataframe with the predicted y-values and values for the confidene bands
print(new.values)
# create the plot with the regression line and the confidence bands in log units
plot(p.sq~ a, data = mydata, pch = 16)
abline(z1)
lines(ynew.ci$lwr ~xnew, lty = 2)
lines(ynew.ci$upr ~xnew, lty = 2)

# backtransform everything
new.values
new.values$fit.back <- (new.values$fit)^2
new.values$lwr.back <-(new.values$lwr)^2
new.values$upr.back <- (new.values$upr)^2
new.values$x.back<-(new.values$xnew)

new.values

# create the plot in the original units, with the confidence intervals for the mean value of y (confidence bands) backtransformed into the original units
plot(p ~a, data = mydata, pch = 16)
lines(new.values$fit.back ~ new.values$x.back, lty=1)
lines(new.values$lwr.back ~ new.values$x.back, lty = 2)
lines(new.values$upr.back ~ new.values$x.back, lty = 2)


# Model B p~log.a+a+b
mydata<-final_project_real_estate_data
str(mydata)
names(mydata)<-c('p','s','a','b')
################
# VISUALIZE DATA
################
# plot y against each of your x variables to check if the relationship is linear


mydata$a.log <- log(mydata$a)
mydata$p.log <- log(mydata$p)
plot(p.log ~ a.log, data=mydata, pch = 16)
plot(p.log ~ a, data=mydata, pch = 16)
plot(p.log ~ b, data=mydata, pch = 16)
z1 <- lm(p.log ~ a.log+a+b, data=mydata)
predict1 <- predict(z1)
resid1 <- resid(z1)

# Residual plot - use to check for violations to assumptions of linearity and equal variance
plot(resid1 ~ predict1, pch=16)
abline(h=0,v=c(12,13) ,lty=2,col='red')
# Check assumption of normality
hist(resid1)
# Normality plot
qqnorm(resid1, ylab= "standardized residuals", xlab = "Normal scores")
qqline(resid1)
shapiro.test(resid1) #Shapiro-Wilk test
plot(resid1~a,data=mydata)
plot(resid1~a.log,data=mydata)
plot(resid1~b,data=mydata)




#test the significance of living area
z1 <- lm(p.log ~a+ b+a.log, data=mydata)

predict1<- predict(z1)
resid1<- resid(z1)

str(mydata2)

# Get the predicted values in the original units, using (predicted values)^2
mydata2$predict.orig <- exp(mydata2$predict1)
mydata2 <- cbind(mydata, predict1)
SSY <- sum((mydata2$p- mean(mydata2$p))^2)
SSY
SSE <- sum((mydata2$p - mydata2$predict.orig)^2)
SSE
SSreg <- sum((mydata2$predict.orig - mean(mydata2$p))^2)
SSreg


# When we have done the backtransformation of the predicted values, the equation SSY = SSreg + SSE is no longer true.

# Calculate measures of goodness of fit in original units
pseudo.R2 <- 1 - SSE/SSY # Always use this formula when calculating the Pseudo-R2
pseudo.R2



nrow(mydata) # 1200 observations
rootMSE <- sqrt(SSE/1196)# sqaure root of mean square error 1200-3-1=17,in the original units
rootMSE


SSreg.reduced <- sum((predict4 - mean( mydata$p.log))^2)
SSreg.reduced
#test the significance of bedroom
z3 <- lm(p.log ~ a+a.log, data=mydata)
anova(z1, z3)
predict3<- predict(z3)
resid3 <- resid(z3)
SSE.reduced <- sum(( mydata$p.log- predict3)^2)
SSE.reduced

SSE.full <- sum(( mydata$p.log - predict1)^2)
SSE.full
SSE.reduced - SSE.full


SSreg.full <- sum((predict1 - mean( mydata$p.log))^2)
SSreg.full

SSreg.reduced <- sum((predict3 - mean( mydata$p.log))^2)
SSreg.reduced
SSY<-sum((mydata$p.log-mean( mydata$p.log))^2)
SSY
pseudo.R2 <- 1 - SSE.reduced/SSY # Always use this formula when calculating the Pseudo-R2
pseudo.R2
anova(z1, z3)
summary(z3)


#Model C  p.log=s.log+b+log.s*b
mydata<-final_project_real_estate_data
str(mydata)
names(mydata)<-c('p','s','a','b')
################
# VISUALIZE DATA
################
# plot y against each of your x variables to check if the relationship is linear


mydata$s.log <- log(mydata$s)
mydata$p.log <- log(mydata$p)
mydata$int<-(mydata$s.log*mydata$b)
plot(p.log ~ s.log, data=mydata, pch = 16)
plot(p.log ~ b, data=mydata, pch = 16)
plot(p.log ~ int, data=mydata, pch = 16)
z1 <- lm(p.log ~ s.log+b+s.log*b, data=mydata)
predict1 <- predict(z1)
resid1 <- resid(z1)

# Residual plot - use to check for violations to assumptions of linearity and equal variance
plot(resid1 ~ predict1, pch=16)
abline(h=0,v=c(12,12.5,13) ,lty=2,col='red')
# Check assumption of normality
hist(resid1)
# Normality plot
qqnorm(resid1, ylab= "standardized residuals", xlab = "Normal scores")
qqline(resid1)
shapiro.test(resid1) #Shapiro-Wilk test
plot(resid1~s.log,data=mydata)
plot(resid1~s,data=mydata)
plot(resid1~b,data=mydata)
summary(z1)
anova(z1)
#test the significance of model
SSY <- sum((mydata2$p.log- mean(mydata2$p.log))^2)
SSY
SSE <- sum((mydata2$p.log - mydata2$predict1)^2)
SSE
SSreg <- sum((mydata2$predict1 - mean(mydata2$p.log))^2)
SSreg
#fit the model without the interaction
z2<- lm(p.log ~ s.log+b,data=mydata)
predict2 <- predict(z2)
resid2<- resid(z2)

SSE.reduced <- sum(( mydata$p.log - predict2)^2)
SSE.reduced
SSE.full <- sum(( mydata$p.log - predict1)^2)
SSE.full

SSE.reduced - SSE.full


SSreg.full <- sum((predict1 - mean( mydata$p.log))^2)
SSreg.full

SSreg.reduced <- sum((predict2 - mean( mydata$p.log))^2)
SSreg.reduced

SSreg.full - SSreg.reduced



SSreg.reduced <- sum((predict3 - mean( mydata$p.log))^2)
SSreg.reduced
SSY<-sum((mydata$p.log-mean( mydata$p.log))^2)
SSY
# Get the predicted values in the original units, using (predicted values)^2
mydata2$predict.orig <- exp(mydata2$predict1)
mydata2 <- cbind(mydata, predict1)
SSY <- sum((mydata2$p- mean(mydata2$p))^2)
SSY
SSE <- sum((mydata2$p - mydata2$predict.orig)^2)
SSE
SSreg <- sum((mydata2$predict.orig - mean(mydata2$p))^2)
SSreg


# When we have done the backtransformation of the predicted values, the equation SSY = SSreg + SSE is no longer true.

# Calculate measures of goodness of fit in original units
pseudo.R2 <- 1 - SSE/SSY # Always use this formula when calculating the Pseudo-R2
pseudo.R2



nrow(mydata) # 1200 observations
rootMSE <- sqrt(SSE/1196)# sqaure root of mean square error 1200-3-1=17,in the original units
rootMSE


summary(z1)
#nwe model
mydata<-final_project_real_estate_data
str(mydata)
names(mydata)<-c('p','s','a','b')

mydata$s.log <- log(mydata$s)
mydata$a.log <- log(mydata$a)
mydata$p.log <- log(mydata$p)
z1 <- lm(p.log ~s.log+ b+a.log, data=mydata)
summary(z1)
predict1 <- predict(z1)
resid1 <- resid(z1)
predict.orig<-exp(predict1)
mydata2<-cbind(mydata,predict.orig)
SSY <- sum((mydata2$p- mean(mydata2$p))^2)
SSY
SSE <- sum((mydata2$p - mydata2$predict.orig)^2)
SSE
SSreg <- sum((mydata2$predict.orig - mean(mydata2$p))^2)
SSreg
pseudo.R2 <- 1 - SSE/SSY # Always use this formula when calculating the Pseudo-R2
pseudo.R2
