" ========================================================= "
" .vimrc                                                    "
" Created by: spcmd                                         "
" Website: http://spcmd.github.io                           "
"          https://github.com/spcmd                         "
"          https://gist.github.com/spcmd                    "
" ========================================================= "

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
set lines=40 columns=130                            "set in ~/.gvimrc for GVim
set rnu                                             "relative line numbering
set cursorline                                      "highlight current line
set laststatus=2                                    "always show statusline/airline
set noshowmode                                      "disable default mode indicator (using airline's)
set listchars=tab:▸\ ,eol:¬,trail:⋅                 "tab and EOL chars
set nofoldenable                                    "disable automatic folding
set autoread                                        "auto-reload files if they were modified outside Vim
set ignorecase                                      "case-insensitive mode
set smartcase                                       "case-sensitive if search contains a capital letter
set incsearch                                       "jump to the first search result instantly
set wildmenu                                        "enhanced command line completion
set scrolloff=10                                    "lines above and below the cursor
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

"--------------------------------------------"
"   Key mappings                             "
"--------------------------------------------"

imap űű <Esc>"*pA
imap áá <Esc>"+p
nmap <Enter> o<ESC>
nmap <S-Enter> O<ESC>
nmap ú :bnext<CR>
nmap ő :bprevious<CR>
nmap <C-b> :NERDTreeToggle<CR>
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

"Vim Easy TODO
nmap <leader>d :TodoDone<CR>
nmap <leader>u :TodoUndone<CR>
nmap <leader>x :TodoCancel<CR>

"Move up/down on displayed lines, not real lines
noremap k gk
noremap j gj

"Indenting
nmap <S-tab> <<
nmap <tab> >>
vmap <S-tab> <gv
vmap <tab> >gv

"Faster navigation
nmap <C-j> <C-d>
nmap <C-k> <C-u>

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
