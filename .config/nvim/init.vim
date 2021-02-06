" dein directory
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" install dein
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repos_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repos_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repos_dir, ':p')
endif

" dein setting
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set encoding=utf-8

set hlsearch
set cindent
set ignorecase
set backspace=start,eol,indent
set whichwrap=b,s,[,],~
set relativenumber

set number
set title
set cursorline
set showmatch
set noswapfile
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
" set noexpandtab
set expandtab
filetype plugin indent on

" Leader Setting
let mapleader="\<Space>"

syntax enable 
set termguicolors

" Keymap
nnoremap <silent> <C-s> :w<CR>

" japanese -> command
nnoremap あ a
nnoremap い i
nnoremap お o
nnoremap っy yy
nnoremap っd dd

" Tab Settings
nnoremap [TABCMD] <nop>
nmap     <leader>t [TABCMD]

nnoremap <silent> [TABCMD]r :<c-u>tabrewind<cr>
nnoremap <silent> [TABCMD]l :<c-u>tablast<cr>
nnoremap <silent> [TABCMD]e :<c-u>tabedit<cr>
nnoremap <silent> [TABCMD]n :<c-u>tabnext<cr>
nnoremap <silent> [TABCMD]p :<c-u>tabprevious<cr>
nnoremap <silent> [TABCMD]c :<c-u>tabclose<cr>
nnoremap <silent> [TABCMD]s :<c-u>tabs<cr>
nnoremap <silent> [TABCMD]1 :<c-u>tabnext 1<cr>
nnoremap <silent> [TABCMD]2 :<c-u>tabnext 2<cr>
nnoremap <silent> [TABCMD]3 :<c-u>tabnext 3<cr>
nnoremap <silent> [TABCMD]4 :<c-u>tabnext 4<cr>
nnoremap <silent> [TABCMD]5 :<c-u>tabnext 5<cr>
nnoremap <silent> [TABCMD]6 :<c-u>tabnext 6<cr>
nnoremap <silent> [TABCMD]7 :<c-u>tabnext 7<cr>
nnoremap <silent> [TABCMD]8 :<c-u>tabnext 8<cr>
nnoremap <silent> [TABCMD]9 :<c-u>tabnext 9<cr>

nnoremap <silent> [TABCMD][TABCMD]ic :<c-u>tabclose!<cr>

inoremap <silent> jj <ESC>

" Goyo.vim
nnoremap <silent> Gy :<c-u>Goyo<cr>

nnoremap <silent> ss :split<CR>
nnoremap <silent> vs :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

let g:python3_host_prog = '/usr/local/opt/python@3.8/bin/python3.8'

augroup indent_opt
  autocmd!
  autocmd Filetype make setlocal noexpandtab shiftwidth=8 softtabstop=0
augroup END
