noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP> noremap <Right> <NOP>
set nocompatible              " be iMproved, required
filetype off                  " required

"disable graphql
let g:polyglot_disabled = ['graphql']

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


" programming language packs, installs lang when needed
Plugin 'sheerun/vim-polyglot'

" Async lint
Plugin 'dense-analysis/ale'

" git/hub stuff
"Plugin 'tpope/vim-rhubarb'

"Plugin 'vim-ruby/vim-ruby'

" Show modified lines according to git
Plugin 'airblade/vim-gitgutter'

" Color scheme
Plugin 'altercation/vim-colors-solarized'
"Plugin 'nightsense/stellarized'
Plugin 'NLKNguyen/papercolor-theme'

" Open files
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'ivalkeen/vim-ctrlp-tjump'

" Silver searcher (ag in bash)
Plugin 'mileszs/ack.vim'

" Go
Plugin 'fatih/vim-go'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'vim-crystal/vim-crystal'

"Plugin 'neoclide/coc.nvim'
"
Plugin 'github/copilot.vim'


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
"set tags=./.tags;

" turn on relative line numbers, but use actual number for current line
set number relativenumber

"c-å to jump to tag
"nnoremap <c-]> :CtrlPtjump<cr>
"vnoremap <c-]> :CtrlPtjumpVisual<cr>
" jump directly to tag of only one found
"let g:ctrlp_tjump_only_silent = 1
:nnoremap <c-o> :CtrlPBuffer<cr>

syntax enable
let g:solarized_termcolors=256
"set background=light
"colorscheme solarized
"set hlsearch
"highlight Normal ctermbg=none
"highlight NonText ctermbg=none

"show invisibles
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:¶
set list


:hi SpecialKey ctermfg=darkgrey guifg=grey70
:hi NonText ctermfg=darkgrey guifg=grey70

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

"let g:syntastic_ruby_checkers = ['mri', 'rubocop']
"let g:syntastic_ruby_rubocop_exec = '/Users/jon/.rbenv/shims/rubocop'
" let g:syntastic_javascript_checkers = ['jshint']
let g:ackprg = 'ag --nogroup --nocolor --column'


" Crystal
let g:crystal_auto_format = 1
let g:crystal_enable_completion = 0
"autocmd FileType crystal  nnoremap <buffer> ,r :CrystalSpecRunCurrent<CR>
"autocmd FileType crystal  nnoremap <buffer> ,R :CrystalSpecRunAll<CR>
autocmd FileType crystal nnoremap <buffer> ,r :!crystal run "%"<CR>
autocmd FileType crystal nnoremap <buffer> ,R :!crystal run "%" -Dpreview_mt -Dexecution_context<CR>


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
\   'ruby': ['rubocop']
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_sign_error = '🛑'
let g:ale_sign_warning = '⚠️'
let g:ale_disable_lsp = 1
highlight ALEWarning ctermbg=DarkMagenta

command Json %!jq '.'


" handle large files
set maxmempattern=5000
set redrawtime=5000

" CoC
"
" " use <tab> to trigger completion and navigate to the next complete item
"inoremap <silent><expr> <c-n> coc#refresh()
"inoremap <silent><expr> <tab> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"
"inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
"inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
"
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
"" Make <CR> to accept selected completion item or notify coc.nvim to format
"" " <C-g>u breaks current undo, please make your own choice
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
