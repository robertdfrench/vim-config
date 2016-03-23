set backspace=indent,eol,start
execute pathogen#infect()
set t_Co=256       " enable 256 colors

syntax on

set ruler          " show the cursor position all the time
set laststatus=2   " always show the editing status bar at the bottom

set wildmode=list:longest

set background=dark
colors solarized

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_symbols = {}
let g:airline_theme='solarized'

" Ignore some files 
set wildignore+=.git,*vendor/cache/*,*vendor/rails/*,*vendor/ruby/*,*/pkg/*,*/tmp/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](env.*|html|\.git|\.hg|\.svn)$',
  \ 'file': '\v\.(pyc|exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on
set ts=2 sw=2 expandtab

let mapleader = ","

" Indent and unindent without leaving visual mode
vnoremap < <gv
vnoremap > >gv

" Bubble single lines requires tpopes vim-repeat plugin
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
" ================================================================
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" RENAME CURRENT FILE
" ===================
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
noremap <leader>n :call RenameFile()<cr>
au BufNewFile,BufRead *.tpp set filetype=cpp
