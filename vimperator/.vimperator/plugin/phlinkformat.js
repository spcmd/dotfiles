//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                phlinkformat.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// Az akutális oldal linkjéből és címéből készít
// egy PH fórum kompatiblis link taget.
//
// Használat:
// :phlinkformat
// aztán az alert ablakból kimásoljuk a kódot.


(function() {
    commands.addUserCommand(
          ['phlinkformat'],
          'Az aktuális oldal címéből és url-jéből ph fórum link készítése',
          function() { 
             var raw_title = document.title
             var link = window.content.window.location.href 
             var title = raw_title.replace(/ ?-(?!.*-).+/, "") //remove: "- Site title" at the end.
             alert("[L:"+link+"]"+title+"[/L]")
          }
    );

})();

