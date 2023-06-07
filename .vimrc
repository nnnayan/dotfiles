"""" 1. Vim Behaviour.
call plug#begin('~/.vim/plugged')

""" Async lint engine
Plug 'dense-analysis/ale'

""" Javascript etc.
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-eslint'
  \ ]

"""GraphQL (.gql syntax highlighting)
Plug 'jparise/vim-graphql'

""" Fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

""" Git
Plug 'tpope/vim-fugitive'

""" Go to definition (needs brew install ctags to work,
""" then run ctags -R in root of project)
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

call plug#end()

" Use filetype-based syntax highlighting, ftplugins, and indentation.
syntax on
" Use new regular expression engine
set re=0

" Use numbering. Don't use relative numbering as this is slow (especially in
" .tex files).
set number

" Enable mouse support. Note that on Mac OS X this doesn't work well on the
" default terminal.
set mouse=a

"""" 2. Key Bindings.
" More convenient movement when lines are wrapped.
nmap j gj
nmap k gk

" yank copies to clipboard
vnoremap y y:call system('pbcopy', @")<CR>

"""" 3. Vim Appearance.

" Search settings
set hlsearch " hilight
set incsearch " jump to best fit

" Turn off seach highlighting with <CR>.
nnoremap <CR> :nohlsearch<CR><CR>

" Tab settings
filetype indent on
filetype indent plugin on
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" Make statusline appear even with only single window.
set laststatus=2

" vim: set ft=vim foldmethod=marker ts=4 sw=4 tw=80 et :
let @s= "i// file: \"%pa\n#include <stdio.h>\n#include <stdlib.h>\n\nint main(int argc, char **argv) {\n\nreturn 0;\n}kki	"
:highlight Normal ctermfg=white ctermbg=black

" Default colour scheme
colo gruvbox
" other good ones: tokyonight

"""" 4. Mappings
let mapleader = "\<Space>"
function! ToggleHighlight()
  if &hlsearch==1
    set nohlsearch
  else
    set hlsearch
  endif
endfunction

" Easier split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" FZF: files (no CR to narrow down)
nnoremap <Leader>f :Files

" Buffers!
nnoremap <Leader>b :Buffers

" Save!
nnoremap <Leader>w :w<CR>

" Quit!
nnoremap <Leader>q :q<CR>

" Copy file path to clipboard... trying this out
nnoremap <Leader>:filename :let @+=expand('%:p')

" Also trying this out woo
nnoremap <Leader><Space> :edit<CR>

" Gtags
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

