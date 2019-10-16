noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP> noremap <Right> <NOP>
set nocompatible              " be iMproved, required
filetype on                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Plugin 'scrooloose/syntastic'
"

" Async lint
Plugin 'w0rp/ale'

" git/hub stuff
"Plugin 'tpope/vim-rhubarb'

" programming language packs, installs lang when needed
Plugin 'sheerun/vim-polyglot'

Plugin 'vim-ruby/vim-ruby'

" Show modified lines according to git
Plugin 'airblade/vim-gitgutter'

" Color scheme
"Plugin 'altercation/vim-colors-solarized'
Plugin 'nightsense/stellarized'

" Open files
Plugin 'ctrlpvim/ctrlp.vim'

" Silver searcher (ag in bash)
Plugin 'mileszs/ack.vim'

" Erlang
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'jimenezrick/vimerl'
Plugin 'edkolev/erlang-motions.vim'

" Go
Plugin 'fatih/vim-go'

Plugin 'editorconfig/editorconfig-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
set tags=.ctags;

syntax on
set number
set hlsearch

"show invisibles
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:¶
set list

"let g:solarized_termcolors=256
set background=dark
colorscheme torte
colorscheme stellarized

set tabstop=2
set shiftwidth=2
set expandtab

set ruler       " show the cursor position all the time
set incsearch   " incremental searching
set ignorecase
set smartcase

set undofile
set undodir=~/.vimundo

set cursorline  " highlight cursor line

set nobomb      " no utf8 bom
set autoindent  " auto indent on always
set t_Co=256
set laststatus=2
nnoremap åå <c-^>

set splitbelow
set splitright

set cindent
set cino+=j1,(0,ws,Ws

set backspace=indent,eol,start

let g:ctrlp_working_path_mode = ''
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = '/Users/jon/.rbenv/shims/rubocop'
" let g:syntastic_javascript_checkers = ['jshint']
let g:ackprg = 'ag --nogroup --nocolor --column'

" erlang
autocmd BufRead,BufNewFile *.erl,*.es.*.hrl,*.yaws,*.xrl set expandtab
au BufNewFile,BufRead *.erl,*.es,*.hrl,*.yaws,*.xrl setf erlang
let g:syntastic_mode_map = { 'passive_filetypes': ['erlang'] } 

"faster pane switching
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k 
nnoremap <c-l> <c-w>l

"faster pane resizing
nnoremap <c-right> <c-w>>
nnoremap <c-left> <c-w><
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-

" gostuff
let g:go_fmt_autosave = 1
let g:go_version_warning = 0

" lint
let g:ale_linters = {
\   'javascript': ['standard'],
\   'erlang': [],
\   'ruby': ['rubocop']
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
