call pathogen#runtime_append_all_bundles()

" Load plugins
filetype plugin indent on

"----------------------------------------------------------------------------
" Common settings
colorscheme pablo
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
set listchars=eol:¬,tab:>-,trail:.,extends:»,precedes:«
set equalprg=perltidy               " Use 'perltidy' when = is pressed
syntax on                           " Syntax Highlight on

" Status line  [:n]    [git]                      [file]     [flags]   [line,col]  
set statusline=%a%-40.60(%{fugitive#statusline()}:%-0.45f\ %=%M%R%H%)%=%l/%L#%n"

" Jump to the last position when we open a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

filetype plugin on

set guioptions-=e
set guioptions-=T
set guioptions+=ac
set guifont=Inconsolata:h12

" Use ack for :grep
set grepprg=ack\ -a

" Make a . repeat for :
map <Leader>. @:

" use perltidy for .pl, .pm, and .t
au BufRead,BufNewFile *.pl setl equalprg=perltidy
au BufRead,BufNewFile *.pm setl equalprg=perltidy
au BufRead,BufNewFile *.t setl equalprg=perltidy

"----------------------------------------------------------------------------
" Module settings

" Perlhelp
let perl_include_pod=1

" vim-git-branch-info
let g:git_branch_status_text=""             " No text before branches
let g:git_branch_status_nogit=""            " Nothing if not git repo
let g:git_branch_status_around=""           " Nothing around branch
"let g:git_branch_status_ignore_remotes=1    " No remote checking
let g:git_branch_status_head_current=1      " Only current head

" Actionscript files
au BufRead,BufNewFile *.as   setl filetype=actionscript noet ts=4 nolist
au BufRead,BufNewFile *.mxml setl filetype=mxml noet ts=4 nolist

" Perl .t files
au BufRead,BufNewFile *.t set filetype=perl

" Auto wrap only certain files
au BufRead,BufNewFile * setl nolbr wm=0 tw=0
au BufRead,BufNewFile *.wiki  setl lbr wm=4 tw=78
au BufRead,BufNewFile *.rst  setl lbr wm=4 tw=78
au BufRead,BufNewFile *.txt  setl lbr wm=4 tw=78
au BufRead,BufNewFile *.md  setl lbr wm=4 tw=78

"----------------------------------------------------------------------------
" Macros

" Jump to where a sub is defined
"nmap gx yiw/^\(sub\<Bar>function\)\s\+<C-R>"<CR>

" Escape and unescape HTML
function HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction
