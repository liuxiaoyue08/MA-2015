df=read.table(file="C:/Users/Heathtasia/Desktop/506/bottom10.txt",header=TRUE,sep="\t")
df$indicator=as.factor(df$indicator)
levels(df$indicator)=c("both bottom 10%","tmin range bottom 10%","tmax range bottom 10%")
library(mapproj)
library(maptools) 
coord=mapproject(df$lon,df$lat)
map()
points(coord,col=c("red","blue","green")[df$indicator])
legend(x="topright", legend = levels(df$indicator), col=c("red","blue","green"), pch=1)

df2=read.table(file="C:/Users/Heathtasia/Desktop/506/tmax_dist.txt",header=TRUE,sep="\t")
df3=na.omit(df2)
cor(df3$mntmax,df3$stdtmax)
#-0.5063753
plot(df3$mntmax,df3$stdtmax)
identify(df3$mntmax,df3$stdtmax)
#[1] 19747
plot(df3[-19747,]$mntmax,df3[-19747,]$stdtmax)

df4=read.table(file="C:/Users/Heathtasia/Desktop/506/meantmax.txt",header=TRUE,sep="\t")
hist(df4$tmax_diff,breaks=1000)

df5=read.table(file="C:/Users/Heathtasia/Desktop/506/meantmaxmap.txt",header=TRUE,sep="\t")
df5$indicator=as.factor(df5$indicator)
levels(df5$indicator)=c("tmax_diff bottom 10%","tmax_diff top 10%")
map()
coord=mapproject(df5$lon,df5$lat)
points(coord,col=c("blue","red")[df5$indicator])
legend(x="bottomleft", legend = levels(df5$indicator), col=c("blue","red"), pch=1)
