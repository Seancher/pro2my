/* -----------------------------------------------------------------------------
   A procedure that initiates the data dump for all tables, or a
   particular table. This is mostly achieved by dynamically generataing some
   include files, which are then executed by ptmd2.p
   called by:   The procedure editor or your program
   inputs:      the table to dump or the word "ALL"
   outputs:     a test file with the required data

   Copyright (c)2001 KM Newnham mark@newnhams.com
   Version 1.0 Original release 21st Dec 2001

   -----------------------------------------------------------------------------
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

/* -------------------------------------------------------------------------- */
def input parameter ipFile      as char format "x(30)"         NO-UNDO.
/* --------------------------- STREAMS -------------------------------------- */
define new shared       stream INC1.
define                  stream INC2.
define new shared       stream MX.
/* --------------------------------------------------------------------------
&GLOBAL-DEFINE PSMU  PUT STREAM MX UNFORMATTED
&GLOBAL-DEFINE PSI1U PUT STREAM INC1 UNFORMATTED
&GLOBAL-DEFINE PSI2U PUT STREAM INC2 UNFORMATTED
 -------------------------------------------------------------------------- */
def var intCurrentExtent   as integer                      NO-UNDO.
def var logIsArray         as logical                  NO-UNDO.
def var intExtents         as integer                  NO-UNDO.
def var charFieldName      as char                         NO-UNDO.
def var charLastFieldName  as char format "x(50)"          NO-UNDO.
def var charFileName       as character format "x(50)"     NO-UNDO.
def var intFieldCount      as integer                      NO-UNDO.
def var logFirstField      as logical initial yes          NO-UNDO.
def var lEmpty			   as logical initial false		NO-UNDO.
def var cTemp			   as char                         NO-UNDO.
def var lAll			   as logical                      no-undo.
                           
DEF VAR mysqlcmd           AS CHAR INITIAL '~\mysql~\bin~\mysql -u root' NO-UNDO.                              
    
/* ---------------------------------------------------------------------------
if ipFile = "ALL" then charFileName = ldbname(1)  + "_data.sql".
		  else charFileName = ipFile + "_data.sql".

run d2us.p(input-output charFileName).
*/


if (ipFile = "ALL") then do:
	lAll = true.
	if opsys = 'unix' then do:
	  cTemp = 'rm mysqlld.bat'.
	  unix silent value(cTemp).
	end.
	else do:
	  cTemp =  "del mysqlld.bat".
	  dos silent value (cTemp).
	end.
end.
for each _file where (( _file-name  < '_' and ipFile  = "ALL" )
		  or  ( _file-name = ipFile    and ipFile <> "ALL"))
		 AND _hidden = FALSE no-lock:

   ipFile = _file._file-name.
   pause 1 no-message.
   status default "Processing " + ipFile.
   
    if search('avail.p') <> ? then do:
	    IF OPSYS = 'unix' THEN
            UNIX SILENT 'rm avail.p'.
        ELSE
            dos silent "del avail.p".
    END.
    cTemp = "def output parameter l as log no-undo.~nfind first " + _file-name + " no-lock no-error.~nIf not available " + _file-name + " then l = true.~n".
    output to avail.p.
    put unformatted cTemp.
    output close.
    run avail.p (output lEmpty).
    if lEmpty then do:
	    charFileName = _file._dump-name + '.SQL'.
		if search(charFileName) = ? then next.
		IF OPSYS = 'unix' THEN DO:
            cTemp = 'rm ' + charFileName.
            UNIX SILENT VALUE(cTemp).
        END.
        ELSE DO:
            cTemp = "del " + charFileName.
		    dos silent value(cTemp).
        END.
        next. 
    end.
    if lAll then do:
    	output to "mysqlld.bat" append.
		put unformatted mysqlcmd " < " _file._dump-name ".SQL" skip.
		output close.
	end.

    cTemp = _file._dump-name + ".SQL".

   output stream MX to value(cTemp).
   charFileName = LDBNAME(1).
   run d2us.p(input-output charFileName).

   PUT STREAM MX UNFORMATTED  "USE " charFileName ";" skip.

    logFirstField = yes.
    intFieldCount = 0.
    for each _field of _file.
	intFieldCount = intFieldCount + 1.
    end.

    charFileName = _file._file-name.
   
    run d2us.p (input-output charFileName).

    PUT STREAM MX UNFORMATTED  skip "LOCK TABLE " trim(charFileName) " WRITE;" skip.
    PUT STREAM MX UNFORMATTED  skip "INSERT INTO " trim(charFileName) " VALUES ".



    intCurrentExtent = 0.
    for each _field of _file.
	 charLastFieldName = _field-name.
    end.

    output stream INC1 to "inc1.i".
    output stream INC2 to "inc2.i".
   PUT STREAM INC1 UNFORMATTED  "/* COMMENT */" skip.
   PUT STREAM INC1 UNFORMATTED  "PUT STREAM MX UNFORMATTED ~"(~" ".

    /* -------------------------------------------
       Add the recid to create a primary index
       ------------------------------------------- */

   PUT STREAM INC1 UNFORMATTED  " RECID(" _file-name ") ~",~"." skip.
   PUT STREAM INC1 UNFORMATTED  "PUT STREAM MX UNFORMATTED  ".

    for each _field of _file.


	intExtents = 0.
	logIsArray = false.
	if _field._extent > 0 then do:
	    intExtents = 1.
	    logIsArray = true.
	end.

	repeat while intExtents <= _field._extent:

	    if logFirstField = no then do:
		if _data-type = "character" or _data-type = "date" then do:
		    PUT STREAM INC1 UNFORMATTED  " ~",~'~" ".
		end.
		else do:
		    PUT STREAM INC1 UNFORMATTED  " ~",~" ".
		end.
	    end.
	    else do:
		if _data-type = "character" or _data-type = "date" then do:
		    PUT STREAM INC1 UNFORMATTED  " ~"~'~" ".
		end.
		else do:
		    PUT STREAM INC1 UNFORMATTED  " ".
		end.
	    end.
	    if logIsArray = false then do:
		intExtents = 1.
		charFieldName = _field-name.
	    end.
	    else do:
		charFieldName = _field-name + "[" + string(intExtents) + "]".
		intExtents = intExtents + 1.
	    end.

	    /* -----------------------------------------------
	       Extract the date so that is can be built in ISO
	       format. This should allow European format dates
	       to be processed correctly as well as US
	       ----------------------------------------------- */
	    if _data-type = "date" then do:
		intCurrentExtent = intCurrentExtent + 1.
		PUT STREAM INC2 UNFORMATTED  " strDate[" + string(intCurrentExtent) + "]
			 = string(year(" + charFieldName + "),~"9999~") + ~"-~"
			 + string(month(" + charFieldName + "),~"99~")
			 + ~"-~" + string(day(" + charFieldName + "),~"99~").".

		PUT STREAM INC1 UNFORMATTED  "strDate[" + string(intCurrentExtent) + "]".
	    end.
	    else if _data-type = "character" then do:

		/*
		PUT STREAM INC1 UNFORMATTED  "trim(" charFieldName ")." skip.
		*/
		PUT STREAM INC1 UNFORMATTED '.' skip.
		PUT STREAM INC1 UNFORMATTED "run cwrite.p(" charFieldName ")." skip. 
		
		PUT STREAM INC1 UNFORMATTED  "PUT STREAM MX UNFORMATTED " .
		

	    end.
	    /* ------------------------------------------
	       Convert logicals to integers because we
	       are going to put them in a tinyint field
	       ------------------------------------------ */
	    else if _data-type = "logical" then do:
		    PUT STREAM INC1 UNFORMATTED  "integer(" charFieldName ")".
	    end.
	 /* ------------------------------------------
	       Currently Convert version 9 RAW DATA to
	       nothing
	       ------------------------------------------ */
	    else if _data-type = "raw" then do:
		    PUT STREAM INC1 UNFORMATTED   "~"NULL~"" .
	    end.

	    else if _data-type = "recid" then do:
		    PUT STREAM INC1 UNFORMATTED  "if " charFieldName "= ? then 0 else integer(" charFieldName ")".
	    end.
	    else do:
		/* ---------------------------------------
		   Convert an unknown value to zero,
		   otherwise, just write the value
		   this is for decimals, integers
		   -------------------------------------- */
		PUT STREAM INC1 UNFORMATTED
		"if " charFieldName " = ? then 0 else " charFieldName.
	    end.

	    run ws.p (_data-type).
	    /*
	    if _field-name <> charLastFieldName then do:
	       run ws.p (_data-type).
	    end.
	    else do:
		if logIsArray = false then
		    run ws.p(_data-type).
		else do:
		    if intExtents > _field._extent then

			PUT STREAM INC1 UNFORMATTED  " ~"'~" ".
		    else
			PUT STREAM INC1 UNFORMATTED  "~"',~" ".
		end.
	    end.
	    */
	    logFirstField = no.
	end.
	logFirstField = no.
	PUT STREAM INC1 UNFORMATTED  "." skip "PUT STREAM MX UNFORMATTED ".
    end.
    PUT STREAM INC1 UNFORMATTED  "skip." skip.
    /*
    put stream inc1 " ~"),~".".
    */
    output stream INC1 close.
    output stream INC2 close.

    /* ---------------------------------------------------------
       Now we have built the includes, lets run the program to
       extract the data
       --------------------------------------------------------- */

    run ptmd2.p _file-name.

    /* -----------------------------
       put in a note for debugging
       ----------------------------- */

    PUT STREAM MX UNFORMATTED  skip "## END OF " _file-name skip.
    output stream MX close.
end.
