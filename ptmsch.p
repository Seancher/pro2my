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
/* ---------------------------- MAIN ---------------------------------------- */
if ipType = "ALL" then do:

    charFileName="mysql_" + ldbname(1) + ".sql".

    run d2us.p(input-output charFileName).

    output stream MX to value(charFileName).

    PUT STREAM MX UNFORMATTED  "DROP DATABASE IF EXISTS " caps(ldbname(1))  ";" skip.
    PUT STREAM MX UNFORMATTED  "CREATE DATABASE " caps(ldbname(1)) ";" skip.
    PUT STREAM MX UNFORMATTED  "USE " caps(ldbname(1)) ";" skip.

end.
else do:

   charFileName="sch_" + ipType + ".sql".
   run d2us.p(input-output charFileName).
   output stream MX to value(charFileName).

end.

/* --------------------------------------
   Loop through schema and extract the
   data
   -------------------------------------- */

for each _file where ((_file-name < "_" and ipType = "ALL")
		or (_file-name = ipType and _file-name <> "ALL"))
		and _hidden = false NO-LOCK:

    charFileName=caps(_file-name).
    run d2us.p (input-output charFileName).

    PUT STREAM MX UNFORMATTED  "DROP TABLE IF EXISTS " charFileName ";" skip.
    PUT STREAM MX UNFORMATTED  "CREATE TABLE " charFileName "(" skip.

    /* ---------------------------------------
       Add a field with the progress recid to
       ensure a unique, non-null primary index
       --------------------------------------- */

    PUT STREAM MX UNFORMATTED  "~tPROGRESS_RECID bigint NOT NULL," skip.

    /* ----------------------------------------
       Now loop through each field, and process
       based on type
       ----------------------------------------- */
    for each _field of _file NO-LOCK break by _field-name:

	if _file._file-name = 'INVLIN' and _field._field-name = 'HGB-HCT_DATE' then next.

	/* ---------------------
	       see if we need to process
	   an array
	   -------------------- */

	logIsArray = false.
	intExtents = 0.
	if _field._extent > 0 then do:
	    logIsArray = true.
	    intExtents = 1.
	end.
	repeat while intExtents <= _field._extent:
	    charFieldName=_field-name.
	    run d2us.p (input-output charFieldName).
	    if logIsArray = false then do:
		PUT STREAM MX UNFORMATTED  "~t" charFieldName "~t".
		intExtents = 1.
	    end.
	    else do:
		/* ------------------------------------
		   convert array field x[1],x[2] to
		   x__1 x__2 etc
		   ------------------------------------ */
		PUT STREAM MX UNFORMATTED  "~t" charFieldName "__" string(intExtents) "~t".
		intExtents = intExtents + 1.
	    end.

	     if _data-type="character" then do:

		/* -----------------------------------------------
		   Try and determine the format of a character
		   field. Any field bigger than 255 is converted
		   to a TEXT type, otherwise it is a VARCHAR
		   ---------------------------------------------- */

		charFormat = _format.
		intTemp = 0.
		iFormat = 0.
		intTemp = index(charFormat,"(").
		if intTemp > 0 then do:
		    /* --------------------------------------
		       we have probably found a format that
		       looks like "X(40)" or similar
		       -------------------------------------- */

		    charFormat = substring(charFormat,intTemp + 1).

		    intTemp = index(charFormat,")").
		    if intTemp > 0 then do:
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
			    if index("1234567890",cTemp) = 0 then do:
				intTemp = length(_format). /* best guess */
				leave.
			    end.
			end.
			if i > intTemp then
			    intTemp = integer(charFormat) /* no-error */.
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
			    if intTemp <= 255 then assign
				iFormat = intTemp
				intTemp = 0.


			end.
		    end.
		end.

		charTextSize = "".
		charTextField = "".

		if intTemp > 0 then do:

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
		    if iFormat > 0 then
		        charFormat = "(" + string(iFormat) + ")".

		    else if intTemp > 0 then do:
			if substring(charFormat,1,1) = "X" then do:
			    charFormat = substring(charFormat,intTemp).
			end.
			else do:
			    intTemp = length(charFormat) - 2.
			    charFormat = "(" + string(intTemp) + ")".
			end.
		    end.
		    else do:
			/* try and work out how long the string is */
			charFormat = "(" + string(length(_format)) + ")".
		    end.
		end.
		PUT STREAM MX UNFORMATTED  charFormat.
		/* ----------------------------------
		    Set a default character value if required
		   --------------------------------- */
		if _initial <> ? then
		    charTemp = _initial.
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
	    else if _data-type="decimal" then do:
		PUT STREAM MX UNFORMATTED  "decimal(" length(_format)  - 1 ","  _decimals  ")".
		/* ----------------------------------
		    Set a default decimal value if required
		   --------------------------------- */
		if _initial <> ? then PUT STREAM MX UNFORMATTED  " DEFAULT " trim(_initial).
	    end.
	    /* ----------------------------------------------------------
	       INTEGER fields - We try to make the most efficient use of
	       MySQL datattypes
	       --------------------------------------------------------- */
	    else if _data-type="integer" then do:
		intTemp = length(_format).
		if intTemp < 3 then do:
		    PUT STREAM MX UNFORMATTED  "tinyint".
		end.
		else if intTemp < 5 then do:
		    PUT STREAM MX UNFORMATTED  "smallint".
		end.
		else if intTemp < 7 then do:
		    PUT STREAM MX UNFORMATTED  "mediumint".
		end.
		else do:
		    PUT STREAM MX UNFORMATTED  "integer".
		end.
		/* -------------------------------------
		    Add an integer default if required
		    ------------------------------------- */

		if _initial <> ? and _initial <> '' then PUT STREAM MX UNFORMATTED  " DEFAULT " trim(_initial).
	    end.
	    /* ------------------------------------------
	       LOGICAL data types become TINYINT because
	       there is no MySQL boolean data type
	       ------------------------------------------ */
	    else if _data-type="logical" then do:
		PUT STREAM MX UNFORMATTED  "tinyint".
		if _initial = "no" then PUT STREAM MX UNFORMATTED  " DEFAULT 0".
		else                    PUT STREAM MX UNFORMATTED  " DEFAULT 1".

	    end.
	    /* --------------------------------------------
	       DATES stay as date, but you can't carry over
	       the classic 'default TODAY'
	       -------------------------------------------- */
	    else if _data-type="date" then do:
		PUT STREAM MX UNFORMATTED  "date".
	    end.
	    /* --------------------------------------------
	       RAW is converted, but the routines can't convert
	       the data in the fields
	       -------------------------------------------- */
	    else if _data-type="raw" then do:
		PUT STREAM MX UNFORMATTED  "blob".
	    end.
	    /* --------------------------------------------
	       RECID (version 9 only)
	       -------------------------------------------- */
	    else if _data-type="recid" then do:
		PUT STREAM MX UNFORMATTED  "bigint".
	    end.
	    /* -----------------------------------------------
	       Any other type - this probably shouldnt happen
	       ----------------------------------------------- */
	    else do:
		PUT STREAM MX UNFORMATTED  "## Warning - writing an unparsed data type" skip.
		PUT STREAM MX UNFORMATTED  "## That MySQL might not know about" skip.
		PUT STREAM MX UNFORMATTED  _data-type.
	    end.
	    /* ------------------------------
	       A mandatory field?
	       ------------------------------ */
	    if _mandatory then PUT STREAM MX UNFORMATTED  " NOT NULL".

	    /* ----------------------------------
	       Add a comma if not the last field,
	       or still processing an array
	       ---------------------------------- */
	    if not last(_field-name) or intExtents <= _extent
		then PUT STREAM MX UNFORMATTED  "," skip.
	end.
    end.

    /* --------------------------------------------------------
       primary index is always the progress recid
       this is because mySQL demands a non-null, unique
       primary index - progress databases don't.
       -------------------------------------------------------- */

    PUT STREAM MX UNFORMATTED  "," skip "~tprimary key~t CONV_PRIMARY (PROGRESS_RECID)".

    /* -------------------------------
       Count the number of indices so
       that we know when to add commas
       -------------------------------- */
    intIdxCount = 0.
    for each _index of _file:
	/* ----- Version 8 -------- */
	find first _index-field of _index no-error.
	if not available _index-field then next.

	/* ----- Version 9 -------- */
	find _field where recid(_field) = _index-field._field-recid no-error.
	if not available _field then next.
	if _field-name = "" then next.

	/* ----------------------------------------
	   If there are no indices, we still get a
	   count of 1, so check for fields
	   e.g. SPORTS.LOCAL-DEFAULTS
	   ----------------------------------------- */
	intIdxCount = intIdxCount + 1.
    end.

    if intIdxCount > 0 then PUT STREAM MX UNFORMATTED  ",".
    PUT STREAM MX UNFORMATTED  skip.

    /* --------------------------------------------------
       Now loop through all the indices
       -------------------------------------------------- */
    intIdx = 0.
    if intIdxCount > 0 then
	for each _index of _file where can-find (first _index-field of _index)
	break by  _index-name.

	/* ------------------------------------------
	   Make a note of the original primary index
	   ------------------------------------------ */
	if recid(_index) =  _file._prime-index  then
	PUT STREAM MX UNFORMATTED  "## The PROGRESS database primary index" skip.
	charIndexName=caps(_index._index-name).
	run d2us.p(input-output charIndexName).
	/* -----------------------------------------
	   A standard index
	   ----------------------------------------- */

	/********************
	 * If you are using V9 and have word indexes then uncomment
	 * this line and comment out the do
	 if _index._Wordidx = ? then do:
	 */
	do:
	    PUT STREAM MX UNFORMATTED  "~tkey~t" charIndexName " (" skip.
	    /* ----------------------------------------
	       Count the number of fields in the index
	       ---------------------------------------- */
	    intIdxFldCount = 0.
	    for each _index-field of _index.
		intIdxFldCount = intIdxFldCount + 1.
	    end.
	    intIdxFld = 0.
	    for each _index-field of _index.
		find _field where recid(_field) = _index-field._field-recid.
		charFieldName=caps(_field._field-name).
		run d2us.p(input-output charFieldName).
		PUT STREAM MX UNFORMATTED  "~t~t~t" charFieldName.
		if charTextSize <> "" and charTextField = charFieldName then
		put stream MX unformatted charTextSize.
		intIdxFld = intIdxFld + 1.
		if intIdxFld < intIdxFldCount then PUT STREAM MX UNFORMATTED  "," skip.
	    end.

	    put stream MX unformatted ")".
	end.
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
	intIdx = intIdx + 1.
	if intIdx < intIdxCount then PUT STREAM MX UNFORMATTED  ",".
	PUT STREAM MX UNFORMATTED  skip.
	if last(_index-name) then PUT STREAM MX UNFORMATTED  ")" skip.
    end.


    if intIdxCount = 0 then PUT STREAM MX UNFORMATTED  ")" skip.
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
