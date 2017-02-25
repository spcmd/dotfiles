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

" {{{   Load plugins
"--------------------------------------------"
call plug#begin('~/.vim/plugged')

    "Plug 'ap/vim-buftabline'
    "Plug 'chrisbra/Colorizer', { 'on': 'ColorHighlight' }
    "Plug 'junegunn/fzf', { 'do': './install --all' }
    "Plug 'junegunn/fzf.vim'
    "Plug 'xolox/vim-misc'
    "Plug 'xolox/vim-colorscheme-switcher'
    "Plug 'w0ng/vim-hybrid'
    "Plug 'chriskempson/base16-vim'
    Plug 'lilydjwg/colorizer'
    Plug 'Shougo/neocomplete.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'spcmd/vim-easy-todo', { 'for': 'todo' }
    Plug 'kristijanhusak/vim-multiple-cursors'
    "Plug 'rust-lang/rust.vim'
    Plug 'junegunn/goyo.vim'
    "Plug 'scrooloose/syntastic'
    "Plug 'racer-rust/vim-racer'
    "Plug 'morhetz/gruvbox'

call plug#end()
" }}}
" {{{   Basic Settings
"--------------------------------------------"
syntax on
filetype plugin indent on
if exists("$DISPLAY")
        colorscheme Tomorrow-Night-spcmd
    else
        colorscheme Tomorrow-Night-Eighties-TTY
endif
set nocompatible                                    "disable Vi compatibility
set modeline                                        "enable modeline
set modelines=5                                     "enable modeline
set number                                          "line numbers
set showcmd                                         "show commands at the bottom
set linebreak                                       "allow linebreaks between words
set hlsearch                                        "highlight search results
"set ruler                                           "show line and cursor position
set hidden                                          "hide buffer, do not warn about unsaved
set confirm                                         "save confirmation dialog
set backspace=indent,eol,start                      "backspace always works
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
"set t_Co=256                                        "set terminal to 256 color
"set rnu                                             "relative line numbering
"set cursorline                                      "highlight current line
set laststatus=2                                    "always show statusline/airline
set listchars=tab:▸\ ,eol:¬                         "tab and EOL chars
set showmode                                        "show modes
set nofoldenable                                    "disable automatic folding
set autoread                                        "auto-reload files if they were modified outside Vim
set ignorecase                                      "case-insensitive mode
set smartcase                                       "case-sensitive if search contains a capital letter
set incsearch                                       "jump to the first search result instantly
set wildmenu                                        "enhanced command line completion
set scrolloff=5                                     "lines above and below the cursor
set backupdir=~/.vim/backup                         "put backup to backup dir
set directory=~/.vim/backup                         "put swap to backup dir
set foldmethod=marker                               "folding with markers
set foldenable                                      "auto fold
let mapleader = ","                                 "remap leader key, instead of using \

set statusline=                                     "clear statusline (needed when reloading .vimrc)
set statusline+=[buf:%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]\   "buffers current/total
set statusline+=%f                                  "file name
set statusline+=%m                                  "modified flag
set statusline+=%=                                  "left-right separator
set statusline+=%y                                  "filetype
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}]   "file encoding
set statusline+=\ L:%l/%L                           "cursor line / total lines
set statusline+=\ C:%c                              "cursor column
set statusline+=\ (%P)                              "percent through file

" }}}
" {{{   Plugin settings
"--------------------------------------------

"====== [ buftabline ] ============================================

"let g:buftabline_indicators = 1                     "indicate modified state of the buffer


"====== [ NERDTree ] ============================================

"let NERDTreeShowBookmarks=1                         "show NERDTree Bookmarks
"let NERDTreeShowHidden=1                            "show hidden files by default (needed for dotfiles)


"====== [ Airline ] ============================================

" if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif

"let g:airline_left_sep = ""                         "no arrows
"let g:airline_right_sep = ""                        "no arrows
"let g:airline_left_alt_sep = ""                     "no buffer/tab arrows
"let g:airline_symbols.linenr = "␊"                  "line nr symbol
"let g:airline_symbols.branch = "⎇ "                 "git branch
"let g:airline#extensions#tabline#enabled = 1        "display buffers/tabs at the top
"let g:airline#extensions#tabline#fnamemod = ":t"    "show filenames only on tabs
"let g:airline_section_c = "%F"                      "show the full path of the file in section c
"let g:airline_powerline_fonts = 1                   "load patched powerline fonts
"let g:airline_theme="spcmd"                         "set airline theme


"====== [ Syntastic ] ============================================

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
highlight SyntasticWarning ctermbg=226 ctermfg=196
highlight SyntasticError ctermbg=9 ctermfg=11

" Don't check PKGBUILD files by default
"autocmd BufRead,BufNewFile PKGBUILD :silent SyntasticToggleMode

" toggle error window (http://stackoverflow.com/a/17515778)
function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction

" add to the statusline
"set statusline+=\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*


"====== [ Neocomplete ] ============================================

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" fix the conflict with Neocomplete (slow performance)
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


"====== [ Racer (rust completion) ] ============================================

"let g:racer_cmd = "/home/spcmd/bin/racer"
"let $RUST_SRC_PATH="/home/spcmd/bin/rustc-source/src"

" }}}
" {{{   Terminal cursor settings
"--------------------------------------------

" Cursor color & shape
" 1 or 0 : blinking block
" 2 : normal block
" 3 : blinking underscore
" 4 : normal underscore
" 5 : blinking vertical bar
" 6 : normal vertical bar
let &t_SI = "\033]12;12\x7"
let &t_EI = "\033]12;15\x7"
let &t_SI .= "\033[6 q"
let &t_EI .= "\033[2 q"
autocmd VimEnter * silent !echo -ne "\033[2 q"
silent !echo -ne "\033]12;15\007"
"autocmd VimLeave * silent !echo -ne "\033]12;15\007"

" }}}
" {{{   Autocommands
"--------------------------------------------

"Remove trailing whitespace before saving the buffer
autocmd BufWritePre * :%s/\s\+$//e

"Syntax highlight
autocmd BufRead .rtorrent.rc set filetype=sh
autocmd BufRead .vimperatorrc set filetype=vim
autocmd BufRead .pentadactylrc set filetype=vim
autocmd BufRead *.vimp set filetype=vim
autocmd BufRead .xinitrc set filetype=sh
autocmd BufRead *.todo nnoremap <space> za]z
autocmd BufRead *.sh set syntax=sh
autocmd BufRead *.muttrc set syntax=muttrc filetype=muttrc

" }}}
" {{{   Custom commands & functions
"--------------------------------------------

"Toggle relative line numbering
command! RL set rnu!

"Remove trailing whitespace
command! RWS %s/\s\+$//|echo "Removing trailing white spaces"

"Remove leading whitespace
command! RLWS %s/^\s\+

"Remove blank/emtpy lines
command! RBL g/^\s*$/d

"Quick delete/close buffer
command! QQ bd

"Fix accidentally shifted commands
command! WQ wq
command! Wq wq
command! W w
command! Q q

"Reload .vimrc (save & source)
command! RR write|source ~/.vimrc

"Create new buffer and save it automatically
command! BB enew|exec 'w ~/.vim/backup/autosave'.strftime('%Y%m%d%H%M%S')

"Quick delete file and buffer
function! QuickDFCheck()
    if expand("%:t") == match(expand('%:t'),'.vimrc\|.gvimrc\|.vimperatorrc\|TODO\|vimdump\|.zshrc\|.bashrc\|.rtorrent.rc')
        echo expand("%:t:r") "is a protected file. Can\'t quick delete it."
    else
        call delete(expand('%'))|bd!
    endif
endfunction
command! DF :call QuickDFCheck()

"DumpDelete (dump unused stuff to another file > save for later) + Open Dump
let DUMPFILE = "~/.vim/backup/vimdump.vim"
if !empty(glob(DUMPFILE))
    command! OD exec 'edit '.DUMPFILE
    command! -range DD exec 'redir! >> '.DUMPFILE.'|echo "\r\r"|redir end|<line1>,<line2> write >> '.DUMPFILE.'|<line1>,<line2> d'
else
    command! OD echo "ERROR: Dump file doesn't exist."
    command! -range DD echo "ERROR: Dump file doesn't exist."
endif


"}}}
" {{{   Key mappings
"--------------------------------------------

"====== [ Basic key mappings ] ============================================

"Paste from clipboard
inoremap űű <Esc>"+p

"New line with enter
nnoremap <Enter> o<ESC>
nnoremap <S-Enter> O<ESC>

"Switch buffers
nnoremap ú :bnext<CR>
nnoremap ő :bprevious<CR>

"Folding
nnoremap <space> za

"Select ALL
nnoremap <C-a> ggVG

"Increment/decrement number
nnoremap <C-u> <C-a>
nnoremap <C-d> <C-x>
vnoremap <C-u> <C-a>
vnoremap <C-d> <C-x>

"Toggle wrap (visual line break)
nnoremap <C-w> :set nowrap!<CR>

"Delete surrounding quotes, brackets etc.
nnoremap <leader>d{ F{xf}x
nnoremap <leader>d" F"x,x
nnoremap <leader>d' F'x,x
nnoremap <leader>d( F(xf)x
nnoremap <leader>d) F(xf)x
nnoremap <leader>d[ F[xf]x
nnoremap <leader>d] F[xf]x
nnoremap <leader>d< F<xf>x
nnoremap <leader>d> F<xf>x

"Surround words with quotes, brackets etc.
nnoremap <leader>a{ lbi{<ESC>ea}<ESC>
nnoremap <leader>a} lbi{<ESC>ea}<ESC>
nnoremap <leader>a" lbi"<ESC>ea"<ESC>
nnoremap <leader>a' lbi'<ESC>ea'<ESC>
nnoremap <leader>a( lbi(<ESC>ea)<ESC>
nnoremap <leader>a) lbi(<ESC>ea)<ESC>
nnoremap <leader>a[ lbi[<ESC>ea]<ESC>
nnoremap <leader>a] lbi[<ESC>ea]<ESC>
nnoremap <leader>a< lbi<<ESC>ea><ESC>
nnoremap <leader>a> lbi<<ESC>ea><ESC>

"Move up/down on displayed lines, not real lines
nnoremap k gk
nnoremap j gj

"Move to the beginning/end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

"Indenting
nnoremap <S-tab> <<
nnoremap <tab> >>
vnoremap <S-tab> <gv
vnoremap <tab> >gv

"Faster navigation
nnoremap J <C-d>
nnoremap K <C-u>

"Select the whole line in Visual mode
vnoremap j j$

"Toggle search highlight
let hlstate=0
nnoremap <leader><space> :set hlsearch!<CR>

"Split window resize
nnoremap <leader>j :resize +5<CR>
nnoremap <leader>k :resize -5<CR>
nnoremap <leader>h :vertical resize -5<CR>
nnoremap <leader>l :vertical resize +5<CR>

"Split window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Location window / Error window
nnoremap . :lprevious<CR>
nnoremap - :lnext<CR>

"Yank to system clipboard
nnoremap y "+y
vnoremap y "+y

" Replace X with x, so it will save and quit instead of showing the encryption prompt
" (http://stackoverflow.com/questions/17792177/disable-encryption-with-x-in-vim/17794801#17794801)
cnoreabbrev <expr> X (getcmdtype() is# ':' && getcmdline() is# 'X') ? 'x' : 'X'

" Disable uppercase/lowercase toggle
noremap gu <Nop>
noremap gU <Nop>
noremap g~ <Nop>
vnoremap ~ <Nop>
vnoremap u <Nop>
vnoremap U <Nop>

" Open Shell
nnoremap <S-s> :shell<CR>

" Cargo / Rust
nnoremap <S-c> :!clear && cargo run<CR>


"====== [ Plugin specific key mappings ] ============================================

"NERDTree (https://github.com/scrooloose/nerdtree)
"nmap <C-b> :NERDTreeToggle<CR>

"Colorschemes Switcher (https://github.com/xolox/vim-colorscheme-switcher)
"nnoremap <leader>n :NextColorScheme<CR>

"Vim Easy TODO (https://github.com/spcmd/vim-easy-todo)
nnoremap <silent> <leader>d :TodoDone<CR>
nnoremap <silent> <leader>u :TodoUndone<CR>
nnoremap <silent> <leader>x :TodoCancel<CR>

"Neocomplete (https://github.com/Shougo/neocomplete.vim)
"move to the next with Tab and to the previous with Shift-Tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

"Syntastic (https://github.com/scrooloose/syntastic)
"nnoremap <silent> <leader>e :<C-u>call ToggleErrors()<CR>
nnoremap <leader>e :SyntasticToggleMode<CR>

"Goyo (Distraction Free mode)
nnoremap <C-g> :Goyo<CR>

" }}}
