"autocmd Filetype defx call s:defx_my_settings()
  function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
          \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
          \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
          \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
          \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> o
          \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> E
          \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> N
          \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> D
          \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> <Space>
          \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
          \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> !
          \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> yy
          \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> dd
          \ defx#do_action('remove', 'true')
    nnoremap <silent><buffer><expr> dt
          \ defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> r
          \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> j
          \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
          \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> qq
          \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> h
          \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
          \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> cd
          \ defx#do_action('change_vim_cwd')

  endfunction

function! s:open_defx_if_directory()
  let l:full_path = expand(expand('%:p'))
  if isdirectory(l:full_path)
    Defx `expand('%:p')`
  endif
endfunction

call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': ' ',
    \ })

call defx#custom#option('_', {
    \ 'columns': 'mark:icons:indent:icon:filename',
    \ })


nnoremap zf :Defx -search=`expand('%:p')`<CR>
nnoremap ztf :Defx -split=tab<CR>

augroup defx_config
  autocmd!
  autocmd Filetype defx call s:defx_my_settings()
  autocmd BufEnter * call s:open_defx_if_directory()
augroup END
