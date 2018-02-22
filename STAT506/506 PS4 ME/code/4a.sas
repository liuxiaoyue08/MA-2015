libname mydata '~/506/';

data df;
     set mydata.finaldata;

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

data mydata.tmp_range;
     set tmp_range;

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

run;
