// ==UserScript==
// @author	    spcmd
// @namespace 	http://github.com/spcmd
// @name        duolingo course links
// @description quick links to course pages (for switching)
// @include     https://www.duolingo.com/*
// @match       https://www.duolingo.com/*
// @version     1.0
// @grant       none
// ==/UserScript==

// Check if one of our menu items exist, if not, then append them to the DOM (create our custom menu)
// This check is a workaround for the luakit browser which keeps appending the elements -- doesn't reload/refresh the DOM (bug)
// Not necessary for other modern browsers
var check_elem = document.getElementById('lang_hu_en');
if (check_elem === null) {

    // create a <li> node(s)
    var node_hu_en = document.createElement("li");
    var node_en_eo = document.createElement("li");

    // set the id's for the nodes
    node_hu_en.setAttribute('id', "lang_hu_en");
    node_en_eo.setAttribute('id', "lang_en_eo");

    // create link(s)
    var link_hu_en = document.createElement("a");
    var link_en_eo = document.createElement("a");
    //link_hu_en.textContent = "hu:en";
    //link_en_eo.textContent = "en:eo";
    link_hu_en.innerHTML = "<span class='flag flag-svg-micro flag-en'></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;angol (magyarul)";
    link_en_eo.innerHTML = "<span class='flag flag-svg-micro flag-eo'></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esperanto (in english)";
    link_hu_en.setAttribute('href', "https://www.duolingo.com/course/en/hu/");
    link_en_eo.setAttribute('href', "https://www.duolingo.com/course/eo/en/");

    // creater divider for the switch menu
    var divider = document.createElement("li");
    // divider is a class by duolingo (not created in this script!)
    divider.setAttribute('class', "divider");

    // append to link(s) to list(s)
    node_hu_en.appendChild(link_hu_en);
    node_en_eo.appendChild(link_en_eo);

    // append list(s) to the selected none (.dropdown-menu)
    document.getElementsByClassName("dropdown-menu")[0].appendChild(divider);
    document.getElementsByClassName("dropdown-menu")[0].appendChild(node_hu_en);
    document.getElementsByClassName("dropdown-menu")[0].appendChild(node_en_eo);

}
