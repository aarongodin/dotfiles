" iMproved!
set nocompatible

" Vundle initialization
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""" Vundle
Plugin 'VundleVim/Vundle.vim'

"""""" Plugins
" Appearance
" Plugin 'haishanh/night-owl.vim'
Plugin 'sickill/vim-monokai'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'Airblade/vim-gitgutter'

" Project
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'

" Editing
Plugin 'scrooloose/nerdcommenter'
Plugin 'w0rp/ale'

" Langs/Syntax
Plugin 'isRuslan/vim-es6'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'groenewege/vim-less'
Plugin 'rhysd/vim-crystal'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-vagrant'
Plugin 'chr4/nginx.vim'

" End vundle initialization
call vundle#end()
filetype plugin indent on

" Main Configuration
set number
set encoding=utf-8
set cursorline
set showmode
set foldenable
set shiftround
set wrap
set linebreak
set tabstop=2
set shiftwidth=2
set expandtab

" Invisible characters
set listchars=tab:▸\ ,eol:¬
set nolist

" Allow going to a the next 'virtual' line when the line is wrapped
noremap j gj
noremap k gk

" Move a line up (<c-m>) or down (<c-n>)
map <c-n> ddp
map <c-m> ddkkp

" Use jj to exit insert mode and write
imap jj <Esc>:w<CR>

map <c-i> :set paste<CR>i

" Fix the backspace to allow deleting like most programs
set backspace=indent,eol,start

" Change the leader key to be comma
" http://stackoverflow.com/questions/1764263/what-is-the-leader-in-a-vimrc-file
let mapleader = ","

" Show indent guides
let g:indent_guides_enable_on_vim_startup = 1

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

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
let NERDTreeIgnore=['\.git', 'node_modules']

" Modifications for moving between splits
" Instead of having to type ctrl-w plus a direction,
" this allows for just ctrl plus a direction.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Makes splits open in a more natural direction in relation to your current splits
set splitbelow
set splitright

" Syntax Highlighting
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
" colorscheme night-owl
colorscheme monokai

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1

" CTRL-P
let g:ctrlp_custom_ignore = '(node_modules|\.git|coverage)'

" Finally, override with project-specific configuration, defined in the current directory's .vimrc
set exrc
