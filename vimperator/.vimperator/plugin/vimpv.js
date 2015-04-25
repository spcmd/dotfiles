//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                    Vimpv
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// Vimpv is a javascript plugin for Vimperator
// which allows you to follow/open video urls with mpv.
// Tested on Youtube and Vimeo.
//
// Usage: the default key map is ;m
// You can map the default key to something else,
// for example, if you don't use the 'mark' command
// you can map it to 'm' in your .vimperatorrc:
// nmap m ;m

hints.addMode ("m", "Vimpv Play video: ",

     function(elem) {
         liberator.echomsg("Vimpv Playing: "+elem.title),
         liberator.execute("silent !mpv '"+ elem.href+"'")
     },
     function () "// a"
);
