library(data.table)
#Calculate the time for reading from zip file
t1=proc.time()
ghcn = fread("zcat -dc 2014.csv.gz")
timer1=as.numeric(proc.time()-t1)
#Calculate the time for reading from uncompressed file
t2=proc.time()
ghcn=fread("2014.csv")
timer2=as.numeric(proc.time()-t2)
#Prepare for dataset
setnames(ghcn, c("station", "date", "vtype", "value", "x1", "x2", "x3", "x4"))
#Get the month column
ghcn$month=as.numeric(substring(ghcn$date,5,6))
#Load the 2014 GHCND data into a data.table object
GHCN=data.table(ghcn)
GHCN=GHCN[order(GHCN$station,decreasing=F)]
#Calculate the time using dplyr for grouping and calculate means                      
library(dplyr)
t3=proc.time()
summarise(group_by(GHCN,station,month),meantmp=mean(value))
timer3=as.numeric(proc.time()-t3)
#Calculate the time using native data.frame grouping and calculate means
t4=proc.time()
GHCN[,mean(value),by=c("station","month")]
timer4=as.numeric(proc.time()-t4)
#Save the time data into a RData file
save(timer1,timer2,timer3,timer4,file="PS5_timer.RData")

q(save="no")
