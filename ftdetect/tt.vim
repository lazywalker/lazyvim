au BufNewFile,BufRead *.tt,*.tin set ft=tt

let g:tagbar_type_tt = {
    \ 'ctagstype' : 'tt',
    \ 'kinds'     : [
    \ 'c:CLASS',
    \ 'C:CONFIG',
    \ 'f:FUNCTION',
    \ 'v:VAR',
    \ 't:TAB',
    \ 'e:EVENT',
    \ 'a:ACTION',
    \ 'A:ALIAS'
    \ ]
\ }
