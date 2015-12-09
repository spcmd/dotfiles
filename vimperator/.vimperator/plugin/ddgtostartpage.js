//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//               ddgtostartpage.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
//  If Duckduckgo won't give you proper results
//  quickly search with Startpage by using the existing
//  search query. Startpage is using Google's search
//  engine, but it won't track you.
// 
//  The current (Duckduckgo) tab will be redirected
//  to Startpage. If you want to open Startpage's results
//  in a new tab, set the 'target' variable below to '_blank'


(function() {
    commands.addUserCommand(
          ['sp'],
          'Search this expression with startpage',
          function () {
                    // Open Startpage's results in the same tab or new tab?
                    // Set the 'target' variables value: 
                    //  _parent  (same tab)
                    //  _blank   (new tab)
                    var target='_parent' 
                    
                    // Extract the query form the URL
                    var extractedQuery = window.content.window.location.search;

                    // We don't need the '?q=' part, just the plain expression
                    var query = extractedQuery.substring(3);

                    // Get the search results with Startpage
                    window.content.window.open('https://startpage.com/do/metasearch.pl?query='+query, target);
            }
    );

})();
