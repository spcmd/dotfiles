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
set hlsearch                                        "highlight search results
set ruler                                           "show line and cursor position
set hidden                                          "hide buffer, do not warn about unsaved
set confirm                                         "save confirmation dialog
set expandtab                                       "convert tabs to spaces
set tabstop=4                                       "tab width
set softtabstop=4                                   "fix backspace width in insert mode
set shiftwidth=4                                    "indent width
set smarttab                                        "backspace behaviour on indented lines
set encoding=utf-8                                  "default encode
set splitbelow                                      "horizontal split: open below
set splitright                                      "vertical split: open to the right
set guicursor+=i:ver25-iCursor                      "insert cursor in GVim, need for coloring
set guicursor+=a:blinkon0                           "disable cursor blinking
set guioptions=aegimrLt                             "remove Toolbar
set guioptions-=mrL                                 "remove: menu bar & scroll bars
set guifont=Liberation\ Mono\ for\ Powerline\ 10    "font type for GVim
set t_Co=256                                        "set terminal to 256 color
set lines=35 columns=110                            "set in ~/.gvimrc for GVim
set rnu                                             "relative line numbering
set cursorline                                      "highlight current line
set laststatus=2                                    "always show statusline/airline
set noshowmode                                      "disable default mode indicator (using airline's)
set listchars=tab:▸\ ,eol:¬                         "tab and EOL chars
let NERDTreeShowBookmarks=1                         "show NERDTree Bookmarks
let mapleader = "\<Space>"                          "remap leader key, instead of using \
let g:airline#extensions#tabline#enabled = 1        "display buffers/tabs at the top
let g:airline#extensions#tabline#fnamemod = ':t'    "show filenames only on tabs
let g:airline_section_b = '%{getcwd()}'             "show present working directory
let g:airline_powerline_fonts = 1                   "load patched powerline fonts
let g:airline_theme='spcmd'                         "set airline theme
let g:session_autosave="yes"                        "autosave session
let g:session_autoload="yes"                        "autoload session

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

"Remove Trailing White Space
command! RWS %s/\s\+$//|echom "Removing trailing white spaces"

"Quick delete/close buffer
command! QQ bd

"Delete file and buffer
command! DF :call delete(expand('%'))|bd!

"Create new buffer and save it automatically
command! BB enew|exec 'w ~/.vim/backup/autosave'.strftime('%Y%m%d%H%M%S')

"Save autosaved file in another filename and delete the autosaved file
function! AS_SaveAsAndDelete()
    if @% =~# 'autosave'
        let currentfile = @%
        let cwd = getcwd()
        call inputsave()
        let newfilename = input('Save as: '.cwd.'/')
        call inputrestore()
        execute 'save '.newfilename.''
        call delete(expand(currentfile))
        bd! #
    else
        echom "No-no! You can't use AS command on non-autosave files."
    endif
endfunction

command! SA :call AS_SaveAsAndDelete()

"Dump unused stuff to another file (save for later)
command! -range Dump <line1>,<line2> write >> ~/Documents/vimdump.txt|<line1>,<line2> d

"Fix accidentally shifted commands
command! WQ wq
command! Wq wq
command! W w
command! Q q

"Reload .vimrc (save & source)
command! RR write|source ~/.vimrc

"Resize (terminal) window on quit
autocmd VimLeavePre * silent set lines=25 columns=90

"----------"
" Keybinds "
"----------"
imap éé <Esc>
vmap éé <Esc>
imap űű <Esc>"*pA
imap áá <Esc>"+p
nmap <Enter> o<ESC>
nmap <S-Enter> O<ESC>
nmap ú :bnext<CR>
nmap ő :bprevious<CR>
nmap <C-b> :NERDTreeToggle<CR>
nmap <leader>, :set list!<CR>

"Indenting
nmap <S-tab> <<
nmap <tab> >>
vmap <S-tab> <gv
vmap <tab> >gv

"Faster scrolling
nmap <C-j> <C-d>
nmap <C-k> <C-u>

"Toggle search highlight
let hlstate=0
nnoremap <leader><space> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

"Split window resize
map <Up> :resize -5<CR>
map <Down> :resize +5<CR>
map <Left> :vertical resize +5<CR>
map <Right> :vertical resize -5<CR>

"Split window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"yank/copy to system clipboard
nnoremap y "+y
vnoremap y "+y
