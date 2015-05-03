"                                      _
"         ___ _ __   ___ _ __ ___   __| |
"        / __| '_ \ / __| '_ ` _ \ / _` |
"        \__ | |_) | (__| | | | | | (_| |
"        |___| .__/ \___|_| |_| |_|\__,_|
"             |_|
"
"                    .gvimrc
"               Created by: spcmd
"           http://spcmd.github.io
"           https://github.com/spcmd
"           https://gist.github.com/spcmd

"GUI specific settings only. Main stuff is in the .vimrc

set lines=35 columns=110                            "default window size
set guicursor+=i:ver25-iCursor                      "insert cursor in GVim, need for coloring
set guicursor+=a:blinkon0                           "disable cursor blinking
set guioptions-=emrLT                               "remove menu, toolbar, tab bar, scrollbars
set guifont=Liberation\ Mono\ for\ Powerline\ 10    "font type for GVim

hi Cursor guifg=#000000 guibg=#dfff00
hi iCursor guifg=#ffffff guibg=#005fff
