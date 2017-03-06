/******
 replace.p - A replacement for replace for old versions of progress that dont have it
 */

 define input-output	parameter cString as character no-undo.
 define input		parameter cFrom as character no-undo.
 define input		parameter cTo  as character no-undo.

 def var oString as character no-undo.
 def var nString as character no-undo.

 def var i as int no-undo.
 def var j as int no-undo.
 def var c as char no-undo.

 oString = cString.
 j = length(oString).
 do i = 1 to j:
    c = substring(oString,i,1).
    if c = cFrom then
      nString = nString + cTo.
    else
      nString = nString + c.
 end.
 cString = nString.
	