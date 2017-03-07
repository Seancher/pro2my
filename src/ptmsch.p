/* --------------------------------------------------------------------
   ptmsch.p
   A routine to dump a data schema from a progress database
   into a format loadable by MySQL.


   inputs: a parameter containing either the word "ALL" or the
	   name of a table.

   outputs: A file named either MYSQL_'table'.SQL for one table
			     or SCH_'dbname'.SQL for all tables

   Copyright (c)2001 KM Newnham mark@newnhams.com
   Version 1.0 Original release 21st Dec 2001
   Version 2.0 22nd Nov 2004
   ---------------------------------------------------------------------
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

   -------------------------------------------------------------------------- */

/* -------------------------- Parameters ------------------------------------ */
def input parameter ipType as char format "x(30)"                       NO-UNDO.
def input parameter ipDBName as char format "x(30)"                     NO-UNDO.
def input parameter ipDate as char format "x(30)"                     NO-UNDO.
/* --------------------------   Streams  ------------------------------------ */
define new shared stream MX.
/* -------------------------- DEFINES ---------------------------------------
&GLOBAL-DEFINE PSMU PUT STREAM MX UNFORMATTED
---------------------- Temporary variables -------------------------------*/
def var logIsArray              as logical                              NO-UNDO.
def var charFileName            as char format "x(60)"                  NO-UNDO.
def var charFieldName           as char format "x(60)"                  NO-UNDO.
def var charIndexName           as char format "x(60)"                  NO-UNDO.
def var charTextSize            as char                                 NO-UNDO.
def var charTextField           as char format "x(60)"                  NO-UNDO.
def var charFormat              as char format "x(60)"                  NO-UNDO.
def var intIdx                  as int                                  NO-UNDO.
def var intIdxCount             as int                                  NO-UNDO.
def var intIdxFld               as int                                  NO-UNDO.
def var intIdxFldCount          as int                                  NO-UNDO.
def var intExtents              as int                                  NO-UNDO.
def var intTemp                 as int                                  NO-UNDO.
def var charTemp                as character format "x(80)"             NO-UNDO.
def var iFormat			as integer				NO-UNDO.
DEF VAR cUsedTablesFields AS LONGCHAR.
DEF VAR cUsedTables AS LONGCHAR.
DEF VAR cTextString AS CHARACTER.
DEF VAR lAddComma AS LOGICAL.
DEF VAR lAddKeyComma AS LOGICAL.
DEF VAR lAddKeyFieldComma AS LOGICAL.
DEF VAR lAddPKeyFieldComma AS LOGICAL.
DEF VAR liKeyFields AS INTEGER.
/* ---------------------------- MAIN ---------------------------------------- */

if ipType = "ALL" then do:

    charFileName="mysql_" + ipDBName + ".sql".

    run d2us.p(input-output charFileName).

    output stream MX to value(charFileName).

    PUT STREAM MX UNFORMATTED  "USE rbsall;" skip.

end.
else do:

   charFileName="sch_" + ipType + ".sql".
   run d2us.p(input-output charFileName).
   output stream MX to value(charFileName).

end.

/* Fetch the list: Used table, field */
cUsedTables = ";".
INPUT FROM VALUE("../database analysis/report/usedfields_" + ipDBName + "_" + ipDate + ".txt").
DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
   IMPORT UNFORMATTED cTextString.
   cUsedTables = cUsedTables + ENTRY(1,cTextString,",") + ";".
END.
INPUT CLOSE.


INPUT FROM VALUE("../database analysis/report/usedfields_" + ipDBName + "_" + ipDate + ".txt").
DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
   IMPORT UNFORMATTED cTextString.
   cUsedTablesFields = cUsedTablesFields + cTextString + ";".
END.
INPUT CLOSE.


/* --------------------------------------
   Loop through schema and extract the
   data
   -------------------------------------- */

FOR EACH DICTDB._file WHERE NOT DICTDB._file._file-name BEGINS "_" AND
                            NOT DICTDB._file._file-name BEGINS "Sys":

   /* Skip unused tables */
   IF INDEX(cUsedTables, ";" + DICTDB._file._file-name + ";") = 0
   THEN NEXT.

   charFileName = DICTDB._file._file-name.
   run d2us.p (input-output charFileName).

   PUT STREAM MX UNFORMATTED  "DROP TABLE IF EXISTS `" ipDBName + "_" + charFileName "`;" skip.
   PUT STREAM MX UNFORMATTED  "CREATE TABLE `" ipDBName + "_" + charFileName "`(" skip.

/* ----------------------------------------
   Now loop through each field, and process
   based on type
   ----------------------------------------- */
   lAddComma = FALSE.
   FOR EACH DICTDB._field WHERE DICTDB._field._file-recid = RECID(DICTDB._file)
                          BREAK BY DICTDB._field._field-name:
      /* ---------------------
      see if we need to process an array
      -------------------- */
      logIsArray = false.
      intExtents = 0.
      if DICTDB._field._extent > 0
      then do:
         logIsArray = true.
         intExtents = 1.
      end.

      repeat while intExtents <= DICTDB._field._extent:
         charFieldName = DICTDB._field._field-name.
         run d2us.p (input-output charFieldName).
         if logIsArray = false
         then do:
            /* Skip unused fields */
            IF INDEX(cUsedTablesFields, DICTDB._file._file-name + "," +
                     DICTDB._field._field-name) = 0
            THEN DO:
               intExtents = 1.
               NEXT.
            END.

            /* ----------------------------------
            Add a comma if needed
            ---------------------------------- */
            IF lAddComma THEN PUT STREAM MX UNFORMATTED  "," SKIP.

            PUT STREAM MX UNFORMATTED  "~t" charFieldName "~t".
            intExtents = 1.
         end.
         else do:
            /* Skip unused fields */
            IF INDEX(cUsedTablesFields, DICTDB._file._file-name + "," +
                     DICTDB._field._field-name + "[" +
                     STRING(intExtents) + "]") = 0
            THEN DO:
               intExtents = intExtents + 1.
               NEXT.
            END.

            /* Add a comma if needed */
            IF lAddComma THEN PUT STREAM MX UNFORMATTED  "," SKIP.

            /* ------------------------------------
            convert array field x[1],x[2] to
            x__1 x__2 etc
            ------------------------------------ */
            PUT STREAM MX UNFORMATTED  "~t" charFieldName "__" string(intExtents) "~t".
            intExtents = intExtents + 1.
         end.

         if DICTDB._field._data-type = "character"
         then do:

            /* -----------------------------------------------
            Try and determine the format of a character
            field. Any field bigger than 255 is converted
            to a TEXT type, otherwise it is a VARCHAR
            ---------------------------------------------- */

            charFormat = _format.
            intTemp = 0.
            iFormat = 0.
            intTemp = index(charFormat,"(").
            if intTemp > 0
            then do:
               /* --------------------------------------
               we have probably found a format that
               looks like "X(40)" or similar
               -------------------------------------- */

               charFormat = substring(charFormat,intTemp + 1).

               intTemp = index(charFormat,")").
               if intTemp > 0
               then do:
                  charFormat = substring(charFormat,1,intTemp - 1).
                  /* -----------------------------------------
                  We have removed the characters () so we
                  should be left with a number. So let's
                  try it and see
                  ----------------------------------------- */
                  intTemp = length(charFormat).
                  def var i as integer.
                  def var cTemp as character no-undo.
                  do i = 1 to intTemp:
                     cTemp = substr(charFormat,i,1).
                     if index("1234567890",cTemp) = 0
                     then do:
                        intTemp = length(_format). /* best guess */
                        leave.
                     end.
                  end.
                  if i > intTemp
                  then intTemp = integer(charFormat) /* no-error */.
                  /*
                  if error-status:error then intTemp = 0.
                  else */
                  do:
                     /* ----------------------------------
                     We will force a VARCHAR, make
                     the routine check the format again,
                     or leave intTemp to tell the next
                     routine its a TEXT field
                     ---------------------------------- */
                     if intTemp <= 1000
                     then assign
                        iFormat = intTemp
                        intTemp = 0.
                  end.
               end.
            end.

            charTextSize = "".
            charTextField = "".

            if intTemp > 0
            then do:

               /* ------------------------------------
               it's a TEXT FIELD
               ----------------------------------- */

               charTextSize = "(" + string(intTemp) + ")" .
               charFormat = "TEXT".
               charTextField = charFieldName.
            end.
            else do:
               /* -------------------------------------
               lets redo the format analysis
               charFormat = _format.
               intTemp = index(charFormat,"(").
               ---------------------------------------- */
               PUT STREAM MX UNFORMATTED  "varchar".
               if iFormat > 0
               then charFormat = "(" + string(iFormat) + ")".
               else
                  if intTemp > 0
                  then do:
                     if substring(charFormat,1,1) = "X"
                     then charFormat = substring(charFormat,intTemp).
                     else do:
                        intTemp = length(charFormat) - 2.
                        charFormat = "(" + string(intTemp) + ")".
                     end.
                  end.
                  else /* try and work out how long the string is */
                     charFormat = "(" + string(length(_format)) + ")".
            end.

            PUT STREAM MX UNFORMATTED  charFormat.
            /* ----------------------------------
            Set a default character value if required
            --------------------------------- */
            if _initial <> ?
            then charTemp = _initial.
            /* ----------------------
            Escape any " or \
            ---------------------- */

            run replace.p(input-output charTemp,"~\","~\~\").
            run replace.p(input-output charTemp,"~"","~\~"").
            PUT STREAM MX UNFORMATTED  " DEFAULT ~"" trim(charTemp) "~"".
         end.
         /* ----------------------------------------------------------
         DECIMAL field types stay as DECIMAL
         --------------------------------------------------------- */
         else if DICTDB._field._data-type = "decimal"
         then do:
            PUT STREAM MX UNFORMATTED  "decimal(" length(DICTDB._field._format)
               - 1 ",".
            IF DICTDB._field._decimals NE ?
            THEN PUT STREAM MX UNFORMATTED DICTDB._field._decimals ")".
            ELSE PUT STREAM MX UNFORMATTED "4)".
            /* ----------------------------------
            Set a default decimal value if required
            --------------------------------- */
            if DICTDB._field._initial <> ?
            then PUT STREAM MX UNFORMATTED " DEFAULT "
                     trim(DICTDB._field._initial).
         end.
         /* ----------------------------------------------------------
         INTEGER fields - We try to make the most efficient use of
         MySQL datattypes
         --------------------------------------------------------- */
         else if DICTDB._field._data-type="integer"
         then do:
            intTemp = length(DICTDB._field._format).
            if intTemp < 3
            then PUT STREAM MX UNFORMATTED  "tinyint".
            else if intTemp < 5
            then PUT STREAM MX UNFORMATTED  "smallint".
            else if intTemp < 7
            then PUT STREAM MX UNFORMATTED  "mediumint".
            else PUT STREAM MX UNFORMATTED  "integer".
            /* -------------------------------------
            Add an integer default if required
            ------------------------------------- */
            if DICTDB._field._initial <> ? and DICTDB._field._initial <> ''
            then PUT STREAM MX UNFORMATTED  " DEFAULT "
                     trim(DICTDB._field._initial).
         end.
         /* ------------------------------------------
         LOGICAL data types become TINYINT because
         there is no MySQL boolean data type
         ------------------------------------------ */
         else if DICTDB._field._data-type="logical"
         then do:
            PUT STREAM MX UNFORMATTED  "tinyint(1)".
            if DICTDB._field._initial = "no"
            then PUT STREAM MX UNFORMATTED  " DEFAULT 0".
            else PUT STREAM MX UNFORMATTED  " DEFAULT 1".
         end.
         /* --------------------------------------------
         DATES stay as date, but you can't carry over
         the classic 'default TODAY'
         -------------------------------------------- */
         else if DICTDB._field._data-type="date"
         then PUT STREAM MX UNFORMATTED  "date".
         /* --------------------------------------------
         DATETIME stays as datetime
         -------------------------------------------- */
         else if DICTDB._field._data-type begins "datetime"
         then PUT STREAM MX UNFORMATTED  "datetime".
         /* --------------------------------------------
         RAW is converted, but the routines can't convert
         the data in the fields
         -------------------------------------------- */
         else if DICTDB._field._data-type="raw"
         then PUT STREAM MX UNFORMATTED  "blob".
         /* --------------------------------------------
         RECID (version 9 only)
         -------------------------------------------- */
         else if DICTDB._field._data-type="recid"
         then PUT STREAM MX UNFORMATTED  "bigint".
         /* -----------------------------------------------
         Any other type - this probably shouldnt happen
         ----------------------------------------------- */
         else do:
            PUT STREAM MX UNFORMATTED "## Warning - writing an unparsed data type" skip.
            PUT STREAM MX UNFORMATTED "## That MySQL might not know about" skip.
            PUT STREAM MX UNFORMATTED DICTDB._field._data-type.
         end.
         /* ------------------------------
         A mandatory field?
         ------------------------------ */
         if DICTDB._field._mandatory
         then PUT STREAM MX UNFORMATTED  " NOT NULL".

         /* ------------------------------
         Add Comment
         ------------------------------ */
         PUT STREAM MX UNFORMATTED  " COMMENT ~"" DICTDB._field._label
                                              "|"  DICTDB._field._help
                                              "|" DICTDB._field._col-label
                                              "|" DICTDB._field._desc "~"".

         lAddComma = TRUE.
      end.
   end.

   /* --------------------------------------------------------
   Add a primary index field
   -------------------------------------------------------- */
   lAddPKeyFieldComma = FALSE.
   FOR EACH DICTDB._index of DICTDB._file:
      IF recid(DICTDB._index) =  DICTDB._file._prime-index
      THEN DO:
         PUT STREAM MX UNFORMATTED  "," SKIP "~tprimary key~t(".
         FOR EACH DICTDB._index-field of DICTDB._index:
            FIND DICTDB._field WHERE recid(DICTDB._field) = DICTDB._index-field._field-recid.

            /* Skip unused fields */
            IF INDEX(cUsedTablesFields,
               DICTDB._file._file-name + "," + DICTDB._field._field-name) = 0
            THEN NEXT.

            charIndexName = DICTDB._field._field-name.
            RUN d2us.p(input-output charIndexName).

            IF lAddPKeyFieldComma THEN PUT STREAM MX UNFORMATTED ",".
            lAddPKeyFieldComma = TRUE.
            PUT STREAM MX UNFORMATTED charIndexName.
         END.
         PUT STREAM MX UNFORMATTED ")".
      END.
   END.

   /* -------------------------------
   Count the number of indices so
   that we know when to add commas
   -------------------------------- */
   intIdxCount = 0.
   FOR EACH DICTDB._index of DICTDB._file:
      /* ----- Version 8 -------- */
      FIND FIRST DICTDB._index-field OF DICTDB._index NO-ERROR.
      IF NOT AVAILABLE DICTDB._index-field
      THEN NEXT.

      /* ----- Version 9 -------- */
      FIND DICTDB._field WHERE recid(DICTDB._field) = DICTDB._index-field._field-recid NO-ERROR.
      IF NOT AVAILABLE DICTDB._field
      THEN NEXT.
      IF DICTDB._field._field-name = ""
      THEN NEXT.

      /* ----------------------------------------
      If there are no indices, we still get a
      count of 1, so check for fields
      e.g. SPORTS.LOCAL-DEFAULTS
      ----------------------------------------- */
      intIdxCount = intIdxCount + 1.
   END.

   IF intIdxCount > 0
   THEN PUT STREAM MX UNFORMATTED  ",".
   PUT STREAM MX UNFORMATTED  skip.

   /* --------------------------------------------------
   Now loop through all the indices
   -------------------------------------------------- */
   lAddKeyComma = FALSE.
   IF intIdxCount > 0
   THEN FOR EACH DICTDB._index of DICTDB._file
        WHERE CAN-FIND (FIRST DICTDB._index-field OF DICTDB._index) break by DICTDB._index._index-name.
      /* ------------------------------------------
      Make a note of the original primary index
      ------------------------------------------ */
      IF recid(DICTDB._index) =  DICTDB._file._prime-index
      THEN PUT STREAM MX UNFORMATTED  "## The PROGRESS database primary index" skip.
      charIndexName = DICTDB._index._index-name.
      run d2us.p(input-output charIndexName).
      /* -----------------------------------------
      A standard index
      ----------------------------------------- */

      /********************
      * If you are using V9 and have word indexes then uncomment
      * this line and comment out the do
      if _index._Wordidx = ? then do:
      */
      DO:
         /* Find the number of fileds in each field */
         liKeyFields = 0.
         FOR EACH DICTDB._index-field of DICTDB._index:
            FIND DICTDB._field WHERE recid(DICTDB._field) = DICTDB._index-field._field-recid.
            /* Skip unused fields */
            IF INDEX(cUsedTablesFields,
               DICTDB._file._file-name + "," + DICTDB._field._field-name) = 0
            THEN NEXT.
            liKeyFields = liKeyFields + 1.
         END.

         /* Skip key if all key's fields are not used */
         IF liKeyFields = 0 THEN NEXT.

         /* Add a comma between keys if needed */
         IF lAddKeyComma THEN PUT STREAM MX UNFORMATTED  "," SKIP.

         PUT STREAM MX UNFORMATTED  "~tkey~t" charIndexName " (" SKIP.
         lAddKeyComma = TRUE.
         lAddKeyFieldComma = FALSE.
         FOR EACH DICTDB._index-field of DICTDB._index:
            FIND DICTDB._field WHERE recid(DICTDB._field) = DICTDB._index-field._field-recid.
            charFieldName = DICTDB._field._field-name.

            /* Skip unused fields */
            IF INDEX(cUsedTablesFields,
               DICTDB._file._file-name + "," + charFieldName) = 0
            THEN NEXT.

            /* Add a comma between key fields if needed */
            IF lAddKeyFieldComma THEN PUT STREAM MX UNFORMATTED  "," SKIP.

            run d2us.p(input-output charFieldName).
            PUT STREAM MX UNFORMATTED  "~t~t~t" charFieldName.

            lAddKeyFieldComma = TRUE.
         END.

         put stream MX unformatted ")".
      END.
      /* ---------------------------------------------------
      A WORD index, that we will convert to FULLTEXT
      There is only one field in a word index
      ---------------------------------------------------
      else do:
      PUT STREAM MX UNFORMATTED  "# "  _index-name skip.
      find first _index-field of _index NO-LOCK.
      find _field where recid(_field) = _index-field._field-recid NO-LOCK.
      charFieldName=caps(_field._field-name).
      run d2us.p(input-output charFieldName).

      PUT STREAM MX UNFORMATTED  "~t FULLTEXT(" charFieldName  ")".
      end.
      */

      PUT STREAM MX UNFORMATTED  skip.
      if last(DICTDB._index._index-name)
      then PUT STREAM MX UNFORMATTED  ")" skip.
   end.

   if intIdxCount = 0
   then PUT STREAM MX UNFORMATTED  ")" skip.
   /* ----------------------------------------------
   Derive the comment from the table description
   ---------------------------------------------- */
   PUT STREAM MX UNFORMATTED  "~tcomment = ~"" substring(_file._desc,1,60) "~";" skip.

end.

/* -----------------------------------------------
   Include the subroutine for converting and checking
   field names
   --------------------------------------------------- */

/* ------------------------------- THE END ----------------------------- */
