// ==UserScript==
// @author	    spcmd
// @namespace 	http://github.com/spcmd
// @name        est.hu/tv
// @description est.hu/tv customized style
// @include     http://est.hu/tv/*
// @match       http://est.hu/tv/*
// @version     1.0
// @grant       none
// ==/UserScript==

// select multiple elements with the same IDs (http://stackoverflow.com/a/38055408)
var elms = document.querySelectorAll("[id='fomusor']");
for(var i = 0; i < elms.length; i++)
  elms[i].removeAttribute("id");

// set attrib to the selected table rows (http://stackoverflow.com/a/3649708)
var table = document.getElementById('musor-most');

// set attrib to the nth rows: this doesn't work, because the number of rows are changing dinamically
/*var rows = table.rows;*/
//rows[13].setAttribute("id", "fomusor");
/*rows[14].setAttribute("id", "fomusor");*/

// in order to fix this we have to select reverse, from the the last row (http://stackoverflow.com/a/9609475)
var row_21h = table.rows[ table.rows.length - 7 ];
row_21h.setAttribute("id", "fomusor");
var row_22h = table.rows[ table.rows.length - 6 ];
row_22h.setAttribute("id", "fomusor");
var row_23h = table.rows[ table.rows.length - 5 ];
row_23h.setAttribute("id", "fomusor");
