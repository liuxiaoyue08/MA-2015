libname mydata '~/506/';
filename ghcnd_gz pipe "gzip -dc 2014.csv.gz" lrecl=80;

data ghcnd;
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX" or obstype="TMIN";
     obsval=obsval/10;

data stations;
     infile "ghcnd-stations.txt";
     input station $ 1-11 lat 13-20 lon 22-30 elev 32-37 state $ 39-40;

proc sort data=ghcnd out=ghcnd2;
     by station;

proc sort data=stations out=stations2;
     by station;

data ghcnd3;
     merge ghcnd2(in=x) stations2(in=y);
     by station;
     if x=1 and y=1;

proc summary data=ghcnd3 nway;
     class station month obstype;
     output out=ghcnd4
     	    mean(obsval)=mntmp;

proc transpose data=ghcnd4(drop=_TYPE_ _FREQ_) out=ghcnd5;
     by station month;
     id obstype;
     var mntmp;

data ghcnd6(drop=_NAME_ elev state);
     merge ghcnd5(in=x) stations2(in=y);
     by station;
     if x=1 and y=1;
     tmprange=TMAX-TMIN;

proc print data=ghcnd6;

data mydata.finaldata;
     set ghcnd6;

run;