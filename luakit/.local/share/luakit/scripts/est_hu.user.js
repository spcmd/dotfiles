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
.replace(/40 éves szűz/ig, '<span class="highlight">40 éves szűz</span>')
.replace(/Ace Ventura/ig, '<span class="highlight">Ace Ventura</span>')
.replace(/Amerikai Pite/ig, '<span class="highlight">Amerikai Pite</span>')
.replace(/Amerikai pszicho/ig, '<span class="highlight">Amerikai pszicho</span>')
.replace(/Amerikai szépség/ig, '<span class="highlight">Amerikai szépség</span>')
.replace(/Bad Boys/ig, '<span class="highlight">Bad Boys</span>')
.replace(/Die Hard/ig, '<span class="highlight">Die Hard</span>')
.replace(/Dumb és Dumber/ig, '<span class="highlight">Dumb és Dumber</span>')
.replace(/Elemi ösztön/ig, '<span class="highlight">Elemi ösztön</span>')
.replace(/Erőszakik/ig, '<span class="highlight">Erőszakik</span>')
.replace(/Felkoppintva/ig, '<span class="highlight">Felkoppintva</span>')
.replace(/Fegyvernepper/ig, '<span class="highlight">Fegyvernepper</span>')
.replace(/Fogságban/ig, '<span class="highlight">Fogságban</span>')
.replace(/igood Will Hunting/g, '<span class="highlight">Good Will Hunting</span>')
.replace(/Halálos fegyver/ig, '<span class="highlight">Halálos fegyver</span>')
.replace(/Harcosok Klubja/ig, '<span class="highlight">Harcosok Klubja</span>')
.replace(/Harry Potter/ig, '<span class="highlight">Harry Potter</span>')
.replace(/Hetedik/ig, '<span class="highlight">Hetedik</span>')
.replace(/Keresztapa/ig, '<span class="highlight">Keresztapa</span>')
.replace(/Kill Bill/ig, '<span class="highlight">Kill Bill</span>')
.replace(/Közelebb/ig, '<span class="highlight">Közelebb</span>')
.replace(/Lepattintva/ig, '<span class="highlight">Lepattintva</span>')
.replace(/Másnaposok/ig, '<span class="highlight">Másnaposok</span>')
.replace(/Mulholland Drive/ig, '<span class="highlight">Mulholland Drive</span>')
.replace(/Ponyvaregény/ig, '<span class="highlight">Ponyvaregény</span>')
.replace(/Social Network/ig, '<span class="highlight">Social Network</span>')
.replace(/Sin City/ig, '<span class="highlight">Sin City</span>')
.replace(/Számkivetett/ig, '<span class="highlight">Számkivetett</span>')
.replace(/Szemtől szemben/ig, '<span class="highlight">Szemtől szemben</span>')
.replace(/Terminál/ig, '<span class="highlight">Terminál</span>')
.replace(/Terminátor/ig, '<span class="highlight">Terminátor</span>')
.replace(/Viharsziget/ig, '<span class="highlight">Viharsziget</span>')
.replace(/Wall Street farkasa/ig, '<span class="highlight">Wall Street farkasa</span>')
.replace(/Watchmen/ig, '<span class="highlight">Watchmen</span>')
.replace(/Zodiákus/ig, '<span class="highlight">Zodiákus</span>')
;
