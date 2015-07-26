//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//        logout-forum-faradtgoz-listazas.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd


// Ez a script a Vimperator verziója ennek: 
// https://greasyfork.org/en/scripts/11185-logout-hu-fáradt-gőz-topikokat-a-fórum-tetejére
// http://logout.hu/bejegyzes/spammer/logout_forum_fooldal_faradt_gozos_topikokat_a_tete.html

if (window.content.window.location.href == "http://logout.hu/forum/index.html") {

    var fejlec = "igen"; 

    var for_50 = window.content.window.document.getElementsByClassName('for_50');

    var for_60 = window.content.window.document.getElementsByClassName('for_60');
    var for_61 = window.content.window.document.getElementsByClassName('for_61');
    var for_62 = window.content.window.document.getElementsByClassName('for_62');
    var for_63 = window.content.window.document.getElementsByClassName('for_63');
    var for_64 = window.content.window.document.getElementsByClassName('for_64');
    var for_65 = window.content.window.document.getElementsByClassName('for_65');
    var for_23 = window.content.window.document.getElementsByClassName('for_23');
    var for_24 = window.content.window.document.getElementsByClassName('for_24');
    var for_25 = window.content.window.document.getElementsByClassName('for_25');
    var for_27 = window.content.window.document.getElementsByClassName('for_27');

    for_50[0].parentNode.insertBefore(for_60[0], for_50[0].nextSibling);

    for_60[0].parentNode.insertBefore(for_61[0], for_60[0].nextSibling);
    for_61[0].parentNode.insertBefore(for_62[0], for_61[0].nextSibling);
    for_62[0].parentNode.insertBefore(for_63[0], for_62[0].nextSibling);
    for_63[0].parentNode.insertBefore(for_64[0], for_63[0].nextSibling);
    for_64[0].parentNode.insertBefore(for_65[0], for_64[0].nextSibling);
    for_65[0].parentNode.insertBefore(for_23[0], for_65[0].nextSibling);
    for_23[0].parentNode.insertBefore(for_24[0], for_23[0].nextSibling);
    for_24[0].parentNode.insertBefore(for_25[0], for_24[0].nextSibling);
    for_25[0].parentNode.insertBefore(for_27[0], for_25[0].nextSibling);

    var nodes = window.content.window.document.body.getElementsByTagName('tr');
    var last=nodes.length-1;
    var node = nodes[last];

    if (node) { node.setAttribute("class", "faradtgoz_fejlec"); }
    var for_60 = window.content.window.document.getElementsByClassName('for_60');

    var faradtgoz_fejlec = window.content.window.document.getElementsByClassName('faradtgoz_fejlec');

    if (fejlec == "igen") {
        
        for_50[0].parentNode.insertBefore(faradtgoz_fejlec[0], for_50[0].nextSibling);
        
    } else {
      
      node.parentNode.removeChild (node);
      
    }

}
