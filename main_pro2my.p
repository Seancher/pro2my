/* --------------------------------------------------------------------
   main_ptmsch.p
   -------------------------------------------------------------------------- */
{src/const.i}

/* -------------------------- Variables ------------------------------------- */
DEF INPUT PARAMETER iiTransType    AS INTEGER NO-UNDO.
/* 1 KEEP_ORIG_DATABASE
   2 EXCL_EMPTY_TABLES
   3 EXCL_EMPTY_FIELDS */
DEF INPUT PARAMETER icMetadataDate AS CHAR NO-UNDO.
DEF INPUT PARAMETER icStatdataDate AS CHAR NO-UNDO.

DEF VAR i AS INTEGER.
DEF VAR cDatabaseName AS CHAR.
DEFINE NEW SHARED STREAM MX.

/* -------------------------- Main start ------------------------------------ */
OUTPUT STREAM MX TO VALUE("out/mysql_" + STRING(iiTransType) + "_" +
   STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") +
   STRING(YEAR(TODAY),"9999") + ".sql").
PUT STREAM MX UNFORMATTED "DROP DATABASE IF EXISTS rbsall;" SKIP.
PUT STREAM MX UNFORMATTED "CREATE DATABASE rbsall;" SKIP.
PUT STREAM MX UNFORMATTED "USE rbsall;" SKIP.

DO i = 1 to NUM-DBS:
   cDatabaseName = LDBNAME(i).
   DISPLAY cDatabaseName LABEL "Database name: ".
   RUN src/create_alias.p(cDatabaseName).
   RUN src/ptmsch.p(iiTransType, cDatabaseName, icMetadataDate, icStatdataDate).
END.

/* -------------------------- End ------------------------------------------- */
