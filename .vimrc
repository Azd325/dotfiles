set nocompatible

syntax enable
filetype on						" Enables filetype detection.
filetype plugin indent on				" Enables filetype specific plugins.
set showcmd						" Display incomplete commands.
set showmode						" Display the current mode.
set backspace=indent,eol,start				" Intuitive backspacing.
set wildmenu						" Emhamced command line completion.
set wildmode=list:longest				" Complete files like a shell.
set ignorecase						" Case-insentitive searching.
set smartcase						" But case-sensitive if expression contains a capital letter.
set number						" Show line numbers.
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>	" Toggle line numbers and fold column for easy copying.
nnoremap <F3> :TlistToggle<CR>				" Toogle to see a taglist
set ruler  						" enables filetype specific plugins
set incsearch						" Highlight matches as you type.
set hlsearch						" Higlight matches.
autocmd BufWritePre * :%s/\s\+$//e			" Remove trailing whitespace.
autocmd FileType python set tabstop=4			" tab configs for python.
autocmd FileType python set shiftwidth=4
autocmd FileType python set expandtab
autocmd FileType python compiler pylint
set title						" Set the terminal's title.
set visualbell						" No beeping.
set nobackup						" Don't make a backup before overwriting a file.
set laststatus=2					" Show the status line all the time.

" Style Settings.
set background=dark
colorscheme solarized
