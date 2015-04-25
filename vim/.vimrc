"                                      _
"         ___ _ __   ___ _ __ ___   __| |
"        / __| '_ \ / __| '_ ` _ \ / _` |
"        \__ | |_) | (__| | | | | | (_| |
"        |___| .__/ \___|_| |_| |_|\__,_|
"             |_|
"
"                    .vimrc
"               Created by: spcmd
"           http://spcmd.github.io
"           https://github.com/spcmd
"           https://gist.github.com/spcmd

"--------------------------------------------"
"   Settings                                 "
"--------------------------------------------"

execute pathogen#infect()
syntax on
filetype plugin indent on
set number                                          "line numbers
colorscheme Tomorrow-Night-spcmd                    "color scheme
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
set ttimeout                                        "reduce timeout after <Esc>
set ttimeoutlen=10                                  "reduce timeout after <Esc>
set splitbelow                                      "horizontal split: open below
set splitright                                      "vertical split: open to the right
set t_Co=256                                        "set terminal to 256 color
set lines=35 columns=120                            "set in ~/.gvimrc for GVim
set rnu                                             "relative line numbering
set cursorline                                      "highlight current line
set laststatus=2                                    "always show statusline/airline
set noshowmode                                      "disable default mode indicator (using airline's)
set listchars=tab:▸\ ,eol:¬                         "tab and EOL chars
set nofoldenable                                    "disable automatic folding
set autoread                                        "auto-reload files if they were modified outside Vim
set ignorecase                                      "case-insensitive mode
set smartcase                                       "case-sensitive if search contains a capital letter
set incsearch                                       "jump to the first search result instantly
set wildmenu                                        "enhanced command line completion
set scrolloff=10                                    "lines above and below the cursor
set backupdir=~/.vim/backup                         "put backup to backup dir
set directory=~/.vim/backup                         "put swap to backup dir
let mapleader = "\<Space>"                          "remap leader key, instead of using \

"Plugin/Bundle specific settings
let NERDTreeShowBookmarks=1                         "show NERDTree Bookmarks
let g:airline#extensions#tabline#enabled = 1        "display buffers/tabs at the top
let g:airline#extensions#tabline#fnamemod = ':t'    "show filenames only on tabs
let g:airline_section_b = '%{getcwd()}'             "show current working directory
let g:airline_powerline_fonts = 1                   "load patched powerline fonts
let g:airline_theme='spcmd'                         "set airline theme
let g:session_autosave="yes"                        "autosave session
let g:session_autoload="yes"                        "autoload session
let g:neocomplete#enable_at_startup = 1             "enable Neocomplete
let g:neocomplete#enable_smart_case = 1             "smartcase for Neocomplete
let g:vcoolor_disable_mappings = 1                  "disable VCoolor's default mappings
let g:vcoolor_lowercase = 1                         "use lowercase color codes by default

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

"--------------------------------------------"
"   GUI settings (only when running)         "
"--------------------------------------------"

if (has("gui_running"))

    set guicursor+=i:ver25-iCursor                      "insert cursor in GVim, need for coloring
    set guicursor+=a:blinkon0                           "disable cursor blinking
    set guioptions=aegimrLt                             "remove Toolbar
    set guioptions-=mrL                                 "remove: menu bar & scroll bars
    set guifont=Liberation\ Mono\ for\ Powerline\ 10    "font type for GVim

    "Colorize cursor in GVim
    hi Cursor guifg=#000000 guibg=#dfff00
    hi iCursor guifg=#ffffff guibg=#005fff

endif

"--------------------------------------------"
"   Commands & Functions                     "
"--------------------------------------------"

"Toggle Relative Line Numbering
command! RL set rnu!

"Remove Trailing White Space
command! RWS %s/\s\+$//|echo "Removing trailing white spaces"

"Quick delete/close buffer
command! QQ bd

"Delete file and buffer
function! DFchecker()
    if expand("%:t:r") == '.vimrc'
        echo "ERROR! You can't delete the .vimrc"
    elseif expand("%:t:r") == '.gvimrc'
        echo "ERROR! You can't delete the .gvimrc"
    elseif expand("%:t:r") == 'vimdump'
        echo "ERROR! You can't delete the vimdump"
    elseif expand("%:t:r") == '.bashrc'
        echo "ERROR! You can't delete the .bashrc"
    elseif expand("%:t:r") == '.zshrc'
        echo "ERROR! You can't delete the .zshrc"
    elseif expand("%:t:r") == '.vimperatorrc'
        echo "ERROR! You can't delete the .vimperatorrc"
    elseif expand("%:e") == 'todo'
        echo "ERROR! You can't delete a .todo file"
    else
        call delete(expand('%'))|bd!
    endif
endfunction
command! DF :call DFchecker()

"Create new buffer and save it automatically
command! BB enew|exec 'w ~/.vim/backup/autosave'.strftime('%Y%m%d%H%M%S')

"DumpDelete (dump unused stuff to another file > save for later) + Open Dump
let DUMPFILE = "~/.vim/backup/vimdump.vim"
if !empty(glob(DUMPFILE))
    command! OD exec 'edit '.DUMPFILE
    command! -range DD exec 'redir! >> '.DUMPFILE.'|echo "\r\r"|redir end|<line1>,<line2> write >> '.DUMPFILE.'|<line1>,<line2> d'
else
    command! OD echo "ERROR: Dump file doesn't exist."
    command! -range DD echo "ERROR: Dump file doesn't exist."
endif

" Fix the conflict with Neocomplete (slow performance)
" https://github.com/kristijanhusak/vim-multiple-cursors
" https://github.com/terryma/vim-multiple-cursors/issues/51#issuecomment-32344711
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction

"Fix accidentally shifted commands
command! WQ wq
command! Wq wq
command! W w
command! Q q

"Reload .vimrc (save & source)
command! RR write|source ~/.vimrc

"--------------------------------------------"
"   Autocommands                             "
"--------------------------------------------"

"Save all when Vim window lost focus
autocmd FocusLost * silent! wa

"Resize (terminal) window on quit
autocmd VimLeavePre * silent set lines=25 columns=90

"Syntax highlight
autocmd BufRead,BufWinEnter .rtorrent.rc set filetype=sh
autocmd BufRead,BufWinEnter .vimperatorrc set filetype=vim
autocmd BufRead,BufWinEnter *.vimp set filetype=vim

"--------------------------------------------"
"   Key mappings                             "
"--------------------------------------------"

imap űű <Esc>"+pA
nnoremap <Enter> o<ESC>
nnoremap O ko<ESC>
nmap ú :bnext<CR>
nmap ő :bprevious<CR>
nmap <leader>, :set list!<CR>

"Delete surrounding quotes, brackets etc.
noremap <leader>d{ F{xf}x
noremap <leader>d" F"x,x
noremap <leader>d' F'x,x
noremap <leader>d( F(xf)x
noremap <leader>d) F(xf)x
noremap <leader>d[ F[xf]x
noremap <leader>d] F[xf]x
noremap <leader>d< F<xf>x
noremap <leader>d> F<xf>x

"Surround words with quotes, brackets etc.
noremap <leader>a{ lbi{<ESC>ea}<ESC>
noremap <leader>a} lbi{<ESC>ea}<ESC>
noremap <leader>a" lbi"<ESC>ea"<ESC>
noremap <leader>a' lbi'<ESC>ea'<ESC>
noremap <leader>a( lbi(<ESC>ea)<ESC>
noremap <leader>a) lbi(<ESC>ea)<ESC>
noremap <leader>a[ lbi[<ESC>ea]<ESC>
noremap <leader>a] lbi[<ESC>ea]<ESC>
noremap <leader>a< lbi<<ESC>ea><ESC>
noremap <leader>a> lbi<<ESC>ea><ESC>

"Move up/down on displayed lines, not real lines
noremap k gk
noremap j gj

"Move to the beginning/end of line
nnoremap H ^
nnoremap L $
vmap H ^
vmap L $

"Indenting
nmap <S-tab> <<
nmap <tab> >>
vmap <S-tab> <gv
vmap <tab> >gv

"Faster navigation
nmap <C-j> <C-d>
nmap <C-k> <C-u>

"Select the whole line in Visual mode
vnoremap j j$

"Toggle search highlight
let hlstate=0
nnoremap <leader><space> :set hlsearch!<CR>

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

"Yank to system clipboard
nnoremap y "+y
vnoremap y "+y

"NERDTree (https://github.com/scrooloose/nerdtree)
nmap <C-b> :NERDTreeToggle<CR>

"Neocomplete (https://github.com/Shougo/neocomplete.vim)
"move to the next with Tab and to the previous with Shift-Tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

"Vim Easy TODO (https://github.com/spcmd/vim-easy-todo)
nnoremap <silent> <leader>d :TodoDone<CR>
nnoremap <silent> <leader>u :TodoUndone<CR>
nnoremap <silent> <leader>x :TodoCancel<CR>

"VCoolor (https://github.com/KabbAmine/vCoolor.vim)
nnoremap <silent> <leader>vc :VCoolor<CR>
inoremap <silent> <leader>vc <Esc>:VCoolor<CR>a

"Colorizer (https://github.com/chrisbra/Colorizer)
nnoremap <silent> <leader>cz :ColorToggle<CR>
