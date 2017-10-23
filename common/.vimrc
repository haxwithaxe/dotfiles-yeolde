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
" insert newline without entering command mode (and stay on the same line)
nmap <CR><CR> m`o<ESC>``

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
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]


"Spreling (spelling :P)
set spell
set spelllang=en
set spellsuggest=5

"syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers=['pylint']
let g:syntastic_id_checkers = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump = 0
let g:syntastic_python_python_exec = '/usr/bin/python3'
" default let g:syntastic_python_python_exec = '/path/to/python2'
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc' 
let g:syntastic_python_pylint_exec = '/usr/local/bin/pylint'

highlight SyntasticErrorLine guibg=red
highlight SyntasticWarningLine guibg=yellow
highlight SyntasticStyleErrorLine guibg=orange guifg=blue
highlight SyntasticStyleWarningLine guibg=yellow guifg=darkgrey

let g:jedi#popup_on_dot = 1
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy?<C-R><C-R>=substitute(
	\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>

