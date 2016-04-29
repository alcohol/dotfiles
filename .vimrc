""" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'nginx.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'elzr/vim-json'
Plugin 'justinmk/vim-sneak'
Plugin 'cespare/vim-toml'
Plugin 'scrooloose/nerdtree'
call vundle#end()

""" General / Core
set nocompatible
filetype off
filetype plugin indent on
set confirm
set modeline
set noswapfile
set nowritebackup
set report=0
set ttyfast


""" User interface
set hidden
set gdefault
set background=dark
set mouse=a
set wildmenu
set ruler
set laststatus=2
set cmdheight=1
set showcmd
set showmode
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set scrolloff=10
set sidescroll=1
set sidescrolloff=5
set splitbelow splitright
set wrap
set linebreak
set formatoptions=cq
set textwidth=120
set wrapmargin=0

""" Statusline
set statusline=
set statusline +=%*\ %n\ %*    " buffer number
set statusline +=%*%{&ff}%*    " file format
set statusline +=%*%y%*        " file type
set statusline +=%*\ %<%F%*    " full path
set statusline +=%*%m%*        " modified flag
set statusline +=%*%=%l%*      " current line
set statusline +=%*/%L%*       " total lines
set statusline +=%*%4c\ %*     " column number


""" Searching
set incsearch
set ignorecase
set smartcase


""" Syntax / code stuff
syntax on
set showmatch
set matchpairs+=<:>
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent
set shiftround


""" Folding
set foldenable
set foldmethod=marker


""" Mappings

command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
set pastetoggle=<F6>

augroup AutoCommands

    " Reset
    autocmd!

    " Markdown syntax highlighting
    autocmd BufNewFile,BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
    autocmd BufNewFile,BufRead *.md set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
    autocmd BufNewFile,BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> filetype=markdown

    " Vim Tip #1279 - Highlight current line in Insert Mode
    autocmd InsertLeave * set nocul
    autocmd InsertEnter * set cul

    " Remove any trailing whitespace in the file
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

    " Some indent preferences
    autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
    autocmd FileType php setlocal softtabstop=4 tabstop=4 shiftwidth=4
    autocmd FileType json setlocal softtabstop=4 tabstop=4 shiftwidth=4
    autocmd FileType yaml setlocal softtabstop=2 tabstop=2 shiftwidth=2

    " airline
    let g:airline#extensions#tabline#enabled = 1

    " nerdtree
    let g:NERDTreeWinPos = 'right'
    autocmd VimEnter * NERDTree | wincmd p
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

augroup end
