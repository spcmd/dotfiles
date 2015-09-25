//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                   phtools.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// Tools for prohardver.hu forum

// phlinkformat
// Az aktuális oldal linkjéből és címéből készít
// egy PH fórum kompatiblis link taget.
// Használat: 
// :phlinkformat
// A fórumba beillesztendő link tag automatikusan a vágólapra kerül.
// Példa key map: nmap Y :phlinkformat<CR>
(function() {
    commands.addUserCommand(
          ['phlinkformat'],
          'Az aktuális oldal címéből és url-jéből ph fórum link készítése',
          function() { 
             var raw_title = document.title
             var link = window.content.window.location.href 
             var title = raw_title.replace(/ ?-(?!.*-).+/, "") //remove: "- Site title" at the end.
             //alert("[L:"+link+"]"+title+"[/L]")
             util.copyToClipboard("[L:"+link+"]"+title+"[/L]", true)
             liberator.echomsg("PH! Link Format: '"+title+"' & the URL copied to the clipboard.")
          }
    );

})();

// phusercomment
// Aktuális topikban kereshetsz a megadott
// kulcsszóra a megadott felhasználó
// hozzászólásai között.
// Használat:
// :phusercomment <kulcsszó> <felhasználónév> 
(function() {
    commands.addUserCommand(
          ['phusercomment'],
          'PH!: hsz keresése a megadott felhasználónál [kulcsszó felhasználónév]',
          function (args) {
                window.content.window.location = window.content.window.location.href.match( /^(http.+\/)[^\/]+$/ )[1] +'keres.php?type=-&stext=' + args[0] + '&suser=' + args[1];
            }
    );

})();
