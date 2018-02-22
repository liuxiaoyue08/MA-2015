library(dplyr)                                ##import library dplyr
data =read.csv("C:/Users/Heathtasia/Desktop/ps2_1.csv",header=FALSE)      ## read in data
df=data                                                                
for(i in 1:20000){
  chi<-chisq.test(t(matrix(as.numeric(data[i,]),c(2,2))))             ## calculate chi-square value
  df$chiv[i]<-chi$p.value}                                                                     for each row

test=df$chiv[df$chiv<0.05]



