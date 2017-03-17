/* --------------------------------------------------------------------
   main_ptmsch.p
   -------------------------------------------------------------------------- */

/* -------------------------- Variables ------------------------------------- */
DEF VAR cDatabaseStatDate AS CHARACTER.
DEF VAR iTransType AS INTEGER.
DEF VAR i AS INTEGER.
DEF VAR cDatabaseName AS CHAR.
DEFINE NEW SHARED STREAM MX.

/* -------------------------- Constants ------------------------------------- */
/* Progress to MySQL transition type */
&GLOBAL-DEFINE KEEP_ORIG_DATABASE 1
&GLOBAL-DEFINE EXCL_EMPTY_TABLES 2
&GLOBAL-DEFINE EXCL_EMPTY_FIELDS 3

/* -------------------------- Settings -------------------------------------- */
ASSIGN
   cDatabaseStatDate = "2812017"
   iTransType = {&KEEP_ORIG_DATABASE}.

/* -------------------------- Main start ------------------------------------ */
OUTPUT STREAM MX TO VALUE("out/mysql_rbsall.sql").
PUT STREAM MX UNFORMATTED "DROP DATABASE IF EXISTS rbsall;" SKIP.
PUT STREAM MX UNFORMATTED "CREATE DATABASE rbsall;" SKIP.
PUT STREAM MX UNFORMATTED "USE rbsall;" SKIP.
DO i = 1 to NUM-DBS:
   cDatabaseName = LDBNAME(i).
   DISPLAY cDatabaseName LABEL "Database name: ".
   RUN src/create_alias.p(cDatabaseName).
   RUN src/ptmsch.p(iTransType, cDatabaseName, cDatabaseStatDate).
END.

/* -------------------------- End ------------------------------------------- */
