###############################################################
#Problem Set3
#Xiaoyue Liu
#UMID:28589009
#Email:xiaoyliu@umich.edu
###############################################################
#1.a
#import libraries
library(dplyr)
library(readxl)
library(geosphere)
library(mapproj)
library(maptools)
library(sp)
#Read in data
df = read_excel("E:/MA 2015/STAT500/SchichDataS1_FB.xlsx")
#Change data into numeric type
df$BLocLong = as.numeric(df$BLocLong)
df$BLocLat = as.numeric(df$BLocLat)
df$DLocLong = as.numeric(df$DLocLong)
df$DLocLat = as.numeric(df$DLocLat)
df$BYear = as.numeric(df$BYear)
df$DYear = as.numeric(df$DYear)
#Read in Spatial map
States = readShapeSpatial("cb_2014_us_state_500k")
#Set Birth Location point
p=SpatialPoints(cbind(df$BLocLong,df$BLocLat))
#Set Death Location point
t=SpatialPoints(cbind(df$DLocLong,df$DLocLat))
#Creat an zero array
bdrate=array(0,72)
#For each state
df$bstate<-rep(NA,nrow(df))
df$dstate<-rep(NA,nrow(df))
df$bstateid<-rep(NA,nrow(df))
df$dstateid<-rep(NA,nrow(df))
for(i in States$STATEFP[1:72])
{
  #Creat state area
  onestate<-States[States$STATEFP == i,]
  #Birth Location in this state
  q=over(p,onestate)
  #Death Location in this state
  s=over(t,onestate)
  ii = which(!is.na(q[[1]]))
  df[ii,]$bstateid<- i
  jj = which(!is.na(s[[1]]))
  df[jj,]$dstateid<- i
  #Calculate the birth/death rate
  bdrate[as.numeric(i)]<-nrow(df[ii,])/nrow(df[jj,])
}
for(i in States$NAME)
{
  #Creat state area
  onestate<-States[States$NAME == i,]
  #Birth Location in this state
  q=over(p,onestate)
  #Death Location in this state
  s=over(t,onestate)
  ii = which(!is.na(q[[1]]))
  df[ii,]$bstate<- i
  jj = which(!is.na(s[[1]]))
  df[jj,]$dstate<- i
}
#Creat State names
state<-c('AL','AK',NA,'AZ','AR','CA',NA,'CO','CT','DE','DC','FL','GA',NA,'HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA',NA,'RI','SC','SD','TN','TX','UT','VT','VA',NA,'WA','WV','WI','WY',NA,NA,NA,'AS',NA,NA,NA,NA,NA,'GU',NA,NA,'MP',NA,NA,'PR')
#Put in birth/death rate into each state
data<-cbind(state,bdrate)[1:72,]
#Remove the FIPS code which is not referring to a state
data<-data[!is.na(data[,1]),]
#Sort the state according to birth/death rate
data[order(data[,2]),]
#The results are as follows
# state bdrate              
# [1,] "MP"  "0.0666666666666667"
# [2,] "FL"  "0.17190278601067"  
# [3,] "CA"  "0.21064"           
# [4,] "AK"  "0.236111111111111" 
# [5,] "GU"  "0.25"              
# [6,] "DC"  "0.254831782390838" 
# [7,] "AZ"  "0.268348623853211" 
# [8,] "NV"  "0.396551724137931" 
# [9,] "NM"  "0.423423423423423" 
# [10,] "OR"  "0.549800796812749" 
# [11,] "HI"  "0.610738255033557" 
# [12,] "MD"  "0.772112382934443" 
# [13,] "WA"  "0.812108559498956" 
# [14,] "WY"  "0.819444444444444" 
# [15,] "CO"  "0.912806539509537" 
# [16,] "TX"  "0.924107142857143" 
# [17,] "UT"  "0.957264957264957" 
# [18,] "RI"  "0.984326018808777" 
# [19,] "ID"  "1.00900900900901"  
# [20,] "NJ"  "1.01525423728814"  
# [21,] "NY"  "1.02610190684589"  
# [22,] "CT"  "1.06659267480577"  
# [23,] "MT"  "1.07692307692308"  
# [24,] "LA"  "1.11538461538462"  
# [25,] "NC"  "1.11764705882353"  
# [26,] "VA"  "1.14140271493213"  
# [27,] "MI"  "1.16894409937888"  
# [28,] "DE"  "1.17435897435897"  
# [29,] "TN"  "1.18225039619651"  
# [30,] "GA"  "1.26282051282051"  
# [31,] "PR"  "1.28571428571429"  
# [32,] "AR"  "1.30960854092527"  
# [33,] "NH"  "1.33552631578947"  
# [34,] "MA"  "1.41124586549063"  
# [35,] "MN"  "1.44309927360775"  
# [36,] "SC"  "1.46551724137931"  
# [37,] "AL"  "1.53623188405797"  
# [38,] "NE"  "1.54177897574124"  
# [39,] "ND"  "1.56818181818182"  
# [40,] "VT"  "1.58407079646018"  
# [41,] "WI"  "1.59574468085106"  
# [42,] "OK"  "1.60344827586207"  
# [43,] "IL"  "1.61389445557782"  
# [44,] "ME"  "1.67415730337079"  
# [45,] "WV"  "1.69585253456221"  
# [46,] "OH"  "1.70231862378459"  
# [47,] "PA"  "1.74299312533051"  
# [48,] "MO"  "1.7551867219917"   
# [49,] "KS"  "1.86973180076628"  
# [50,] "MS"  "1.89056603773585"  
# [51,] "SD"  "1.94915254237288"  
# [52,] "IN"  "2.02268041237113"  
# [53,] "KY"  "2.03386004514673"  
# [54,] "IA"  "2.94545454545455"  
# [55,] "AS"  "3"              
#Comments:
#The higher the birth/death rate, the more notable persons tend to move out the state.
#In the contrast, the lower the birth/death rate, the more notable persons tend to move in the state.
#For the lowest several states, the evironment is much better than the highest several states.

###############################################################
#1.b
#Read in data
pop1790_1990<-read.csv("E:/MA 2015/STAT506/Population_PartII.csv",header=T)
#remove the , and change into numeric data
pop1790_1990$pop1990<-as.numeric(gsub(",","",pop1790_1990$pop1990))
pop1790_1990$pop1980<-as.numeric(gsub(",","",pop1790_1990$pop1980))
pop1790_1990$pop1970<-as.numeric(gsub(",","",pop1790_1990$pop1970))
pop1790_1990$pop1960<-as.numeric(gsub(",","",pop1790_1990$pop1960))
pop1790_1990$pop1950<-as.numeric(gsub(",","",pop1790_1990$pop1950))
pop1790_1990$pop1940<-as.numeric(gsub(",","",pop1790_1990$pop1940))
pop1790_1990$pop1930<-as.numeric(gsub(",","",pop1790_1990$pop1930))
pop1790_1990$pop1920<-as.numeric(gsub(",","",pop1790_1990$pop1920))
pop1790_1990$pop1910<-as.numeric(gsub(",","",pop1790_1990$pop1910))
pop1790_1990$pop1900<-as.numeric(gsub(",","",pop1790_1990$pop1900))
pop1790_1990$pop1890<-as.numeric(gsub(",","",pop1790_1990$pop1890))
pop1790_1990$pop1880<-as.numeric(gsub(",","",pop1790_1990$pop1880))
pop1790_1990$pop1870<-as.numeric(gsub(",","",pop1790_1990$pop1870))
pop1790_1990$pop1860<-as.numeric(gsub(",","",pop1790_1990$pop1860))
pop1790_1990$pop1850<-as.numeric(gsub(",","",pop1790_1990$pop1850))
pop1790_1990$pop1840<-as.numeric(gsub(",","",pop1790_1990$pop1840))
pop1790_1990$pop1830<-as.numeric(gsub(",","",pop1790_1990$pop1830))
pop1790_1990$pop1820<-as.numeric(gsub(",","",pop1790_1990$pop1820))
pop1790_1990$pop1810<-as.numeric(gsub(",","",pop1790_1990$pop1810))
pop1790_1990$pop1800<-as.numeric(gsub(",","",pop1790_1990$pop1800))
pop1790_1990$pop1790<-as.numeric(gsub(",","",pop1790_1990$pop1790))
#read in data
pop1990<-read.table("E:/MA 2015/STAT506/sf1990.txt", header = T, sep = ',')
#rename variables
names(pop1990)<-c("pop1990","STATE","STATEID")
#remove[] and change into numeric variables
pop1990$pop1990<-as.numeric(gsub("\\[","",pop1990$pop1990))
pop1990$STATEID<-gsub("\\]","",pop1990$STATEID)
pop1990<-pop1990[,1:3]
pop2000<-read.table("E:/MA 2015/STAT506/sf2000.txt", header = T, sep = ',')
names(pop2000)<-c("pop2000","STATE","STATEID")
pop2000$pop2000<-as.numeric(gsub("\\[","",pop2000$pop2000))
pop2000$STATEID<-gsub("\\]","",pop2000$STATEID)
pop2000<-pop2000[,1:3]
pop2010<-read.table("E:/MA 2015/STAT506/sf2010.txt", header = T, sep = ',')
names(pop2010)<-c("pop2010","STATE","STATEID")
pop2010$pop2010<-as.numeric(gsub("\\[","",pop2010$pop2010))
pop2010$STATEID<-gsub("\\]","",pop2010$STATEID)
pop2010<-pop2010[,1:3]
#Join the data sets into a whole data table of population
pop9000<-inner_join(pop1990,pop2000,by=c("STATEID"="STATEID","STATE"="STATE"))
pop7090<-inner_join(pop1790_1990,pop9000,by=c("STATE"="STATE","pop1990"="pop1990"))
pop<-inner_join(pop7090,pop2010,by=c("STATEID"="STATEID","STATE"="STATE"))
#Calculate the poplation per state
pop$pop1890per<-pop$pop1890/sum(pop$pop1890[!is.na(pop$pop1890)])
pop$pop1880per<-pop$pop1880/sum(pop$pop1880[!is.na(pop$pop1880)])
pop$pop1870per<-pop$pop1870/sum(pop$pop1870[!is.na(pop$pop1870)])
pop$pop1860per<-pop$pop1860/sum(pop$pop1860[!is.na(pop$pop1860)])
pop$pop1850per<-pop$pop1850/sum(pop$pop1850[!is.na(pop$pop1850)])
pop$pop1840per<-pop$pop1840/sum(pop$pop1840[!is.na(pop$pop1840)])
pop$pop1830per<-pop$pop1830/sum(pop$pop1830[!is.na(pop$pop1830)])
pop$pop1820per<-pop$pop1820/sum(pop$pop1820[!is.na(pop$pop1820)])
pop$pop1810per<-pop$pop1810/sum(pop$pop1810[!is.na(pop$pop1810)])
pop$pop1800per<-pop$pop1800/sum(pop$pop1800[!is.na(pop$pop1800)])
pop$pop1790per<-pop$pop1790/sum(pop$pop1790[!is.na(pop$pop1790)])
pop$pop1900per<-pop$pop1900/sum(pop$pop1900[!is.na(pop$pop1900)])
pop$pop1910per<-pop$pop1910/sum(pop$pop1910[!is.na(pop$pop1910)])
pop$pop1920per<-pop$pop1920/sum(pop$pop1920[!is.na(pop$pop1920)])
pop$pop1930per<-pop$pop1930/sum(pop$pop1930[!is.na(pop$pop1930)])
pop$pop1940per<-pop$pop1940/sum(pop$pop1940[!is.na(pop$pop1940)])
pop$pop1950per<-pop$pop1950/sum(pop$pop1950[!is.na(pop$pop1950)])
pop$pop1960per<-pop$pop1960/sum(pop$pop1960[!is.na(pop$pop1960)])
pop$pop1970per<-pop$pop1970/sum(pop$pop1970[!is.na(pop$pop1970)])
pop$pop1980per<-pop$pop1980/sum(pop$pop1980[!is.na(pop$pop1980)])
pop$pop1990per<-pop$pop1990/sum(pop$pop1990[!is.na(pop$pop1990)])
pop$pop2000per<-pop$pop2000/sum(pop$pop2000[!is.na(pop$pop2000)])
pop$pop2010per<-pop$pop2010/sum(pop$pop2010[!is.na(pop$pop2010)])
#Write the data into a csv file
write.csv(pop,"E:/MA 2015/STAT506/Population.csv")
pop<-read.csv("E:/MA 2015/STAT506/Population.csv")
dfm=mutate(df,BYear10=cut(BYear,seq(1905,2015,by=10)))
dfm$bstateid<-as.numeric(dfm$bstateid)
dfm$bstateid[dfm$bstateid==0]<-NA
dmf<-group_by(dfm,BYear10,bstate)
dmfs<-summarise(dmf,n=n())
dmfsm<-mutate(dmfs,fb=n/sum(n))
#Join the datasets of notable people ratio and the population ratio per state
popratio1<-pop[,c(2,seq(from=38,to=49,by=1))]
popratio2<-left_join(popratio1,dmfsm[1:55,],by=c("STATE"="bstate"))
popratio3<-left_join(popratio2,dmfsm[56:111,],by=c("STATE"="bstate"))
popratio4<-left_join(popratio3,dmfsm[112:166,],by=c("STATE"="bstate"))
popratio5<-left_join(popratio4,dmfsm[167:219,],by=c("STATE"="bstate"))
popratio6<-left_join(popratio5,dmfsm[220:272,],by=c("STATE"="bstate"))
popratio7<-left_join(popratio6,dmfsm[273:318,],by=c("STATE"="bstate"))
popratio8<-left_join(popratio7,dmfsm[319:360,],by=c("STATE"="bstate"))
popratio9<-left_join(popratio8,dmfsm[361:396,],by=c("STATE"="bstate"))
popratio10<-left_join(popratio9,dmfsm[397:413,],by=c("STATE"="bstate"))
popratio11<-left_join(popratio10,dmfsm[414:424,],by=c("STATE"="bstate"))
popratio12<-left_join(popratio11,dmfsm[425:427,],by=c("STATE"="bstate"))
names(popratio12)<-c("STATE","N1900wp","N1910wp","N1920wp","N1930wp","N1940wp","N1950wp","N1960wp","N1970wp","N1980wp","N1990wp","N2000wp","N2010wp","BY1910","n1910","np1910p","BY1920","n1920","np1920p","BY1930","n1930","np1930p","BY1940","n1940","np1940p","BY1950","n1950","np1950p","BY1960","n1960","np1960p","BY1970","n1970","np1970p","BY1980","n1980","np1980p","BY1990","n1990","np1990p","BY2000","n2000","np2000p","BY2010","n2010","np2010p")
popratio<-popratio12[,c(1,seq(from=3,to=13,by=1),seq(from=16,to=46,by=3))]
#Calculate the ratio of ratios.Take the ratio of the share of notable people per state to the share of all people per state based on the corresponding census data.
popratio$ratio1910 <- popratio$np1910p/popratio$N1910wp
popratio$ratio1920 <- popratio$np1920p/popratio$N1920wp
popratio$ratio1930 <- popratio$np1930p/popratio$N1930wp
popratio$ratio1940 <- popratio$np1940p/popratio$N1940wp
popratio$ratio1950 <- popratio$np1950p/popratio$N1950wp
popratio$ratio1960 <- popratio$np1960p/popratio$N1960wp
popratio$ratio1970 <- popratio$np1970p/popratio$N1970wp
popratio$ratio1980 <- popratio$np1980p/popratio$N1980wp
popratio$ratio1990 <- popratio$np1990p/popratio$N1990wp
popratio$ratio2000 <- popratio$np2000p/popratio$N2000wp
popratio$ratio2010 <- popratio$np2010p/popratio$N2010wp
write.csv(popratio,"E:/MA 2015/STAT506/Popratio.csv")
#Plot the ratio trend along time for each state
years<-seq(from=1910,to=2010,by=10)
plot(years,popratio[1,24:34],xlab="Year",ylab="Notable People Ratio",main=popratio[1,1],ylimit=1)
#Plot the ratio for each state
for(i in 1:51)
{
  plot(years,popratio[i,24:34],xlab="Year",ylab="Notable People Ratio",main=popratio[i,1])
}
#Import the ggplot2
library(ggplot2)
#Import mapdata to draw map for the states other than the given data
library(mapdata)
states<-map_data("state")
state_map<-data.frame(table(states$region))
#Creat the ratio for each 10-year period and put into the data set for drawing the map
states$rt1910<-popratio$ratio1910[match(states$region,tolower(popratio$STATE))]
states$rt1920<-popratio$ratio1920[match(states$region,tolower(popratio$STATE))]
states$rt1930<-popratio$ratio1930[match(states$region,tolower(popratio$STATE))]
states$rt1940<-popratio$ratio1940[match(states$region,tolower(popratio$STATE))]
states$rt1950<-popratio$ratio1950[match(states$region,tolower(popratio$STATE))]
states$rt1960<-popratio$ratio1960[match(states$region,tolower(popratio$STATE))]
states$rt1970<-popratio$ratio1970[match(states$region,tolower(popratio$STATE))]
states$rt1980<-popratio$ratio1980[match(states$region,tolower(popratio$STATE))]
states$rt1990<-popratio$ratio1990[match(states$region,tolower(popratio$STATE))]
states$rt2000<-popratio$ratio2000[match(states$region,tolower(popratio$STATE))]
states$rt2010<-popratio$ratio2010[match(states$region,tolower(popratio$STATE))]

#Draw the map for each 10-year period
map <- ggplot(states, aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group, fill=rt2010), col=NA,lwd=0)
map + scale_colour_gradient(low='white', high='grey20')
map + scale_colour_grey()
#The visualized ratio data can be found in the attached pictures.

###############################################################
#1.c
library(tidyr)
#Get out the notable people with state names
dfnp<-filter(df,is.na(bstate)==F&is.na(dstate)==F)
#group data according to birth state and death state
B_Dgp<-group_by(dfnp,bstate,dstate)
#count the number for each group
B_D_long<-summarise(B_Dgp,n=n())
#change into wide form
B_D_wide<-spread(B_D_long,key=dstate,n)
state_names<-States$NAME
state_names[!is.element(state_names,names(B_D_wide))]
#remove the state names and change into matrix for vectorization
bdmat<-as.matrix(B_D_wide[,-1])
#ratio= bdmat/t(bdmat)
pairratio<-as.data.frame(bdmat/t(bdmat))
#Get the names for each row using birth state
row.names(pairratio)<-names(pairratio)
#prepare for changing into long form define state_x as a factor variable
pairratio$state_x<-as.factor(row.names(pairratio))
#Change into long form
pairratio_long<-gather(data=pairratio,state_y,ratio,Alabama:Wyoming)
#Find the uneven states for 40% away from central 
thresh<-quantile(pairratio_long$ratio,probs=c(0.1,0.9),na.rm=T)
uneven<-filter(pairratio_long,ratio<thresh[1]|ratio>thresh[2])
uneven<-uneven[order(uneven$ratio,decreasing=F),]
#Result as follows
#                  state_x              state_y       ratio
# 234              Florida                 Ohio  0.01041667
# 231           California                 Ohio  0.01225490
# 142           California               Kansas  0.01369863
# 148           California             Kentucky  0.01503759
# 138           California                 Iowa  0.01522843
# 252              Florida         Pennsylvania  0.01600000
# 294           California            Wisconsin  0.01796407
# 193           California             Missouri  0.01856764
# 117           California             Illinois  0.01903553
# 181           California            Minnesota  0.02010050
# 199           California              Montana  0.02127660
# 127           California              Indiana  0.02298851
# 129 District of Columbia              Indiana  0.02777778
# 16            California             Arkansas  0.02941176
# 250           California         Pennsylvania  0.03243243
# 170              Florida        Massachusetts  0.03278689
# 201           California             Nebraska  0.03428571
# 233 District of Columbia                 Ohio  0.03529412
# 119              Florida             Illinois  0.03571429
# 175              Florida             Michigan  0.04000000
# 114           California                Idaho  0.04166667
# 203              Florida             Nebraska  0.04545455
# 263              Florida       South Carolina  0.04761905
# 3                Florida              Alabama  0.05000000
# 172                 Utah        Massachusetts  0.05000000
# 208 District of Columbia        New Hampshire  0.05000000
# 242              Florida             Oklahoma  0.05000000
# 300           California              Wyoming  0.05000000
# 211           California           New Jersey  0.05150215
# 1             California              Alabama  0.05172414
# 56            California             Colorado  0.05263158
# 69            California             Delaware  0.05263158
# 249              Arizona         Pennsylvania  0.05263158
# 186           California          Mississippi  0.05454545
# 173           California             Michigan  0.05504587
# 136                Texas              Indiana  0.05882353
# 158           California                Maine  0.06000000
# 230              Arizona                 Ohio  0.06250000
# 154           California            Louisiana  0.06603774
# 116              Arizona             Illinois  0.06666667
# 232             Colorado                 Ohio  0.06666667
# 221           California             New York  0.06911217
# 266           California            Tennessee  0.07070707
# 130              Florida              Indiana  0.07142857
# 139             Colorado                 Iowa  0.07142857
# 197               Oregon             Missouri  0.07142857
# 209              Florida        New Hampshire  0.07142857
# 253               Hawaii         Pennsylvania  0.07142857
# 168           California        Massachusetts  0.07267442
# 124               Oregon             Illinois  0.07407407
# 240           California             Oklahoma  0.07633588
# 195              Florida             Missouri  0.07692308
# 236             Oklahoma                 Ohio  0.07692308
# 153                Texas             Kentucky  0.08000000
# 223               Hawaii             New York  0.08000000
# 291           California        West Virginia  0.08108108
# 17               Florida             Arkansas  0.08333333
# 65               Florida          Connecticut  0.08333333
# 135               Oregon              Indiana  0.08333333
# 210              Arizona           New Jersey  0.08333333
# 292 District of Columbia        West Virginia  0.08333333
# 109           California              Georgia  0.08653846
# 182              Florida            Minnesota  0.08695652
# 220              Arizona             New York  0.08888889
# 137              Arizona                 Iowa  0.09090909
# 140             Nebraska                 Iowa  0.09090909
# 143             Colorado               Kansas  0.09090909
# 147             Arkansas             Kentucky  0.09090909
# 200              Arizona             Nebraska  0.09090909
# 251 District of Columbia         Pennsylvania  0.09090909
# 267 District of Columbia            Tennessee  0.09090909
# 277           California                 Utah  0.09090909
# 192              Arizona             Missouri  0.09523810
# 257           Washington         Pennsylvania  0.09523810
# 295 District of Columbia            Wisconsin  0.09523810
# 269           California                Texas  0.09687500
# 169 District of Columbia        Massachusetts  0.09756098
# 212              Florida           New Jersey  0.09803922
# 150             Michigan             Kentucky  0.10000000
# 174 District of Columbia             Michigan  0.10000000
# 202             Colorado             Nebraska  0.10000000
# 297           New Jersey            Wisconsin  0.10000000
# 262           California       South Carolina  0.10256410
# 222              Florida             New York  0.10288066
# 64  District of Columbia          Connecticut  0.10526316
# 194             Colorado             Missouri  0.10526316
# 63            California          Connecticut  0.11111111
# 118 District of Columbia             Illinois  0.11111111
# 146           Washington               Kansas  0.11111111
# 239           Washington                 Ohio  0.11111111
# 259 District of Columbia         Rhode Island  0.11111111
# 293             Michigan        West Virginia  0.11111111
# 151             Missouri             Kentucky  0.11428571
# 225           New Mexico             New York  0.11538462
# 4               Illinois              Alabama  0.11764706
# 235            Minnesota                 Ohio  0.11764706
# 265                Texas       South Carolina  0.12000000
# 281           California              Vermont  0.12000000
# 133            Louisiana              Indiana  0.12500000
# 141            Wisconsin                 Iowa  0.12500000
# 205            Louisiana             Nebraska  0.12500000
# 238                 Utah                 Ohio  0.12500000
# 264            Louisiana       South Carolina  0.12500000
# 198           Washington             Missouri  0.13333333
# 258             New York          Puerto Rico  0.13333333
# 188             Illinois          Mississippi  0.13725490
# 110 District of Columbia              Georgia  0.13793103
# 256                Texas         Pennsylvania  0.13953488
# 6                  Texas              Alabama  0.14285714
# 126                 Utah             Illinois  0.14285714
# 165              Florida             Maryland  0.14285714
# 187 District of Columbia          Mississippi  0.14285714
# 189              Indiana          Mississippi  0.14285714
# 190             Michigan          Mississippi  0.14285714
# 207           California        New Hampshire  0.14285714
# 243             Maryland             Oklahoma  0.14285714
# 282           California             Virginia  0.14492754
# 152             New York             Kentucky  0.14583333
# 2   District of Columbia              Alabama  0.15384615
# 67              Maryland          Connecticut  0.15384615
# 132               Kansas              Indiana  0.15384615
# 159              Florida                Maine  0.15384615
# 206           Washington             Nebraska  0.15384615
# 299                Texas            Wisconsin  0.15384615
# 149             Illinois             Kentucky  0.15625000
# 228              Florida       North Carolina  0.16129032
# 5               New York              Alabama  0.16666667
# 68              Virginia          Connecticut  0.16666667
# 70  District of Columbia             Delaware  0.16666667
# 122             Maryland             Illinois  0.16666667
# 131              Georgia              Indiana  0.16666667
# 144          Connecticut               Kansas  0.16666667
# 160             Illinois                Maine  0.16666667
# 161            Minnesota                Maine  0.16666667
# 162             Virginia                Maine  0.16666667
# 171           New Mexico        Massachusetts  0.16666667
# 185           Washington            Minnesota  0.16666667
# 219               Alaska             New York  0.16666667
# 227 District of Columbia       North Carolina  0.16666667
# 241 District of Columbia             Oklahoma  0.16666667
# 244           New Mexico             Oklahoma  0.16666667
# 255           New Mexico         Pennsylvania  0.16666667
# 260             Illinois         Rhode Island  0.16666667
# 261             Michigan         Rhode Island  0.16666667
# 298         North Dakota            Wisconsin  0.16666667
# 128             Colorado              Indiana  0.18181818
# 191                Texas          Mississippi  0.18181818
# 254             Michigan         Pennsylvania  0.18181818
# 163           California             Maryland  0.18421053
# 237                Texas                 Ohio  0.18421053
# 33              Maryland           California  5.42857143
# 273                 Ohio                Texas  5.42857143
# 57               Indiana             Colorado  5.50000000
# 178         Pennsylvania             Michigan  5.50000000
# 272          Mississippi                Texas  5.50000000
# 7               New York               Alaska  6.00000000
# 66                Kansas          Connecticut  6.00000000
# 73              Delaware District of Columbia  6.00000000
# 81        North Carolina District of Columbia  6.00000000
# 83              Oklahoma District of Columbia  6.00000000
# 111              Indiana              Georgia  6.00000000
# 121                Maine             Illinois  6.00000000
# 125         Rhode Island             Illinois  6.00000000
# 166             Illinois             Maryland  6.00000000
# 179         Rhode Island             Michigan  6.00000000
# 183                Maine            Minnesota  6.00000000
# 214        Massachusetts           New Mexico  6.00000000
# 216             Oklahoma           New Mexico  6.00000000
# 217         Pennsylvania           New Mexico  6.00000000
# 218              Alabama             New York  6.00000000
# 229            Wisconsin         North Dakota  6.00000000
# 283          Connecticut             Virginia  6.00000000
# 284                Maine             Virginia  6.00000000
# 286            Minnesota           Washington  6.00000000
# 104       North Carolina              Florida  6.20000000
# 120             Kentucky             Illinois  6.40000000
# 71               Alabama District of Columbia  6.50000000
# 94                 Maine              Florida  6.50000000
# 145              Indiana               Kansas  6.50000000
# 164          Connecticut             Maryland  6.50000000
# 276            Wisconsin                Texas  6.50000000
# 288             Nebraska           Washington  6.50000000
# 224             Kentucky             New York  6.85714286
# 52              Virginia           California  6.90000000
# 41         New Hampshire           California  7.00000000
# 79           Mississippi District of Columbia  7.00000000
# 95              Maryland              Florida  7.00000000
# 134          Mississippi              Indiana  7.00000000
# 167             Oklahoma             Maryland  7.00000000
# 177          Mississippi             Michigan  7.00000000
# 268              Alabama                Texas  7.00000000
# 278             Illinois                 Utah  7.00000000
# 274         Pennsylvania                Texas  7.16666667
# 74               Georgia District of Columbia  7.25000000
# 123          Mississippi             Illinois  7.28571429
# 226          Puerto Rico             New York  7.50000000
# 287             Missouri           Washington  7.50000000
# 155              Indiana            Louisiana  8.00000000
# 156             Nebraska            Louisiana  8.00000000
# 157       South Carolina            Louisiana  8.00000000
# 280                 Ohio                 Utah  8.00000000
# 296                 Iowa            Wisconsin  8.00000000
# 51               Vermont           California  8.33333333
# 275       South Carolina                Texas  8.33333333
# 115              Alabama             Illinois  8.50000000
# 184                 Ohio            Minnesota  8.50000000
# 215             New York           New Mexico  8.66666667
# 196             Kentucky             Missouri  8.75000000
# 22           Connecticut           California  9.00000000
# 75              Illinois District of Columbia  9.00000000
# 85          Rhode Island District of Columbia  9.00000000
# 180        West Virginia             Michigan  9.00000000
# 285               Kansas           Washington  9.00000000
# 289                 Ohio           Washington  9.00000000
# 60              Missouri             Colorado  9.50000000
# 72           Connecticut District of Columbia  9.50000000
# 103             New York              Florida  9.72000000
# 47        South Carolina           California  9.75000000
# 61              Nebraska             Colorado 10.00000000
# 78              Michigan District of Columbia 10.00000000
# 176             Kentucky             Michigan 10.00000000
# 213            Wisconsin           New Jersey 10.00000000
# 102           New Jersey              Florida 10.20000000
# 77         Massachusetts District of Columbia 10.25000000
# 49                 Texas           California 10.32258065
# 10              Missouri              Arizona 10.50000000
# 88             Wisconsin District of Columbia 10.50000000
# 290         Pennsylvania           Washington 10.50000000
# 9                   Iowa              Arizona 11.00000000
# 11              Nebraska              Arizona 11.00000000
# 18              Kentucky             Arkansas 11.00000000
# 50                  Utah           California 11.00000000
# 59                Kansas             Colorado 11.00000000
# 84          Pennsylvania District of Columbia 11.00000000
# 86             Tennessee District of Columbia 11.00000000
# 204                 Iowa             Nebraska 11.00000000
# 13              New York              Arizona 11.25000000
# 98             Minnesota              Florida 11.50000000
# 24               Georgia           California 11.55555556
# 12            New Jersey              Arizona 12.00000000
# 87         West Virginia District of Columbia 12.00000000
# 90              Arkansas              Florida 12.00000000
# 91           Connecticut              Florida 12.00000000
# 247              Indiana               Oregon 12.00000000
# 53         West Virginia           California 12.33333333
# 112             New York               Hawaii 12.50000000
# 271             Kentucky                Texas 12.50000000
# 99              Missouri              Florida 13.00000000
# 245                 Ohio             Oklahoma 13.00000000
# 45              Oklahoma           California 13.10000000
# 246             Illinois               Oregon 13.50000000
# 34         Massachusetts           California 13.76000000
# 58                  Iowa             Colorado 14.00000000
# 93               Indiana              Florida 14.00000000
# 101        New Hampshire              Florida 14.00000000
# 113         Pennsylvania               Hawaii 14.00000000
# 248             Missouri               Oregon 14.00000000
# 48             Tennessee           California 14.14285714
# 43              New York           California 14.46923077
# 8               Illinois              Arizona 15.00000000
# 62                  Ohio             Colorado 15.00000000
# 31             Louisiana           California 15.14285714
# 14                  Ohio              Arizona 16.00000000
# 32                 Maine           California 16.66666667
# 270              Indiana                Texas 17.00000000
# 35              Michigan           California 18.16666667
# 37           Mississippi           California 18.33333333
# 15          Pennsylvania              Arizona 19.00000000
# 21              Colorado           California 19.00000000
# 23              Delaware           California 19.00000000
# 19               Alabama           California 19.33333333
# 42            New Jersey           California 19.41666667
# 55               Wyoming           California 20.00000000
# 80         New Hampshire District of Columbia 20.00000000
# 89               Alabama              Florida 20.00000000
# 106             Oklahoma              Florida 20.00000000
# 279        Massachusetts                 Utah 20.00000000
# 108       South Carolina              Florida 21.00000000
# 100             Nebraska              Florida 22.00000000
# 25                 Idaho           California 24.00000000
# 97              Michigan              Florida 25.00000000
# 92              Illinois              Florida 28.00000000
# 82                  Ohio District of Columbia 28.33333333
# 40              Nebraska           California 29.16666667
# 96         Massachusetts              Florida 30.50000000
# 46          Pennsylvania           California 30.83333333
# 20              Arkansas           California 34.00000000
# 76               Indiana District of Columbia 36.00000000
# 27               Indiana           California 43.50000000
# 39               Montana           California 47.00000000
# 36             Minnesota           California 49.75000000
# 26              Illinois           California 52.53333333
# 38              Missouri           California 53.85714286
# 54             Wisconsin           California 55.66666667
# 107         Pennsylvania              Florida 62.50000000
# 28                  Iowa           California 65.66666667
# 30              Kentucky           California 66.50000000
# 29                Kansas           California 73.00000000
# 44                  Ohio           California 81.60000000
# 105                 Ohio              Florida 96.00000000

#Comments:The tails are symmetric, more notable people from different states(particularly Ohio) with cold climate move to and die in California and Florida because of the better climte.

###############################################################
#2.a
library(microbenchmark)
#Creat a simple generic function
do_something.red = function(x) { print("I am red") }
do_something.green = function(x) { print("I am green") }
do_something.default = function(x) { print("I am default") }
do_something.purple = function(x) { print("I am purple") }
do_something.blue = function(x) { print("I am blue") }
do_something.grey = function(x) { print("I am grey") }
do_something.white = function(x) { print("I am white") }
do_something = function(x) { UseMethod("do_something") }
#Run and count time cost
x=7
microbenchmark(do_something(x),do_something.red(x),do_something.grey(x),do_something.green(x))
#Time cost in microseconds
# Unit: microseconds
#             expr         min     lq     mean  median      uq     max neval
# do_something(x)       50.178 50.939 71.54571 53.7895 88.0020 302.209   100
# do_something.red(x)   42.576 43.336 54.02520 43.7160 62.9130 118.602   100
# do_something.grey(x)  42.955 43.716 58.47665 44.0960 72.6065 238.726   100
# do_something.green(x) 43.335 44.096 65.36465 44.6660 78.6890 799.428   100
#Comments: calling the generic function costs more time than calling one of the class-specific functions directly
#          The generic function is about 1.5ms£¨20%-30%£© slower than calling one of the class-specific function in this case
###############################################################
#2.b
list<-ls(envir=baseenv())
listtype<-as.character(rep(NA,length(list)))
for(i in 1:length(list)){
listtype[i]<-typeof(get(list[i]))
}
list_type<-as.data.frame(cbind(list,listtype))
list_gb<-group_by(list_type,listtype)
list_gbs<-summarise(list_gb,n=n())
#    listtype     n
#      (fctr) (int)
# 1   builtin   146
# 2 character     6
# 3   closure  1011
# 4    double     1
# 5      list     4
# 6   logical     2
# 7        S4     1
# 8   special    36
#Get all the functions
list_func<-list_type[list_type$listtype=='closure',]
listfunc<-list[listtype=="closure"]
#Get the generic functions
dp<-function(x)
{
  any(grepl("UseMethod",deparse(get(x))))
}
#
liststr<-sapply(listfunc,dp)
summary(liststr)
#     Mode   FALSE    TRUE    NA's 
# logical     948      65      0 
#So there are 65 generic functions
genfunc<-listfunc[liststr]
#Count the methods for each function
Methcount<-function(x)
{
  length(methods(x))
}
genfuncmeth<-cbind(genfunc,Methods=sapply(genfunc,Methcount))
rownames(genfuncmeth)=seq(1:65)
#     genfunc               Methods
# 1  "all.equal"                "11"   
# 2  "anyDuplicated"            "4"    
# 3  "aperm"                    "2"    
# 4  "as.array"                 "1"    
# 5  "as.data.frame"            "27"   
# 6  "as.Date"                  "8"    
# 7  "as.expression"            "1"    
# 8  "as.function"              "1"    
# 9  "as.list"                  "8"    
# 10 "as.matrix"                "7"    
# 11 "as.null"                  "1"    
# 12 "as.POSIXct"               "6"    
# 13 "as.POSIXlt"               "8"    
# 14 "as.single"                "1"    
# 15 "as.table"                 "2"    
# 16 "by"                       "2"    
# 17 "chol"                     "1"    
# 18 "close"                    "5"    
# 19 "conditionCall"            "1"    
# 20 "conditionMessage"         "1"    
# 21 "cut"                      "4"    
# 22 "determinant"              "1"    
# 23 "diff"                     "4"    
# 24 "droplevels"               "2"    
# 25 "duplicated"               "6"    
# 26 "flush"                    "1"    
# 27 "format"                   "65"   
# 28 "getDLLRegisteredRoutines" "2"    
# 29 "is.na<-"                  "3"    
# 30 "isSymmetric"              "1"    
# 31 "julian"                   "2"    
# 32 "kappa"                    "3"    
# 33 "labels"                   "5"    
# 34 "levels"                   "1"    
# 35 "mean"                     "5"    
# 36 "merge"                    "3"    
# 37 "months"                   "2"    
# 38 "open"                     "4"    
# 39 "pretty"                   "3"    
# 40 "print"                    "187"  
# 41 "qr"                       "2"    
# 42 "quarters"                 "2"    
# 43 "rev"                      "2"    
# 44 "row.names"                "2"    
# 45 "row.names<-"              "2"    
# 46 "rowsum"                   "2"    
# 47 "scale"                    "1"    
# 48 "seek"                     "1"    
# 49 "seq"                      "3"    
# 50 "solve"                    "2"    
# 51 "sort"                     "3"    
# 52 "split"                    "4"    
# 53 "split<-"                  "2"    
# 54 "subset"                   "3"    
# 55 "summary"                  "33"   
# 56 "t"                        "3"    
# 57 "toString"                 "1"    
# 58 "transform"                "2"    
# 59 "truncate"                 "1"    
# 60 "unique"                   "8"    
# 61 "units"                    "1"    
# 62 "units<-"                  "1"    
# 63 "weekdays"                 "2"    
# 64 "with"                     "1"    
# 65 "within"                   "2"    

#Creat the distribution table for the symbols
list_gbsf<-mutate(list_gbs,f=n/sum(n))
#The result is as follows: The distribution table for symbols belong to each type
#    listtype     n            f
#      (fctr) (int)        (dbl)
# 1   builtin   146 0.1209610605
# 2 character     6 0.0049710025
# 3   closure  1011 0.8376139188
# 4    double     1 0.0008285004
# 5      list     4 0.0033140017
# 6   logical     2 0.0016570008
# 7        S4     1 0.0008285004
# 8   special    36 0.0298260149

#Creat a distribution table for the number of classes to which each symbol belongs
classdet<-function(x)
{
  class(get(x))
}
listclass<-as.data.frame(cbind(list,class=sapply(list,classdet)))
classratio<-summary(listclass)
#         list                  class     
# -        :   1   character      :   6  
# -.Date   :   1   function       :1193  
# -.POSIXt :   1   logical        :   2  
# !        :   1   numeric        :   1  
# !.hexmode:   1   simple.list    :   2  
# !.octmode:   1   standardGeneric:   2  
# (Other)  :1200       
class_gp<-group_by(listclass,class)
class_gps<-summarise(class_gp,n=n())
class_fr<-mutate(class_gps,f=n/sum(n))
#             class     n            f
#            (fctr) (int)        (dbl)
# 1       character     6 0.0049751244
# 2        function  1193 0.9892205638
# 3         logical     2 0.0016583748
# 4         numeric     1 0.0008291874
# 5     simple.list     2 0.0016583748
# 6 standardGeneric     2 0.0016583748

#How many classes does each symbol belong?


classnum<-function(x){
  length(class(get(x)))
  }
class_num<-sapply(list,classnum)
summary(class_num)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1       1       1       1       1       1 

#It seems like that each symbol can only belong to one class