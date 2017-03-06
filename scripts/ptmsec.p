/* --------------------------------------------------------------------
   ptmsec.p - A routine to dump _user records from a progress database
   and create GRANT statements for MySQL.
   
   inputs: none
   outputs: A file named 'dbname'_SECURITY.SQL 

   Copyright (c)2001 KM Newnham mark@newnhams.com
   Version 1.0 Original release 21st Dec 2001

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


/* ------------------------ streams ----------------------------------------- */
def new shared stream MAINSTREAM.
/* ------------------------- DEFINES ---------------------------------------- */
&GLOBAL-DEFINE PSMU  PUT STREAM MAINSTREAM UNFORMATTED 

/* ---------------------- TEMPORARY VARIABLES ------------------------------- */

def var charSecFile as character format "x(60)"                         NO-UNDO.
def var charText    as character format "x(60)"                         NO-UNDO.
def var charDB    as character format "x(60)"                           NO-UNDO.
def var charUserList as character format "x(1000)"                      NO-UNDO.
def var intTemp    as integer                                           NO-UNDO.

/* ----------------------------- MAIN --------------------------------------- */
find first _user no-error.
if not available _user then do:
    message "There are no user records to export" view-as alert-box error.
    return.
end.

charDB = ldbname(1).
run dashtous(input-output charDB).

for each _user:
    charUserList = charUserList + " " + _userid.
end.

charSecfile = charDB + "_security.sql".

run dashtous(input-output charSecFile).

output stream mainstream to value(charSecFile).
charText=ldbname(1).
run dashtous(input-output charText).
{&PSMU} "## Security definitions dump for database " charText skip.

/* put stream mainstream unformatted "USE " charText ";" skip. */

/* -----------------------------------------------------
   start with some db privileges, 
   then add on the relevant ones as necessary
   ----------------------------------------------------- */
for each _user no-lock:
    run addPriv("USAGE",charText + ".*",_userid).
end.

/* -----------------------------------------------------
   start by revoking all table privileges, 
   from users in the progress database
   ----------------------------------------------------- */
for each _user no-lock:
    for each _file where _file-name < "_" and _hidden = false no-lock:
        charText =_file-name.
	run dashtous (input-output charText).
	charText = charDB + "." + charText.
        run revokePriv("ALL PRIVILEGES",charText,_userid).
    end.
end.

/* ------------------------------------------------------
    Do table level conversions
   ------------------------------------------------------ */
for each _file where _file-name < "_" and _hidden = false no-lock:
    charText =_file-name.
    run dashtous (input-output charText).
    charText = charDB + "." + charText.
    
    run checkPriv(_can-read,"SELECT",charText).
    run checkPriv(_can-create,"INSERT",charText).
    run checkPriv(_can-delete,"DELETE",charText).
    run checkPriv(_can-write,"UPDATE",charText).

end.
output stream mainstream close.

/* ------------------------------ END OF MAIN ------------------------------- */
PROCEDURE checkPriv:
    define input parameter UserList as character format "x(1000)"       NO-UNDO.
    define input parameter Priv     as character format "x(80)"         NO-UNDO.
    define input parameter onVal    as character format "x(80)"         NO-UNDO.

    define variable intTemp as integer                                  NO-UNDO.
    define variable intTemp2 as integer                                 NO-UNDO.
    define variable charTemp as character format "x(20)"                NO-UNDO.
    define variable userArray as character format "x(20)" extent 100    NO-UNDO.
    define variable logWildcard   as logical                            NO-UNDO.
    define variable logMatch      as logical                            NO-UNDO.
    define variable intBlankPos   as integer                            NO-UNDO.

    intTemp = lookup("*",UserList).
    if intTemp > 0 then do:
        /* -----------------------
           Start by adding all users
           to the list
           ------------------------- */
        intTemp = 1.
        for each _user.
            userArray[intTemp] = _user._userid.
            intTemp = intTemp + 1.
        end.
    end.
    intTemp = 0.
    repeat:
        intTemp = intTemp + 1.
        charTemp = entry (intTemp,UserList) no-error.
        if error-status:error then leave.
        if charTemp = "*" then next.
        logWildCard = false.
        logMatch = false.
        intTemp2 = index(charTemp,"!").
        if intTemp2 = 0 then do:
            /* --------------
               allowed matches
               ---------------- */
            intTemp=index(charTemp,"*").
            if intTemp = 0 then do:
                /* -----------------
                   unique userid
                   ----------------- */
                do intTemp = 1 to 100:
                    if userArray[intTemp] = "" then intBlankPos = intTemp.
                    if userArray[intTemp] = charTemp then leave.
                end.
                if intTemp = 101 then userArray[intBlankPos] = charTemp.
            end.
            else do:
                /* ---------------
                  wildcard matches
                  --------------- */
                charTemp = substring(charTemp,1,intTemp2 - 1).
                for each _user:
                    if substring(_user._userid,1,length(charTemp)) = charTemp
                    then do:
                        do intTemp = 1 to 100:
                            if userArray[intTemp] = "" 
                                then intBlankPos = intTemp.
                            if userArray[intTemp] = charTemp then leave.
                        end.
                        if intTemp = 101 
                            then userArray[intBlankPos] = _user._userid.
                    end.
                end.
            end.
        end.
        else do:
            charTemp = substring(charTemp,2).
	        /* ---------------
               disallowed matches
               ------------------- */
            intTemp2=index(charTemp,"*").
            if intTemp2 = 0 then do:
               
                /* -----------------
                   unique userid
                   ----------------- */
                do intTemp = 1 to 100:
                    if userArray[intTemp] = charTemp 
                        then userArray[intTemp] = "".
                end.
           end.
           else do:
                /* ---------------
                   wildcard matches
                   --------------- */
                charTemp = substring(charTemp,1,intTemp2 - 1).
                for each _user:
                    if substring(_user._userid,1,length(charTemp)) = charTemp 
                    then do:
                        do intTemp = 1 to 100:
                            if userArray[intTemp] = charTemp 
                                then userArray[intTemp] = "".
                        end.
                    end.
                end.
            end.
        end.
    end.
    do intTemp = 1 to 100:
        if userArray[intTemp] <> "" then 
            run addPriv(Priv,onVal,userArray[intTemp]).
    end.
end procedure.

PROCEDURE addPriv:
    define input parameter Priv     as character format "x(80)"         NO-UNDO.
    define input parameter onVal    as character format "x(80)"         NO-UNDO.
    define input parameter toUse    as character format "x(8)"          NO-UNDO.
    
    
    put stream mainstream unformatted
    "GRANT " Priv " ON " onVal " TO " toUse "@localhost;" skip.
    
    
end PROCEDURE.

PROCEDURE revokePriv:
    define input parameter Priv     as character format "x(80)"         NO-UNDO.
    define input parameter onVal    as character format "x(80)"         NO-UNDO.
    define input parameter toUse    as character format "x(8)"          NO-UNDO.
    
    
    put stream mainstream unformatted
    "REVOKE " Priv " ON " onVal " FROM " toUse "@localhost;" skip.
    
    
end PROCEDURE.

{dashtous.i}

/* ------------------------  THE END ---------------------------------------- */
