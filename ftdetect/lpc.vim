autocmd BufNewFile,BufRead */mudlib/*.[c|h]
            \ set filetype=lpc

let g:tagbar_type_lpc = {
    \ 'ctagstype' : 'c',
    \ 'kinds'     : [
    \ 'f:function',
    \ 'v:variables',
    \ 'h:headers',
    \ 'd:defines'
    \ ]
\ }
