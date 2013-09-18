"vim behavior
set encoding=utf-8
set nobackup nowritebackup "no backups
map <leader>pp :setlocal paste!<cr>	" Toggle paste mode on and off
"ALT+j - move line down 1
nmap <M-j> mz:m+<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"ALT+k - move line up 1
nmap <M-k> mz:m-2<cr>`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Shiny
syntax enable
colorscheme slate
set wrap
set laststatus=2 statusline=>\ %{HasPaste()}%f%m%r%h\ CWD:%{getcwd()}\ ln:%l\ char:%c\ col:%v
function! HasPaste()
	if &paste
		return '[paste:on]'
	en
		return ''
endfunction

"Search
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

"Tabs ... -_-
set smarttab
set ai
set si
set cin
set inde=
set tabstop=4
set softtabstop=4
set shiftwidth=4
command Byztabs setl tabstop=4 softtabstop=4 shiftwidth=4 expandtab
command NoByztabs set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"Spreling (spelling :P)
set spell
set spelllang=en
set spellsuggest=5
map <leader>ss :setlocal spell!<cr> " Pressing ,ss will toggle and untoggle spell checking
map <leader>sn ]s	"next?
map <leader>sp [s	"previous?
map <leader>sa zg	"add?
map <leader>s? z=	"query?

"Paste
cabbrev pp setlocal paste!
set mouse=c

"File type fixes
au BufRead,BufNewFile *.ino setfiletype cpp
au BufRead,BufNewFile *.pde setfiletype cpp
