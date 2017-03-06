DEF VAR cDate AS CHAR INIT "2812017".

/* MAIN Pro2MySQL*/
DEF VAR i AS INTEGER.
DEF VAR lDatabaseName AS CHAR.

DO i = 1 to NUM-DBS:
   lDatabaseName = LDBNAME(i).
   DISPLAY lDatabaseName LABEL "Database name: ".
   RUN create_alias.p(lDatabaseName).
   RUN ptmsch.p("ALL", lDatabaseName, cDate).
END.
