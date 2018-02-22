source("https://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
library(data.table)
ghcn = fread("zcat -dc 2014.csv.gz")
#ghcn = fread("C:/Users/Heathtasia/Desktop/2014.csv/2014.csv")
setnames(ghcn, c("station", "date", "vtype", "value", "x1", "x2", "x3", "x4"))
setkey(ghcn, vtype, station)
stations = unique(ghcn[, station])
H5close()
fname = "ghcn_2014.hdf5"
h5createFile(fname)
for (vt in c("TMIN", "TMAX", "PRCP")) {
  h5createGroup(fname, vt)
  for (j in 1:length(stations)) {
    st = stations[j]
    if (j %% 100 == 0) {
      print(j)
    }
    dd = ghcn[.(vt, st), .(date, value)]
    dd = as.matrix(dd)
    dname = sprintf("%s/%s", vt, st)
    h5createDataset(fname, dname, dim(dd), level=7)
    h5write(dd, fname, dname)
  }
}
H5close()

contents = h5ls(fname)
contents = contents[2:dim(contents)[1],]
stations = unique(contents$name)
dfr = data.frame()
t_hfd5=proc.time()
for (j in 1:length(stations)) {
  
  dx = h5read(fname, sprintf("TMAX/%s", stations[j]))
  ii=which.max(dx[,2])
  jj=which.min(dx[,2])
  dfr[stations[j], "range"] = (dx[ii, 2]-dx[jj,2]) / 10
}
timer_hdf5=proc.time()-t_hfd5
length(stations)
save(as.numeric(timer_hdf5),filefile="hdf5_timer.RData")
q(save="no")

t_mem=proc.time()
ghcnd2014=fread("C:/Users/Heathtasia/Desktop/2014.csv/2014.csv")
setnames(ghcnd2014, c("station", "date", "vtype", "value", "x1", "x2", "x3", "x4"))
ghcnd2014=ghcnd2014[ghcnd2014$vtype=="TMAX",]
GHCN2014=ghcnd2014[,(max(value)-min(value))/10,by="station"]
timer_mem=proc.time()-t_mem
GHCN2014=GHCN2014[order(GHCN2014$station,1)]
