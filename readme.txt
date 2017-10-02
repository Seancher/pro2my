0.
secherno@vega>> cd ~/rbs_doc/pro2my/
secherno@vega>> export TERM=xterm

1. Create MySQL script
mpro -pf /apps/deployment/db/progress/store/all.pf
run main_pro2my.p(<TransType>,<MetadataCreationDateDDMMYYYY>,<StatdataCreationDateDDMMYYYY>)
example: run main_pro2my.p(3,"21042017","21042017")
output: mysql_<TransType>_<CreationDateDDMMYYYY>.txt

1. First parameter - <TransType> = {1,2,3}
   {1} - KEEP_ORIG_DATABASE
   {2} - EXCL_EMPTY_TABLES
   {3} - EXCL_EMPTY_FIELDS

2. Second parameter - <MetadataCreationDateDDMMYYYY>
   Date when used_tablefields_ and all_tablefields_ were created
   "../rbs_db_analysis/out/used_tablefields_"
   "../rbs_db_analysis/out/all_tablefields_"

3. Third parameter - <StatdataCreationDateDDMMYYYY>
   Date when database_stat_ and used_tablefields_ were created
   "../rbs_db_analysis/out/database_stat_"
   "../rbs_db_analysis/out/used_tablefields_"
