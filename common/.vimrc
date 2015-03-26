"vim behavior
set magic
set encoding=utf-8
set mouse-=a "disable mouse

" remap ; -> :
nore ; :

" remap , -> ;
"nore , ;

" no backups
set noswapfile
set nobackup
set nowritebackup
" shortcuts
"  ALT+j - move line down 1
nmap <M-j> mz:m+<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"  ALT+k - move line up 1
nmap <M-k> mz:m-2<cr>`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Shiny
syntax enable
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
" Toggle paste mode
" from the command bar
command Tp setl paste!
" or a key combo Ctrl+Shift+p (C-p) is used by vim
map <C-P> :setl paste!<CR>
""" color fixes
" set color depth
set t_Co=256
" set gutter bg color
highlight SignColumn guibg=darkgrey


"Search
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

"Tabs ... -_-
set smarttab
set autoindent
set smartindent
set cin
set inde=
set tabstop=4
set softtabstop=4
set shiftwidth=4

"Spreling (spelling :P)
set spell
set spelllang=en
set spellsuggest=5
hi clear SpellBad
hi SpellBad gui=underline
hi SpellBad term=underline
hi SpellBad cterm=underline
map <leader>ss :setlocal spell!<cr> " Pressing ,ss will toggle and untoggle spell checking
map <leader>sn ]s	"next?
map <leader>sp [s	"previous?
map <leader>sa zg	"add?
map <leader>s? z=	"query?

"syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers=['pep8', 'pylint', 'pep257']
let g:syntastic_id_checkers = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump = 0

let g:syntastic_error_symbol='E'
let g:syntastic_style_error_symbol='E'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_warning_symbol='!'


"

highlight SyntasticError ctermfg=15 ctermbg=52
highlight SyntasticWarning ctermfg=154 ctermbg=52
highlight SyntasticStyleError ctermfg=160 ctermbg=17
highlight SyntasticStyleWarning ctermfg=154 ctermbg=17

highlight SyntasticErrorSign ctermfg=15 ctermbg=52
highlight SyntasticWarningSign ctermfg=154 ctermbg=52
highlight SyntasticStyleErrorSign ctermfg=160 ctermbg=17
highlight SyntasticStyleWarningSign ctermfg=154 ctermbg=17

highlight SyntasticErrorLine ctermbg=237
highlight SyntasticWarningLine ctermbg=234
highlight SyntasticStyleErrorLine ctermbg=237
highlight SyntasticStyleWarningLine ctermbg=234

command LB80 :set lbr tw=80

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
