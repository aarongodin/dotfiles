" iMproved!
set nocompatible

" Vundle initialization
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Plugin 'VundleVim/Vundle.vim'

" Vundle Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jimmyhchan/dustjs.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chaquotay/ftl-vim-syntax'
Plugin 'groenewege/vim-less'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'romainl/flattened'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rhysd/vim-crystal'

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
set noexpandtab

" Show invisible characters
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
syntax enable
colorscheme flattened_light

" CTRL-P
let g:ctrlp_custom_ignore = '(node_modules|\.git)'

" Language-specific behavior

" JSX
" Only syntax highlight jsx on .jsx files.
" (this was breaking some JS indentation so I've restricted it to just jsx files)
let g:jsx_ext_required = 1

" Finally, override with project-specific configuration, defined in the current directory's .vimrc
set exrc
