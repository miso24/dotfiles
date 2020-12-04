let g:quickrun_config = {
  \ '_' : {
    \ 'runner' : 'vimproc',
    \ 'runner/vimproc/updatetime' : 60
  \ }
\}

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
