attach(data)
mat=matrix(0,nrow=nrow(data),ncol=4)
mat[,1]=as.numeric((data[,1]+data[,2])*(data[,1]+data[,3]))
mat[,2]=as.numeric((data[,1]+data[,2])*(data[,2]+data[,4]))
mat[,3]=as.numeric((data[,3]+data[,4])*(data[,1]+data[,3]))
mat[,4]=as.numeric((data[,3]+data[,4])*(data[,2]+data[,4]))

mat=mat/rowSums(data)
chi_sqvalue=rowSums((data-mat)^2/mat)
pvalue=1-pchisq(chi_sqvalue,1)

linenum=summary(pvalue<0.05)