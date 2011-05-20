set nocompatible

syntax enable
filetype on
filetype plugin indent on

" Display incomplete commands.
set showcmd
" Display the current mode.
set showmode
" Intuitive backspacing.
set backspace=indent,eol,start
" Emhamced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest
" Case-insentitive searching.
set ignorecase
" But case-sensitive if expression contains a capital letter.
set smartcase
" Show line numbers.
set number
" Toggle line numbers and fold column for easy copying.
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
" Show Cursor position.
set ruler
" Highlight matches as you type
set incsearch
" Higlight matches
set hlsearch
" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" tab configs for python
 autocmd FileType python set tabstop=4
 autocmd FileType python set shiftwidth=4
 autocmd FileType python set expandtab
 autocmd FileType python compiler pylint
" Set the terminal's title.
set title
" No beeping.
set visualbell
" Don't make a backup before overwriting a file.
set nobackup
" SHow the status line all the time
set laststatus=2

" Style Settings.
set background=dark
colorscheme solarized
