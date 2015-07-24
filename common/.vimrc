execute pathogen#infect()

"vim behavior
set modeline
set magic
set encoding=utf-8
set mouse-=a "disable mouse
" share the * register with the clipboard
" http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
else
	set clipboard=unnamed
endif

" no backups
set noswapfile
set nobackup
set nowritebackup

"Shiny
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

"Search
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

"Tabs
set smarttab
set autoindent
set smartindent
set cindent
set inde=
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
"pretty tabs
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
"hardworking tabs
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]


"Spreling (spelling :P)
set spell
set spelllang=en
set spellsuggest=5
map <leader>ss :setlocal spell!<cr> " Pressing ,ss will toggle and untoggle spell checking
map <leader>sn ]s	"next?
map <leader>sp [s	"previous?
map <leader>sa zg	"add?
map <leader>s? z=	"query?

"syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers=['pylint']
let g:syntastic_id_checkers = 1
let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump = 0
let g:syntastic_python_python_exec = '/usr/bin/python3'
" default let g:syntastic_python_python_exec = '/path/to/python2'

highlight SyntasticErrorLine guibg=red
highlight SyntasticWarningLine guibg=yellow
highlight SyntasticStyleErrorLine guibg=orange guifg=blue
highlight SyntasticStyleWarningLine guibg=yellow guifg=darkgrey

let g:jedi#popup_on_dot = 0
