"default vimrc of haxwithaxe
set tabstop=3
set shiftwidth=3
set noexpandtab
set softtabstop=3
set smarttab
set autoindent
set smartindent
filetype plugin on
filetype indent on
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
syntax enable
set encoding=utf8
set noswapfile
set nobackup
set nowb
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
command LB80 :set lbr tw=80
