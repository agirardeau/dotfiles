"--------------------------------
" Key bindings

let mapleader = " "

" Find
nnoremap n nzz

" Smooth scrolling
nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>
vnoremap <C-j> j<C-e>
vnoremap <C-k> k<C-y>

map j gj
map k gk

" Unhighlight
noremap <C-L> :nohl<CR><C-L>

" Copy/paste
xnoremap p pgvy
noremap x "_x
noremap s "_s

" Terminal
tnoremap <C-[> <C-\><C-N>
tnoremap <Esc> <C-\><C-N>
tnoremap <C-W> <C-\><C-N><C-W>

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

" NvimTree
noremap <Leader>ee :NvimTreeFocus<CR>
noremap <Leader>ef :NvimTreeFindFile<CR>
noremap <Leader>eg :NvimTreeFindFileToggle<CR>
noremap <Leader>eu :NvimTreeFindFile!<CR>
noremap <Leader>ei :NvimTreeFindFileToggle!<CR>
noremap <Leader>et :NvimTreeToggle<CR>
noremap <Leader>eo :NvimTreeOpen<CR>
noremap <Leader>ec :NvimTreeClose<CR>
noremap <Leader>ek :NvimTreeCollapse<CR>
noremap <Leader>ej :NvimTreeCollapseKeepBuffers<CR>
noremap <Leader>er :NvimTreeRefresh<CR>
noremap <Leader>ep :NvimTreeClipboard<CR>
noremap <Leader>eh :NvimTreeResize -5<CR>
noremap <Leader>el :NvimTreeResize +5<CR>

" Diagnostics
noremap <Leader>dj :lua vim.diagnostic.goto_next()<CR>
noremap <Leader>dk :lua vim.diagnostic.goto_prev()<CR>

" modify selected text using combining diacritics
" (note (agirardeau, 2022.11.17): highlight text and run these to alter the
" text)
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

