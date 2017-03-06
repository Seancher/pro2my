/* ---------------------------------------------------------------------
   cwrite.p Is used to reduce the size of the statements in inc2.p, preventing edit buffer problems
   in earlier versions of PROGRESS. It does special character replacements, replacing
   ptmspec.p , which was used to preprocess tables for special characters. This is is now
   done at run-time.

   inputs: the string to check
   outputs: void
   requires: the previously defined STREAM MX 

   Copyright (c)2004 KM Newnham mark@newnhams.com
   Version 1.0 Original release 22nd Nov 2004
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


def shared stream MX.
def input parameter cTemp as character no-undo.

cTemp = trim(cTemp).
run replace.p(input-output cTemp,"~\","~\~\'").
run replace.p(input-output cTemp,"'","~\'").
PUT stream MX unformatted cTemp.