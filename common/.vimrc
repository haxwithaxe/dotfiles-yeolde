execute pathogen#infect()

"vim behavior
set modeline
set magic
set encoding=utf-8
set mouse-=a "disable mouse
" Share the * register with the clipboard
" http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
else
	set clipboard=unnamed
endif
" Insert newline without entering command mode (and stay on the same line)
nmap <CR><CR> m`o<ESC>``

" No backups
set noswapfile
set nobackup
set nowritebackup

" Shiny
syntax on
colorscheme slate
filetype indent on
filetype plugin on
set wrap
set laststatus=2
set statusline=>\ %{HasPaste()}%f%m%r%h\ CWD:%{getcwd()}\ ln:%l\ char:%c\ col:%v
function! HasPaste()
	if &paste
		return '[paste:on]'
	en
		return ''
endfunction

" Search
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" Tabs
set smarttab
set autoindent
set smartindent
set cindent
set inde=
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Pretty tabs
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" Hardworking tabs
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]


" Sepllng (spelling :P)
set spell
set spelllang=en
set spellsuggest=5

call neomake#configure#automake('nrw', 10)

let g:jedi#popup_on_dot = 0

" Remove trailing whitespace in python code
autocmd FileType python autocmd BufEnter    <buffer> :%s/\s\+$//e
autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e
