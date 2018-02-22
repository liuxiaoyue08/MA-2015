libname mydata '~/506/';

data tmp_range;
     set mydata.tmp_range;

proc univariate data=tmp_range;
     var tmax_range tmin_range;
     output out=range10 pctlpts=10 pctlpre=tmax_range tmin_range;

proc print range10;

data stations;
     infile "ghcnd-stations.txt";
     input station $ 1-11 lat 13-20 lon 22-30 elev 32-37 state $ 39-40;

proc sort data=stations out=stations2;
     by station;

data df1;
     merge tmp_range(in=x) stations2(in=y);
     by station;
     if x=1 and y=1;

data df2;
     set df1;
     if tmax_range ge 6.68495 and tmin_range ge 6.54762 then delete;
     else if tmax_range ge 6.68495 and tmin_range lt 6.54762 then indicator=2;
     else if tmax_range lt 6.68495 and tmin_range ge 6.54762 then indicator=3;
     else indicator=1;

proc export data=df2 dbms=tab outfile='bottom10.txt' replace;
run;