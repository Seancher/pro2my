/* ---------------------------------------------------------------------
   d2us.p
   A procedure that takes a progress db/file/field name, converts it
   to upper case, substitutes _ for - and checks against mysql reserved
   words
   inputs: the string to check
   outputs: the checked and converted string
   requires: the previously defined STREAM MX 

   Copyright (c)2001-2004 KM Newnham mark@newnhams.com
   Version 1.0 Original release 21st Dec 2001
   Version 2.0 Reworked for V6  22nd Nov 2004
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
   --------------------------------------------------------------------- */

define input-output parameter  charIn      as character format "x(60)"  NO-UNDO.
define shared stream MX.

    /* --------------------------------
       replace - with _
       ------------------------------- */
    run replace.p(input-output charIn,"-","_").

    /* -------------------------------
       change to upper case - you can
       change this if you want all 
       lower case variables. But you
       should be consistent with MySQL
       ------------------------------- */
    charIn = caps(charIn).
    
    /* -------------------------------
       check for reserved words
       ------------------------------- */

    if lookup(charIn,"{mysqlr.i}") > 0 then do:
        PUT STREAM MX UNFORMATTED  "## Warning " charIn " is a MySQL reserved word.".
            PUT STREAM MX UNFORMATTED  "Its value was changed to " .
        charIn = "X_" + charIn.
        PUT STREAM MX UNFORMATTED  charIn skip.
    end.
    
     /* -------------------------------
       check for special characters in names
       ------------------------------- */

    if index(charIn,"#") > 0 then do:
        PUT STREAM MX UNFORMATTED  "## Warning " charIn " contains '#' which is a MySQL special character.".
            PUT STREAM MX UNFORMATTED  " Its value was changed to " .
        run replace.p (input-output charIn,"#","NUM").
        PUT STREAM MX UNFORMATTED  charIn skip.
    end.
    if index(charIn,"%") > 0 then do:
        PUT STREAM MX UNFORMATTED  "## Warning " charIn " contains '%' which is a MySQL special character.".
            PUT STREAM MX UNFORMATTED  " Its value was changed to " .
        run replace.p(input-output charIn,"%","PCT").
        PUT STREAM MX UNFORMATTED  charIn skip.
    end.

/*---------------------------------- the end -------------------------------- */
