"--------------------------------
" Key bindings

let mapleader = ","

" find
nnoremap n nzz

" smooth scrolling
nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>
vnoremap <C-j> j<C-e>
vnoremap <C-k> k<C-y>

" copy/paste
xnoremap p pgvy
noremap x "_x
noremap s "_s

map j gj
map k gk

" Tabular
noremap <Leader>t :Tabular /*<CR>

" Formatting
noremap <Leader>w :set wrap! lbr!<CR>
noremap <Leader>s :syntax off<CR>

" Opening split and switching to second buffer
noremap <Leader>v :vsp \| b2<CR><C-w>h

" Yank over ssh/tmux via vim-oscyank
vnoremap <Leader>c :OSCYank<CR>

" scrolling with line wrap
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" NERDTree
noremap <Leader>e :NERDTreeToggle<CR>

" Shortcut for Tagbar
"nmap <C-m> :TagbarToggle<CR>

" modify selected text using combining diacritics
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
"command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
"command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
"command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

noremap <Leader>u :Underline<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

