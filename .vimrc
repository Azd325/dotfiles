set nocompatible
filetype off                        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" https://github.com/gmarik/vundle
" Launch vim, run :BundleInstall (or vim +BundleInstall +qall for CLI lovers)
" required!
Bundle 'gmarik/vundle'
" My bundles
Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
nnoremap <F6> :NERDTreeToggle<CR>           " Toogle NerdTree
Bundle 'kevinw/pyflakes'
" Need an installed pep8
Bundle 'nvie/vim-pep8'
Bundle 'altercation/vim-colors-solarized'
syntax enable
set background=dark
colorscheme solarized

filetype plugin indent on           " required!

""" FocusMode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    colorscheme solarized "re-call your colorscheme
  endif
endfunc
nnoremap <F8> :call ToggleFocusMode()<cr>

set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=79
set showcmd                         " Display incomplete commands.
set showmode                        " Display the current mode.
set backspace=indent,eol,start      " Intuitive backspacing.
set wildmenu                        " Emhamced command line completion.
set wildmode=list:longest               " Complete files like a shell.
set ignorecase                      " Case-insentitive searching.
set smartcase                       " But case-sensitive if expression contains a capital letter.
set number                          " Show line numbers.
set title                           " Set the terminal's title.
set visualbell                      " No beeping.
set nobackup                        " Don't make a backup before overwriting a file.
set laststatus=2                    " Show the status line all the time.
set ruler                           " enables filetype specific plugins
set incsearch                       " Highlight matches as you type.
set hlsearch                        " Higlight matches.
set spell

nnoremap <F2> :tabn<CR>
nnoremap <F3> :tabp<CR>
nnoremap <F4> :set nonumber!<CR>:set foldcolumn=0<CR>   " Toggle line numbers and fold column for easy copying.
nnoremap <F5> :TlistToggle<CR>              " Toogle to see a taglist
nnoremap <C-^> :tabp<cr>
nnoremap <^> :tabNext<cr>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

autocmd BufWritePre * :%s/\s\+$//e          " Remove trailing whitespace.
" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0
" XHTML (tab width 2 chr, no wrapping)
autocmd FileType xhtml set sw=2
autocmd FileType xhtml set ts=2
autocmd FileType xhtml set sts=2
autocmd FileType xhtml set textwidth=0
" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set textwidth=79
" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
" JavaScript (tab width 4 chr, wrap at 79th)
autocmd FileType javascript set sw=4
autocmd FileType javascript set ts=4
autocmd FileType javascript set sts=4
autocmd FileType javascript set textwidth=79

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
