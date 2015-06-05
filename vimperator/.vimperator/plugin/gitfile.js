//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                  gitfile.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// gitfile.js is a javascript plugin for Vimperator
// which allows you to download single files from
// Github.
//
// Dependencies:
//  - gitfiles.sh (https://github.com/spcmd/Scripts/raw/master/gitfile.sh)
//  - wget
//
// Usage: 
// - Copy & Paste gitfile.sh to somewhere in your $PATH
// - The default key map is ;g
//   You can map the default key to something else,
//   in your .vimperatorrc, for example: nmap gh ;g

hints.addMode ("g", "Download from Github: ",

     function(elem) {
         liberator.echomsg("Downloaded from Github: "+elem.href),
         liberator.execute("silent !gitfile.sh '"+ elem.href+"'")
     },
     function () "// a"
);
