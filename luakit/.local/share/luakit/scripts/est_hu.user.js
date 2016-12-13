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

// highlight movie titles
document.body.innerHTML = document.body.innerHTML
.replace(/40 éves szűz/g, '<span class="highlight">40 éves szűz</span>')
.replace(/Ace Ventura/g, '<span class="highlight">Ace Ventura</span>')
.replace(/Amerikai Pite/g, '<span class="highlight">Amerikai Pite</span>')
.replace(/Amerikai Pszicho/g, '<span class="highlight">Amerikai Pszicho</span>')
.replace(/Amerikai Szépség/g, '<span class="highlight">Amerikai Szépség</span>')
.replace(/Bad Boys/g, '<span class="highlight">Bad Boys</span>')
.replace(/Die Hard/g, '<span class="highlight">Die Hard</span>')
.replace(/Dumb és Dumber/g, '<span class="highlight">Dumb és Dumber</span>')
.replace(/Elemi ösztön/g, '<span class="highlight">Elemi ösztön</span>')
.replace(/Erőszakik/g, '<span class="highlight">Erőszakik</span>')
.replace(/Felkoppintva/g, '<span class="highlight">Felkoppintva</span>')
.replace(/Fegyvernepper/g, '<span class="highlight">Fegyvernepper</span>')
.replace(/Fogságban/g, '<span class="highlight">Fogságban</span>')
.replace(/Good Will Hunting/g, '<span class="highlight">Good Will Hunting</span>')
.replace(/Halálos Fegyver/g, '<span class="highlight">Halálos Fegyver</span>')
.replace(/Harcosok Klubja/g, '<span class="highlight">Harcosok Klubja</span>')
.replace(/Harry Potter/g, '<span class="highlight">Harry Potter</span>')
.replace(/Hetedik/g, '<span class="highlight">Hetedik</span>')
.replace(/Keresztapa/g, '<span class="highlight">Keresztapa</span>')
.replace(/Kill Bill/g, '<span class="highlight">Kill Bill</span>')
.replace(/Közelebb/g, '<span class="highlight">Közelebb</span>')
.replace(/Lepattintva/g, '<span class="highlight">Lepattintva</span>')
.replace(/Másnaposok/g, '<span class="highlight">Másnaposok</span>')
.replace(/Mulholland Drive/g, '<span class="highlight">Mulholland Drive</span>')
.replace(/Ponyvaregény/g, '<span class="highlight">Ponyvaregény</span>')
.replace(/Social Network/g, '<span class="highlight">Social Network</span>')
.replace(/Sin City/g, '<span class="highlight">Sin City</span>')
.replace(/Számkivetett/g, '<span class="highlight">Számkivetett</span>')
.replace(/Terminál/g, '<span class="highlight">Terminál</span>')
.replace(/Terminátor/g, '<span class="highlight">Terminátor</span>')
.replace(/Viharsziget/g, '<span class="highlight">Viharsziget</span>')
.replace(/Wall Street farkasa/g, '<span class="highlight">Wall Street farkasa</span>')
.replace(/Watchmen/g, '<span class="highlight">Watchmen</span>')
.replace(/Zodiákus/g, '<span class="highlight">Zodiákus</span>')
;
