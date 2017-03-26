/* --------------------------------------------------------------------
   ptmsch.p
   A routine to dump a data schema from a progress databASe
   into a FORMAT loadable by MySQL.

   Inputs: a parameter containing either the word "ALL" or the
	   name of a table.

   Outputs: A file named either MYSQL_'table'.SQL for one table
			     or SCH_'dbname'.SQL for all tables

   -------------------------------------------------------------------------- */
{src/const.i}
  
/* -------------------------- Parameters ------------------------------------ */
DEF INPUT PARAMETER ipTransType AS INTEGER NO-UNDO.
DEF INPUT PARAMETER icDBName    AS CHAR FORMAT "x(30)" NO-UNDO.
DEF INPUT PARAMETER ipDate      AS CHAR FORMAT "x(30)" NO-UNDO.
/* --------------------------   Streams  ------------------------------------ */
DEFINE SHARED STREAM MX.

/* ---------------------- Temporary variables ------------------------------- */
DEF VAR lIsArray           AS LOGICAL NO-UNDO.
DEF VAR cTableName         AS CHAR FORMAT "x(60)" NO-UNDO.
DEF VAR cFieldNameSfx      AS CHAR FORMAT "x(60)" NO-UNDO.
DEF VAR iExtents           AS INTEGER NO-UNDO.
DEF VAR cTextString        AS CHARACTER NO-UNDO.
DEF VAR lAddFieldComma     AS LOGICAL NO-UNDO.
DEF VAR lAddKeyFieldComma  AS LOGICAL NO-UNDO.
DEF VAR lAddPKeyFieldComma AS LOGICAL NO-UNDO.
DEF VAR iFieldFormat       AS INTEGER NO-UNDO.
DEF VAR cFieldFormat       AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttTableField NO-UNDO
   FIELD TableName AS CHARACTER
   FIELD FieldName AS CHARACTER
   FIELD isUsed    AS LOGICAL
   FIELD NumUnique AS CHARACTER.

/* ---------------------------- MAIN ---------------------------------------- */

/* Fetch lists of all tables, all fields and the number of unique values  */
INPUT FROM VALUE("../rbs_db_analysis/out/database_stat_" + icDBName + "_" + ipDate + "_preprocessed.txt").
DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
   IMPORT UNFORMATTED cTextString.
   CREATE ttTableField.
   ASSIGN 
      ttTableField.TableName = ENTRY(2,cTextString,"|")
      ttTableField.FieldName = ENTRY(3,cTextString,"|")
      ttTableField.isUsed    = FALSE
      ttTableField.NumUnique = ENTRY(4,cTextString,"|").
END.
INPUT CLOSE.

/* Mark used fields */
INPUT FROM VALUE("../rbs_db_analysis/out/used_tablefields_" + icDBName + "_" + ipDate + ".txt").
DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
   IMPORT UNFORMATTED cTextString.
   FIND FIRST ttTableField WHERE 
      ttTableField.TableName = ENTRY(1,cTextString,".") AND
      ttTableField.FieldName = ENTRY(2,cTextString,".") NO-ERROR.
   IF AVAILABLE ttTableField
   THEN ttTableField.isUsed = TRUE.
END.
INPUT CLOSE.

/* Loop tables */
FOR EACH DB._file WHERE NOT DB._file._file-name BEGINS "_" AND
                        NOT DB._file._file-name BEGINS "Sys":
           
   /* Skip unused tables */
   IF (ipTransType EQ {&EXCL_EMPTY_TABLES} OR
      ipTransType EQ {&EXCL_EMPTY_FIELDS}) AND
      NOT CAN-FIND (FIRST ttTableField WHERE
         ttTableField.TableName = DB._file._file-name AND
         ttTableField.isUsed = TRUE)
   THEN NEXT.
   
   /* Create table */
   cTableName = DB._file._file-name.
   PUT STREAM MX UNFORMATTED "DROP TABLE IF EXISTS `" icDBName + "_" + cTableName "`;" SKIP.
   PUT STREAM MX UNFORMATTED "CREATE TABLE `" icDBName + "_" + cTableName "`(" SKIP.

   /* Loop fields */
   lAddFieldComma = FALSE.
   FOR EACH DB._field WHERE DB._field._file-recid = RECID(DB._file)
                      BREAK BY DB._field._field-name:
      /* Is array? */
      ASSIGN
         lIsArray = DB._field._extent > 0
         iExtents = INTEGER(lIsArray).
      
      /* Loop array */
      REPEAT WHILE iExtents <= DB._field._extent:
         iExtents = iExtents + 1.
         
         IF lIsArray
         THEN cFieldNameSfx = "[" + STRING(iExtents - 1) + "]".
         ELSE cFieldNameSfx = "".
         
         /* Skip if a field is not used in production */
         IF NOT CAN-FIND (FIRST ttTableField WHERE
               ttTableField.TableName = DB._file._file-name AND
               ttTableField.FieldName = DB._field._field-name + cFieldNameSfx)
         THEN NEXT.
            
         /* Skip unused and not index fields */
         IF ipTransType = {&EXCL_EMPTY_FIELDS} AND
            CAN-FIND (FIRST ttTableField WHERE
               ttTableField.TableName = DB._file._file-name AND
               ttTableField.FieldName = DB._field._field-name + cFieldNameSfx AND
               NOT ttTableField.isUsed) AND
            NOT CAN-FIND (FIRST DB._index-field WHERE RECID(DB._field) = DB._index-field._field-recid)
         THEN NEXT.
         
         /* Add field comma (if needed) & field name */
         IF lAddFieldComma
         THEN PUT STREAM MX UNFORMATTED "," SKIP.
         PUT STREAM MX UNFORMATTED "~t`" DB._field._field-name cFieldNameSfx "`~t".

         /* Add field format */
         cFieldFormat = REPLACE(DB._field._format,"X(","").
         cFieldFormat = REPLACE(cFieldFormat,")","").
         iFieldFormat = INTEGER(cFieldFormat) NO-ERROR.
         IF ERROR-STATUS:ERROR
         THEN iFieldFormat = LENGTH(cFieldFormat).
         IF iFieldFormat > 300
         THEN iFieldFormat = 0.
         
         CASE DB._field._data-type:
            WHEN "CHARACTER" THEN PUT STREAM MX UNFORMATTED "CHAR("
            STRING(iFieldFormat) ")".
            WHEN "INTEGER" THEN PUT STREAM MX UNFORMATTED "INT".
            WHEN "DATETIME" THEN PUT STREAM MX UNFORMATTED "DATETIME".
            WHEN "DECIMAL" THEN PUT STREAM MX UNFORMATTED "DECIMAL".
            WHEN "DATE" THEN PUT STREAM MX UNFORMATTED "DATE".
            WHEN "LOGICAL" THEN PUT STREAM MX UNFORMATTED "TINYINT(1)".
            WHEN "DATETIME-TZ" THEN PUT STREAM MX UNFORMATTED "DATETIME".
            OTHERWISE DO:
               DISP "Warning writting an unparsed data type". PAUSE.
               PUT STREAM MX UNFORMATTED SKIP "## Warning - writing an unparsed data type".
               PUT STREAM MX UNFORMATTED SKIP "## That MySQL might not know about" SKIP.
               PUT STREAM MX UNFORMATTED DB._field._data-type.
            END.
         END CASE.

         /* Set a default character value if required  */
         IF DB._field._initial <> ? AND
            DB._field._initial <> "" AND
            DB._field._initial <> "?"
         THEN DO:
            CASE DB._field._data-type:
               WHEN "LOGICAL" THEN PUT STREAM MX UNFORMATTED
                  " DEFAULT ~"" STRING(INTEGER(LOGICAL(DB._field._initial))) "~"".
               WHEN "DATE" THEN .
               OTHERWISE PUT STREAM MX UNFORMATTED
                  " DEFAULT ~"" TRIM(DB._field._initial) "~"".
            END CASE.
         END.
         
         /* A mandatory field? */
         IF DB._field._mandatory
         THEN PUT STREAM MX UNFORMATTED " NOT NULL".
      
         /* Fetch the number of unique values */
         FIND FIRST ttTableField WHERE 
            ttTableField.TableName = DB._file._file-name AND
            ttTableField.FieldName = DB._field._field-name + cFieldNameSfx NO-ERROR.
                  
         /* Set a comment: TYPE, FORMAT, LABEL, COLUMN-LABEL, HELP, DESCRIPTION */
         PUT STREAM MX UNFORMATTED " COMMENT ~""
            TRIM(DB._field._data-type) "|" /* TYPE */
            TRIM(DB._field._format) "|" /* FORMAT */
            TRIM(ttTableField.NumUnique) "|" /* # of Uniques */
            TRIM(DB._field._label) "|" /* LABEL */
            TRIM(DB._field._col-label) "|"/* COLUMN-LABEL */
            TRIM(DB._field._help) "|" /* HELP */
            TRIM(DB._field._desc) "~"". /* DESCRIPTION */
         lAddFieldComma = TRUE.
      END. /* Loop array */
   END. /* Loop fields */

   /* Loop primary indexes */
   lAddPKeyFieldComma = FALSE.
   FOR EACH DB._index OF DB._file:
      IF RECID(DB._index) = DB._file._prime-index
      THEN DO:
         PUT STREAM MX UNFORMATTED "," SKIP "~tPRIMARY KEY~t(".
         /* Loop primary index fields */
         FOR EACH DB._index-field OF DB._index:
            FIND DB._field WHERE RECID(DB._field) = DB._index-field._field-recid.

            /* Add primary key field comma (if needed) & field name */
            IF lAddPKeyFieldComma THEN PUT STREAM MX UNFORMATTED ",".
            lAddPKeyFieldComma = TRUE.
            PUT STREAM MX UNFORMATTED "`" DB._field._field-name "`".
         END.
         PUT STREAM MX UNFORMATTED ")".
      END. /* Loop primary index fields */
   END. /* Loop primary indexes */

   /* Loop indixes */
   FOR EACH DB._index OF DB._file
      WHERE CAN-FIND (FIRST DB._index-field OF DB._index)
      BREAK BY DB._index._index-name:
      
      PUT STREAM MX UNFORMATTED "," SKIP.
      
      /* Make a note of the original primary index */
      IF RECID(DB._index) = DB._file._prime-index
      THEN PUT STREAM MX UNFORMATTED "## The PROGRESS database primary index" SKIP.

      PUT STREAM MX UNFORMATTED "~tKEY~t`" DB._index._index-name "` (" SKIP.
      lAddKeyFieldComma = FALSE.
      
      /* Loop index fields */
      FOR EACH DB._index-field OF DB._index:
         FIND DB._field WHERE RECID(DB._field) = DB._index-field._field-recid.

         /* Add field comma (if needed) & field name */
         IF lAddKeyFieldComma THEN PUT STREAM MX UNFORMATTED "," SKIP.
         lAddKeyFieldComma = TRUE.
         PUT STREAM MX UNFORMATTED "~t~t~t~t`" DB._field._field-name "`".
         
      END. /* Loop index fields */

      PUT STREAM MX UNFORMATted ")".
   END. /* Loop indices */
  
   PUT STREAM MX UNFORMATTED ")" SKIP.
   
   /* Table comment */
   PUT STREAM MX UNFORMATTED "~tCOMMENT = ~"" TRIM(DB._file._desc) "~";" SKIP.
END. /* Loop tables */

/* ------------------------------- THE END ----------------------------- */
