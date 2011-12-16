augroup markdown
     au! BufRead,BufNewFile *.mkd   setfiletype mkd
     autocmd BufRead,BufNewFile *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END
