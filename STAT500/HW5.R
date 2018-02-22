library(faraway)
library(quantreg)
library(MASS)
library(dplyr)
data(sat)
attach(sat)
olsreg<-lm(total~takers+ratio+salary+expend,data=sat)
cook<-cooks.distance(olsreg)
halfnorm(cook,nlab=3,ylab="Cook's distance")
sat2<-filter(sat,sat$total!='935')
sat2<-filter(sat2,sat2$total!='1076')
sat2<-filter(sat2,sat2$total!='932')
olsreg.re<-lm(total~takers+ratio+salary+expend,data=sat2)
ladreg<-rq(total~takers+ratio+salary+expend,data=sat)
hrbreg<-rlm(total~takers+ratio+salary+expend,data=sat)
lts.reg<-ltsreg(total~takers+ratio+salary+expend,data=sat)
x<-sat[,c(4,2,3,1)]
bcoef<-matrix(0,nrow=1000,ncol=5)
for(i in 1:1000){
  newy<-lts.reg$fit+lts.reg$resid[sample(30,rep=T)]
  bcoef[i,]<-ltsreg(x,newy,nsamp="best")$coef
}
colnames(bcoef)=names(coef(lts.reg))
apply(bcoef,2,function(x) quantile(x,c(0.025,0.975)))
round(lts.reg$coef,3)
plot(density(bcoef[,3]),xlab="Coefficient of Ratio",main="")
abline(v=quantile(bcoef[,3],c(0.025,0.975)))
plot(density(bcoef[,2]),xlab="Coefficient of Takers",main="")
abline(v=quantile(bcoef[,2],c(0.025,0.975)))
