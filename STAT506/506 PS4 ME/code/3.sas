libname mydata '~/506/';
filename ghcnd_gz pipe "gzip -dc 2014.csv.gz" lrecl=80;

data ghcnd14(rename=(obsval=tmax14));
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX";
     obsval=obsval/10;
     if month=1;
     day=day(date);
     keep station day obsval;

proc sql;
     create table mntmax_14 as
     select station,day,mean(tmax14) as mntmax14
     from ghcnd14
     group by station,day;
quit;

filename ghcnd_gz pipe "gzip -dc 2013.csv.gz" lrecl=80;

data ghcnd13(rename=(obsval=tmax13));
     infile ghcnd_gz delimiter=",";
     input station $ date : yymmdd8. obstype $ obsval;
     format date mmddyy10.;
     month = month(date);
     if obstype="TMAX";
     obsval=obsval/10;
     if month=1;
     day=day(date);
     keep station day obsval;

proc sql;
     create table mntmax_13 as
     select station,day,mean(tmax13) as mntmax13
     from ghcnd13
     group by station,day;
quit; 

data meantmax;
     merge mntmax_14(in=x) mntmax_13(in=y);
     by station day;
     if x=1 and y=1;
     tmax_diff=mntmax14-mntmax13;

proc export data=meantmax dbms=tab outfile="meantmax.txt" replace;
run;

