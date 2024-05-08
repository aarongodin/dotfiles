set nocompatible

" Main Configuration
set number
set autoindent
set smartindent
set encoding=utf-8
set cursorline
set showmode
set foldenable
set shiftround
set wrap
set linebreak
set tabstop=2
set shiftwidth=2
set noexpandtab

" Expand tabs if the file already has spaces
autocmd FileType * if search('\v^ +', 'wn') | set expandtab | endif

" Invisible characters
set listchars=tab:▸\ ,eol:¬
set nolist

" Common mappings
noremap j gj
noremap k gk
map <c-n> ddp
map <c-m> ddkkp
imap jj <Esc>:w<CR>
vmap <C-Y> "+y

autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet

" Fix the backspace to allow deleting like most programs
set backspace=indent,eol,start

" Change the leader key to be comma
" http://stackoverflow.com/questions/1764263/what-is-the-leader-in-a-vimrc-file
let mapleader = ","

" vim tabs
function! MoveBufferToNewTab()
  " let current_buf = bufnr('%')
  " tabnew
  " execute 'buffer' current_buf
  let current_file = expand('%')
  if current_file == ''
    echo "Buffer is not associated with a file"
    return
  endif
  execute 'tabnew ' . current_file
  tabprevious
  quit
endfunction
imap <Leader>t <Esc>:call MoveBufferToNewTab()<CR>
nnoremap <Leader>t :tabnew<CR>

" use markdown for mdx for now
autocmd BufNewFile,BufRead *.mdx set filetype=markdown

" Show indent guides
let g:indent_guides_enable_on_vim_startup = 1

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Open NerdTree with comma-d
map <Leader>d :NERDTreeToggle<CR>

" NERDTree settings
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.git', 'node_modules', '\.yarn']

" Modifications for moving between splits
" Instead of having to type ctrl-w plus a direction,
" this allows for just ctrl plus a direction.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Esc>[prev :tabprevious<CR>
nnoremap <C-{> :tabprevious<CR>
nnoremap <C-0> :tabnext<CR>

nnoremap <Esc>[next :tabnext<CR>

" Makes splits open in a more natural direction in relation to your current splits
set splitbelow
set splitright

" Syntax Highlighting
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set re=0
" colorscheme night-owl
colorscheme gruvbox
" colorscheme monokai

function! ExecWithPreservedWindow(command)
  let l:winview = winsaveview()
  execute a:command
  call winrestview(l:winview)
endfunction

autocmd BufWritePre *.go call ExecWithPreservedWindow('%!gofmt -s')

" CTRL-P
let g:ctrlp_custom_ignore = '(node_modules|\.git|coverage)'
let g:ctrlp_follow_symlinks = 2

"""""""""" Setup fzf
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <Leader>B :Buffers<CR>
" vnoremap <C-M-f> :Rg <C-R>=expand("<cword>")<CR><CR>
" Define a custom Ag command that customizes ag flags
function! AgWrapper(query, ...)
  let l:command = 'ag --column --nocolor --follow --skip-vcs-ignores ' . a:query
  let l:options = {'options': '--delimiter : --nth 2..'}
  if a:0 > 0 && a:1 ==# '1' " Check for bang
    call fzf#vim#grep(l:command, 1, l:options, 0)
  else
    call fzf#vim#grep(l:command, 0, l:options, 0)
  endif
endfunction

command! -nargs=* -bang Ag call AgWrapper(<q-args>, <bang>0)

function! RgWrapper(query, ...)
  let l:escaped_query = shellescape(a:query)
  let l:command = 'rg --column --line-number --no-heading --color=always --smart-case ' . $VIM_RG_OPTIONS .
    \ ' ' . l:escaped_query . 
    \ ' . ' . $VIM_RG_PATHS
  let l:preview_cmd = "rg --pretty --context 10 --color=always {1} || bat -f {1}"
  let l:options = {
    \ 'options': '--delimiter : --nth 2.. --preview '. shellescape(l:preview_cmd),
    \ 'down': '40%'
    \ }
  if a:0 > 0 && a:1 ==# '1' " Check for bang
    call fzf#vim#grep(l:command, 1, l:options, 0)
  else
    call fzf#vim#grep(l:command, 0, l:options, 0)
  endif
endfunction

command! -nargs=* -bang Rg call RgWrapper(<q-args>, <bang>0)


" Setup ripgrep as grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

filetype plugin on
filetype indent on

" Finally, override with project-specific configuration, defined in the current directory's .vimrc
set exrc
