/*import*/
filename gz14 pipe "gzip -dc 2014.csv.gz" lrecl=80;
filename gz13 pipe "gzip -dc 2013.csv.gz" lrecl=80;

data ghcnd_14(rename=(obsval=tmp));
    infile gz14 delimiter=',';
    input station : $11. date : yymmdd8. obstype $ obsval;
    format date mmddyy10.;
    mon = month(date);

    if obstype = "TMAX" or obstype = "TMIN";
    keep station mon obstype obsval;
    obsval = obsval / 10;


data ghcnd_13(rename=(obsval=tmp));
    infile gz13 delimiter=',';
    input station : $11. date : yymmdd8. obstype $ obsval;
    format date mmddyy10.;
    mon = month(date);

    if obstype = "TMAX" or obstype = "TMIN";
    keep station mon obstype obsval;
    obsval = obsval / 10;


proc sql;
    create table tmp_max as
    select station, mon, mean(tmp) as mt_max
        from ghcnd_14
        where obstype = "TMAX"
        group by station, mon;

    create table tmp_min as
    select station, mon, mean(tmp) as mt_min
        from ghcnd_14
        where obstype = "TMIN"
        group by station, mon;
    quit;

data tmp_merg;
    merge tmp_max tmp_min;
        by station mon;

proc sql;
    create table tmp_rg as
    select station, 
           range(mt_max) as tmprg_max, 
           range(mt_min) as tmprg_min,
           range(mt_max) - range(mt_min) as tmprg_diff
        from tmp_merg
        group by station;
quit;

proc tabulate data = tmp_rg;
    var tmprg_diff;
    table tmprg_diff*max tmprg_diff*min tmprg_diff*mean; 

proc sql;
    create table diff_res_print as
    select * from tmp_rg
    having tmprg_diff = max(tmprg_diff) or tmprg_diff = min(tmprg_diff);
quit;

/*print the greatest and least different station*/
proc print data = diff_res_print;

/*print strange things*/
data wtf;
    set tmp_merg;
    if station = "USS0006H25S" or station = "USS0049L18S";
    keep _all_;
    
proc print data = wtf; 

/*import station information*/
data stations;
    infile 'ghcnd-stations.txt';
    input station $ 1-11 lat 13-20 lon 22-30 elev 32-37 state $ 39-40
         name $ 42-71 gsn $ 73-75 hcn 77-79 wmo 81-85;



/*merge range data with location info*/
proc sort data = stations;
    by station;

data tmp_rg_info;
    merge tmp_rg stations;
        by station;

proc univariate data = tmp_rg_info noprint;
    var tmprg_max tmprg_min;
    output  out = pctl1010
            pctlpts = 10 10
            pctlpre  = pmax pmin;

/*use proc rank to get 10%*/
/*note that the index of ranking by group starts from 0*/
proc rank data = tmp_rg_info group = 10
    out = bt_tmp_rg_info(where=(rank_max=0 or rank_min=0));
    var tmprg_max tmprg_min;
    ranks rank_max rank_min;

proc print data = pctl1010;
proc print data = bt_tmp_rg_info;

proc export data = bt_tmp_rg_info outfile = "1.data.txt" DBMS = TAB;


/*2*/
proc sql;
    create table tmp_max_msd as
    select station, mon, mean(tmp) as mt_max, std(tmp) as sdt_max
        from ghcnd_14
        where obstype = "TMAX"
        group by station, mon;

    quit;

proc export data = tmp_max_msd outfile = "2.data.txt" DBMS = TAB;


/*3*/
proc sql;
    create table m_13_jan as
    select station, mean(tmp) as mt_max_13
        from ghcnd_13
        where obstype = "TMAX" and mon = 1
        group by station;

    create table m_14_jan as
    select station, mon, mean(tmp) as mt_max_14
        from ghcnd_14
        where obstype = "TMAX" and mon = 1
        group by station;
    quit;


data m_jan;
    merge m_13_jan m_14_jan;
    by station;
    diff = mt_max_14 - mt_max_13;

proc export data = m_jan outfile = "3_all.data.txt" DBMS = TAB;

data m_jan_info;
    merge m_jan stations;
    by station;

proc rank data = m_jan_info group = 10
    out = rnk_m_jan(where=(rnk=0 or rnk=9));
    var diff;
    ranks rnk;

proc export data = rnk_m_jan outfile = "3_10.data.txt" DBMS = TAB;

run;