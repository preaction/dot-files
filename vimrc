
" Load Vundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
"Plugin 'Yggdroot/indentLine'
Plugin 'kien/ctrlp.vim'
Plugin 'yko/mojo.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'fatih/vim-go'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

call vundle#end()

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "solarized"

" Load plugins
filetype plugin indent on

" Allow project-specific vimrc
set exrc
set secure

"----------------------------------------------------------------------------
" Common settings
" I don't know why, but this fixes a problem with my PuTTY colorscheme
let g:solarized_termtrans=1
colorscheme solarized
set background=light
set autoindent                      " Auto-indent on
set nocompatible                    " Use vim addvance settings
set tabstop=8                       " Use 8 spaces for tabs
set shiftwidth=4                    " 4 spaces for autoindent
set softtabstop=4                   " Use soft tabs
set expandtab                       " Use spaces instead of tabs
set number                          " Show numbering
set nowrap                          " Don't wrap long lines
set incsearch                       " Incremental search
set showcmd                         " Show panding commands
set cmdheight=1                     " lines for command window
set laststatus=2                    " Always show status line
set backspace=indent,eol,start      " Backspace over everyting
set history=100                     " Save at most XX commands
set ruler                           " show ruler
set showmatch                       " Display matching paren
set matchtime=2                     " Be breif when displaying the match
set nobackup                        " No backups
set visualbell                      " Use visual bell
set viminfo=@200,'100,f1,rb:,:100,/100   " Vim info options
set autoread                        " Re-read if modified
set backupcopy=yes                  " Save resources
set diffopt=filler,iwhite           " Diff options
set nostartofline                   " Keep cursor column when moving
set scrolloff=6                     " Keep 6 context lines on-screen
set pastetoggle=<F10>               " Toggle paste
set fileformats=unix,dos            " File formats
set showtabline=2                   " Always show tab bar
set ignorecase                      " Ignore case by default
set list                            " Show tabs and EOL
set cursorline                      " highlight the line the cursor is on
set tags+=,./.tags,.tags            " Allow hidden tags files
set directory=~/.vim/swapfiles//    " Move swapfiles out of the current directory
syntax on                           " Syntax Highlight on

" Status line  [:n]    [git]                      [file]     [flags]   [line,col]  
set statusline=%a%-40.60(%{fugitive#statusline()}:%-0.45f\ %=%M%R%H%)%=%l/%L#%n"

" Jump to the last position when we open a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Jump to the first line if we're a git commit message
au BufReadPost COMMIT_EDITMSG :1

" A quick macro to remove the last search
nnoremap <leader><space> :nohl<cr>

" Always add a "lib" directory to the path
set path+=lib

filetype plugin on

" Use ack for :grep
set grepprg=ack

" Make a . repeat for :
map <Leader>. @:

" use perltidy for .pl, .pm, and .t
au BufRead,BufNewFile *.pl setl equalprg=perltidy
au BufRead,BufNewFile *.pm setl equalprg=perltidy
au BufRead,BufNewFile *.t setl equalprg=perltidy

au BufRead,BufNewFile *.xml setl equalprg=tidy\ -xml\ -q\ -i\ -w\ 100

"----------------------------------------------------------------------------
" Module settings

" Ctrl+P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|db\|blib'

" Perlhelp
let perl_include_pod=1

" vim-git-branch-info
let g:git_branch_status_text=""             " No text before branches
let g:git_branch_status_nogit=""            " Nothing if not git repo
let g:git_branch_status_around=""           " Nothing around branch
"let g:git_branch_status_ignore_remotes=1    " No remote checking
let g:git_branch_status_head_current=1      " Only current head

" Do not conceal JSON quotes because are you fucking kidding me?
"let g:vim_json_syntax_conceal=0
"let g:indentLine_noConcealCursor="nc"

" Actionscript files
au BufRead,BufNewFile *.as   setl filetype=actionscript
au BufRead,BufNewFile *.mxml setl filetype=mxml

" .vue files
au BufRead,BufNewFile *.vue set filetype=html

" Perl files
au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile Rexfile set filetype=perl
au BufRead,BufNewFile cpanfile set filetype=perl

" Auto wrap text only in certain files
" See :help fo-table
" Auto wrap comments everywhere
set formatoptions+=j1cl
set formatoptions-=o
set tw=72
au BufRead,BufNewFile * setl nolbr wm=0 tw=72
au BufRead,BufNewFile *.wiki  setl lbr wm=0 tw=72 fo+=t
au BufRead,BufNewFile *.rst  setl lbr wm=0 tw=72 fo+=t
au BufRead,BufNewFile *.txt  setl lbr wm=0 tw=72 fo+=t
au BufRead,BufNewFile *.md  setl lbr wm=0 tw=72 fo+=t
au BufRead,BufNewFile *.markdown  setl lbr wm=0 tw=72 fo+=t
au BufRead,BufNewFile COMMIT_EDITMSG setl lbr tw=72 wm=0 fo+=t
au BufRead,BufNewFile *.go set nolist sw=4 tw=4 noai noet ts=4

"----------------------------------------------------------------------------
" Macros

" Jump to where a sub is defined
"nmap gx yiw/^\(sub\<Bar>function\)\s\+<C-R>"<CR>

" Escape and unescape HTML
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction
map <Leader>hh :call HtmlEscape()<Enter>

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction
map <Leader>hu :call HtmlUnEscape()<Enter>

"--------------------
" Syntastic
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
"au BufRead,BufNewFile *.t let g:syntastic_perl_perlcritic_args="--severity 4 --theme 'test'"
"au BufRead,BufNewFile *.pl let g:syntastic_perl_perlcritic_args="--severity 4 --theme 'script'"
"au BufRead,BufNewFile *.pm let g:syntastic_perl_perlcritic_args="--severity 4 --theme 'module'"
let g:syntastic_javascript_checkers = ['eslint']

"--------------------
" trackperlvars
highlight! TRACK_PERL_VAR ctermfg=NONE ctermbg=NONE cterm=underline gui=underline guifg=NONE guibg=NONE



" Allow machine-specific overrides
if !empty(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

