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

proc print data=ghcnd6(obs=200);

data finaldata;
     set ghcnd6;

libname mydata '~/506/';
data df;
     set finaldata;

proc sql;
     create table tmp_range as
     select station,
	    range(TMAX) as tmax_range,
	    range(TMIN) as tmin_range,
            range(TMAX)-range(TMIN) as range_diff
     from df
     group by station;
quit;

proc print data=tmp_range;

proc summary data=tmp_range;
     output out=maxrange(drop=_TYPE_ _FREQ_)
            maxid(range_diff(station))=station
            max(range_diff)=max_range;

proc summary data=tmp_range;
     output out=minrange(drop=_TYPE_ _FREQ_)
            minid(range_diff(station))=station
            min(range_diff)=min_range;

proc print data=maxrange;
proc print data=minrange;

data mydata.tmp_range;
     set tmp_range;

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

libname mydata '~/506/';
filename ghcnd_gz pipe "gzip -dc 2014.csv.gz" lrecl=80;

data ghcnd(rename=(obsval=tmax));
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX";
     obsval=obsval/10;

proc sql;
     creat table tmax_dist as
     select station,month, mean(tmax) as mntmax, std(tmax) as stdtmax
     from ghcnd
     group by station,month;
quit;

proc export data = tmax_dist outfile = "tmax_dist.txt" dbms=tab replace;

libname mydata '~/506/';
filename ghcnd_gz pipe "gzip -dc 2014.csv.gz" lrecl=80;

data ghcnd14(rename=(obsval=tmax14));
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX" and month=1;
     obsval=obsval/10;

proc sql;
     create table mntmax_14 as
     select station,mean(tmax14) as mntmax14
     from ghcnd14
     group by station;
quit;

filename ghcnd_gz pipe "gzip -dc 2013.csv.gz" lrecl=80;

data ghcnd13(rename=(obsval=tmax13));
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX" and month=1;
     obsval=obsval/10;

proc sql;
     create table mntmax_13 as
     select station,mean(tmax13) as mntmax13
     from ghcnd13
     group by station;
quit; 

data meantmax;
     merge mntmax_14(in=x) mntmax_13(in=y);
     by station;
     if x=1 and y=1;
     tmax_diff=mntmax14-mntmax13;

proc export data=meantmax dbms=tab outfile="meantmax.txt" replace;

proc univariate data=meantmax;
     var tmax_diff;
     output out=tmax_diff_quantile pctlpts=10,90 pctlpre=tmax_diff;

proc print data=tmax_diff_quantile;

data meantmax_10;
     set meantmax;
     if tmax_diff ge -4.36793 and tmax_diff lt 3.70990 then delete;
     else if tmax_diff lt -4.36793 then indicator=1;
     else if tmax_diff ge 3.70990 then indicator=2;

data stations;
     infile "ghcnd-stations.txt";
     input station $ 1-11 lat 13-20 lon 22-30 elev 32-37 state $ 39-40;

proc sort data=stations out=stations2;
     by station;

data meantmax_10_map;
     merge meantmax_10(in=x) stations2(in=y);
     by station;
     if x=1 and y=1;

proc export data=meantmax_10_map dbms=tab outfile="meantmaxmap.txt" replace;

run;