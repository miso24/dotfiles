let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ ['mode', 'paste'], ['readonly', 'filename', 'filetype', 'modified'] ],
  \   'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding'] ],
  \ },
  \ 'tabline': {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ },
  \ 'component_function': {
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \ }
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
  
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
