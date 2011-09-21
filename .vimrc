set nocompatible

syntax enable
filetype on						" Enables filetype detection.
filetype plugin indent on				" Enables filetype specific plugins.

set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=79
set showcmd						" Display incomplete commands.
set showmode						" Display the current mode.
set backspace=indent,eol,start				" Intuitive backspacing.
set wildmenu						" Emhamced command line completion.
set wildmode=list:longest				" Complete files like a shell.
set ignorecase						" Case-insentitive searching.
set smartcase						" But case-sensitive if expression contains a capital letter.
set number						" Show line numbers.
set title						" Set the terminal's title.
set visualbell						" No beeping.
set nobackup						" Don't make a backup before overwriting a file.
set laststatus=2					" Show the status line all the time.
set background=dark
set ruler						" enables filetype specific plugins
set incsearch						" Highlight matches as you type.
set hlsearch						" Higlight matches.
colorscheme delek

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>	" Toggle line numbers and fold column for easy copying.
nnoremap <F3> :TlistToggle<CR>				" Toogle to see a taglist
nnoremap <F4> :NERDTreeToggle<CR>			" Toogle NerdTree

autocmd BufWritePre * :%s/\s\+$//e			" Remove trailing whitespace.
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
autocmd FileType python compiler pylint
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
