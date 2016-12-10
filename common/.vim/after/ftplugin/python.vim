setlocal encoding=utf-8

"Tabs
setlocal smarttab
setlocal autoindent
setlocal smartindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal formatoptions=tcroql
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

"hard wrap lines
setlocal linebreak
setlocal textwidth=120
setlocal nowrap

setlocal omnifunc=jedi#completions

" Disable docstring for jedi autocomplete
setlocal completeopt-=preview
