call plug#begin()

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomasiser/vim-code-dark'

call plug#end()


inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"


set nocompatible
set showmode
set showcmd
set mouse=a
set encoding=utf-8
set t_Co=256
set autoindent
set tabstop=2
set shiftwidth=4
set expandtab
set softtabstop=2

set number
set relativenumber
set cursorline
set scrolloff=5
set laststatus=2
set ruler
set showmatch
set hlsearch

set spell spelllang=en_us

set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set autochdir
set noerrorbells
set history=1000
set autoread
set listchars=tab:»■,trail:■
set list
set wildmenu
set wildmode=longest:list,full

filetype indent on
syntax on

colorscheme codedark
