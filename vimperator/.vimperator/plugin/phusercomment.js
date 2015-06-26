//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                phusercomment.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// Aktuális topikban kereshetsz a megadott
// kulcsszóra a megadott felhasználó
// hozzászólásai között.
//
// Használat:
// :phusercomment <kulcsszó> <felhasználónév> 

(function() {
    commands.addUserCommand(
          ['phusercomment'],
          'PH!: hsz keresés a megadott felhasználónál [kulcsszó felhasználónév]',
          function (args) {
                window.content.window.location = window.content.window.location.href.match( /^(http.+\/)[^\/]+$/ )[1] +'keres.php?type=-&stext=' + args[0] + '&suser=' + args[1];
            }
    );

})();

