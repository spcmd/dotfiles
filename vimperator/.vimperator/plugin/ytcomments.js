//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                 ytcomments.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// ytcomments.js is a javascript plugin for Vimperator
// which allows you to directly open the comments page
// of the videos.
//
// Usage: the default key map is ;j

hints.addMode ("j", "Youtube - jump to comments: ",

     function(elem) {

        // youtube id js source: http://stackoverflow.com/a/3452617
        var video_id = elem.href.split('v=')[1];
        var ampersandPosition = video_id.indexOf('&');
        if(ampersandPosition != -1) {
          video_id = video_id.substring(0, ampersandPosition);
        }

         //liberator.echomsg("https://www.youtube.com/all_comments?v="+video_id)
         liberator.execute("open https://www.youtube.com/all_comments?v="+video_id)
     },
     function () "// a"
);
