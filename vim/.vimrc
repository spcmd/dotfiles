" ========================================================= "
" .vimrc                                                    "
" Created by: spcmd                                         "
" Website: http://spcmd.github.io                           "
"          https://github.com/spcmd                         "
"          https://gist.github.com/spcmd                    "
" ========================================================= "

"----------"
" Settings "
"----------"
execute pathogen#infect()
syntax on
filetype plugin indent on
set number                                          "line numbers
colorscheme spcmd                                   "color scheme
set showcmd                                         "show commands at the bottom
set linebreak                                       "allow linebreaks between words
"set hlsearch                                       "highlight search results
set ruler                                           "show line and cursor position
set expandtab                                       "convert tabs to spaces
set tabstop=4                                       "tab width
set shiftwidth=4                                    "indent width
set encoding=utf-8                                  "default encode
set guicursor+=i:ver25-iCursor                      "insert cursor in GVIM, need for coloring
set guicursor+=a:blinkon0                           "disable cursor blinking
set guioptions=aegimrLt                             "remove Toolbar
set guioptions-=mrL                                 "remove: menu bar & scroll bars
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10  "font type for GVim
set guifont=Liberation\ Mono\ for\ Powerline\ 10    "font type for GVim"
set t_Co=256                                        "set terminal to 256 color
"set lines=25 columns=90                            "set in ~/.gvimrc for GVIM
set rnu                                             "relative line numbering
set cursorline                                      "highlight current line
let NERDTreeShowBookmarks=1                         "show NERDTree Bookmarks
set laststatus=2                                    "always show statusline/airline
set noshowmode                                      "disable default mode indicator (using airline's)
let g:airline#extensions#tabline#enabled = 1        "display buffers at top
let g:airline_powerline_fonts = 1                   "load patched powerline fonts
let g:airline_theme='spcmd'                         "set airline theme

"Colorize cursor in terminal vim
if &term =~ "xterm\\|rxvt"
  "color in insert mode
  let &t_SI = "\<Esc>]12;DodgerBlue\x7"
  "color in other modes
  let &t_EI = "\<Esc>]12;yellow\x7"
  silent !echo -ne "\033]12;yellow\007"
  "reset cursor color when vim exits
  autocmd VimLeave * silent !echo -ne "\033]12;white\007"
endif

"Colorize cursor in GVim
hi Cursor guifg=#000000 guibg=#dfff00
hi iCursor guifg=#ffffff guibg=#005fff

"----------------------"
" Commands & Functions "
"----------------------"
"Toggle Relative Line Numbering
command! RL if &relativenumber == 1|set nornu|else|set rnu|endif

"Toggle GVIM menu
command! Menu if &go=~'m'|set go-=m|else|set go+=m|endif

"Keep GVIM window open: make new empty tab then close (the last) file
command! QQ tabnew|tabprevious|bd

"Remove Trailing White Space
command! RWS %s/\s\+$//|echom "Removing trailing white spaces"

"Source .vimrc
if !exists("*ReloadVimrc")
 function! ReloadVimrc()
  source ~/.vimrc
  echom "Done: sourcing .vimrc"
 endfunction
 command! Vimrc :call ReloadVimrc()
endif

"----------"
" Keybinds "
"----------"
imap éé <Esc>
vmap éé <Esc>
imap űű <Esc>"*pA
imap áá <Esc>"+p
map <Enter> o<ESC>
map <S-Enter> O<ESC>
map őő gT
map úú gt
map <C-b> :NERDTreeToggle<CR>

map <Up> :resize -5<CR>
map <Down> :resize +5<CR>
map <Left> :vertical resize +5<CR>
map <Right> :vertical resize -5<CR>

"yank/copy to system clipboard
nnoremap y "+y
vnoremap y "+y

"Unmap the arrow keys (normal, insert, visual)
"no <up> <Nop>
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"ino <up> <Nop>
"ino <down> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>
"vno <up> <Nop>
"vno <down> <Nop>
"vno <left> <Nop>
"vno <right> <Nop>
