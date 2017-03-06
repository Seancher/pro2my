/* -----------------------------------------------------------------------------
   A procedure that writes confusing streamed output
   called by:   ptmd.p
   inputs:      The text to write
   outputs:     void
   requires:	Previously defined stream inc1
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

   def shared stream inc1. 
   define input parameter data-type as character format "x(10)".
    
    if data-type = "character" or data-type = "date" then do:
    
        PUT STREAM INC1 UNFORMATTED  " ~"'~" ".
    
    end.
    else do:
    
        PUT STREAM INC1 UNFORMATTED  " ~" ~" ".  
    
    end.

