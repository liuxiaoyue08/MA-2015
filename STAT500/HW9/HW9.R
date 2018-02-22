library(faraway)
data(infmort)
attach(infmort)
sum(is.na(infmort))
summary(infmort)
## Remove NAs
infmort=na.omit(infmort[,-4])
library(MASS)
g=lm(mortality~income+region+income:region, data = infmort)
## Compute Cook's Distance
cook<-cooks.distance(g)
halfnorm(cook,nlab=3,ylab="Cook's Distance")
## Find the outliers
infmort[c(25,72,27),]
ti<-rstudent(g)
pt(ti[25],df=101-5-1)
##Compute the p-value and compare with alpha/n
2*(1-pt(ti[25],df=101-5-1))-0.05/101
# Libya is not an outlier            
# 0.02631397
pt(ti[72],df=101-5-1)
##Compute the p-value and compare with alpha/n
2*(1-pt(ti[72],df=101-5-1))-0.05/101
# Afganistan is an outlier       
# -0.0004287065
pt(ti[27],df=101-5-1)
##Compute the p-value and compare with alpha/n
2*(1-pt(ti[27],df=101-5-1))-0.05/101
##Saudi_Arabia is an outlier
# -0.0004950495 

g1=lm(mortality~income+region+income:region, data = infmort)
par(mfrow=c(1,2))
halfnorm(cook,nlab=3,ylab="Cook's Distance")
boxcox(g1, plotit =TRUE,lambda=seq(-0.5,0.5,by=0.05))
##Transform the response to ln
g2=lm(log(mortality)~income+region+income:region, data = infmort)
g3=lm(log(mortality)~log(income)+region+log(income):region,data=infmort)
#Identify outliers
identify(infmort$income,infmort$mortality)
infmort1=infmort[-c(27,25),]
#Remove the outliers
g4=lm(log(mortality)~log(income)+region+log(income):region,data=infmort1)
g_Cov=lm(log(mortality)~log(income)*region,infmort1)
anova(g_Cov)
g_final=lm(log(mortality)~log(income)+region,data=infmort1)
levels(infmort1$region)=c("Africa","EuAs","EuAs","Americas")
g_final2=lm(log(mortality)~log(income)+region,data=infmort1)
anova(g_final,g_final2)
par(mfrow=c(1,2))
plot(g_final2$fitted.values,g_final2$residuals,xlab="Fitted",ylab="Residuals",main="")
abline(h=0)
qqnorm(g_final2$residual,ylab="Residuals")
qqline(g_final2$residual)
halfnorm(lm.influence(g_final2)$hat,nlab=2,ylab="Leverages")
plot(g_final2$residuals/((summary(g_final2)$sig)*sqrt(1-lm.influence(g_final2)$hat)), g_final2$residuals,xlab="Studentized Residuals",ylab="Raw Residuals")
