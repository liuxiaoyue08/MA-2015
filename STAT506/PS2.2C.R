f=function(X,p){
  mdist<-as.matrix(dist(X))
  mat<-matrix(rep(0,dim(X)[1]*p),nrow=dim(X)[1],ncol=p)
  k=p+1
  for(i in 1:dim(X)[1]){
    mvec<-mdist[i,]
    pmvec<-order(mvec,decreasing=F)[2:k]
    mat[i,]=mat[i,]+pmvec}
  return(mat)
}


fma=function(X,p){
  mat<-matrix(rep(0,dim(X)[1]*p),nrow=dim(X)[1],ncol=p)
  k=p+1
  for(i in 1:dim(X)[1]){
    madist<-as.matrix(mahalanobis(X,X[i],cov(X)))
    pamvec<-order(madist,decreasing=F)[2:k]
    mat[i,]=mat[i,]+pamvec}
  return(mat)}

test_p=5*(1:3)
test_nrow=1000*(1:10)
test_ncol=10*(1:10)
timer_euclidean=array(0,c(length(test_p),length(test_nrow),length(test_ncol)))
timer_mahalanobis=array(0,c(length(test_p),length(test_nrow),length(test_ncol)))

for(idx_p in (1:length(test_p))){
  for(idx_nrow in (1:length(test_nrow))){
    for(idx_ncol in (1:length(test_ncol))){
      rX=matrix(rnorm(test_nrow[idx_nrow]*test_ncol[idx_ncol]),c(test_nrow[idx_nrow],test_ncol[idx_ncol]))
      test_time=proc.time()
      dummyrun=f(rX,test_p[idx_p])
      timer_euclidean[idx_p,idx_nrow,idx_ncol]=as.numeric(proc.time()-test_time)[1]
      test_time=proc.time()
      dummyrun2=fma(rX,test_p[idx_p])
      timer_mahalanobis[idx_p,idx_nrow,idx_ncol]=as.numeric(proc.time()-test_time)[1]
    }
  }
}
save(timer_euclidean,timer_mahalanobis,file="test_timer.RData")
q(save="no")
