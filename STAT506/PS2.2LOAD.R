load('test_timer.RData')
contour(x=10*(1:10),y=1000*(1:10),timer_euclidean[3,,],xlab="#Column",ylab="#Row",main="Process time of Euclidean Distance,p=15")
contour(x=10*(1:10),y=1000*(1:10),timer_mahalanobis[3,,],xlab="#Column",ylab="#Row",main="Process time of Mahalanobis Distance,p=15")

