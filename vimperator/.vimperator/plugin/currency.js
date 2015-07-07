//                                      _
//         ___ _ __   ___ _ __ ___   __| |
//        / __| '_ \ / __| '_ ` _ \ / _` |
//        \__ | |_) | (__| | | | | | (_| |
//        |___| .__/ \___|_| |_| |_|\__,_|
//             |_|
//
//                   currency.js
//               Created by: spcmd
//           http://spcmd.github.io
//           https://github.com/spcmd
//           https://gist.github.com/spcmd
//
// Currency coverter which uses xe.com
// Usage: 
// :currency <amount> <from> <to>
// Example:
// :currency 100 usd eur

(function() {
    commands.addUserCommand(
          ['currency'],
          'Convert currency <amount> <from> <to>',
          function (args) {
                //open in new tab
                window.content.window.open('http://www.xe.com/currencyconverter/convert/?Amount='+args[0]+'&From='+args[1]+'&To='+args[2], '_blank');
            }
    );

})();
