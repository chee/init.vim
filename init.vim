scriptencoding utf-8
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup init
    autocmd VimEnter * PlugInstall
  augroup END
endif

" plugs
call plug#begin()
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  " Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'Shougo/unite.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'cakebaker/scss-syntax.vim'
  " Plug 'carlitux/deoplete-ternjs'
  Plug 'chaoren/vim-wordmotion'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'elzr/vim-json'
  Plug 'jalvesaq/vimcmdline'
  Plug 'joonty/vdebug'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'kassio/neoterm'
  Plug 'maksimr/vim-jsbeautify'
  Plug 'mileszs/ack.vim'
  Plug 'morhetz/gruvbox'
  Plug 'mxw/vim-jsx'
  Plug 'neomake/neomake'
  Plug 'othree/nginx-contrib-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'raichoo/purescript-vim'
  Plug 'rhysd/vim-wasm'
  Plug 'rizzatti/dash.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'roblillack/vim-bufferlist'
  Plug 'ruanyl/vim-fixmyjs'
  Plug 'sbdchd/neoformat'
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'sheerun/vim-polyglot'
  Plug 'stephpy/vim-yaml'
  Plug 'subosito/nginx.vim'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
  Plug 'terryma/vim-expand-region'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vimlab/neojs'
  Plug 'w0rp/ale'
  Plug 'wsdjeg/vim-fetch'
  Plug 'xolox/vim-misc'
  " Plug 'zchee/deoplete-clang'
call plug#end()

" basics
colorscheme gruvbox
" colorscheme peachpuff
filetype plugin indent on
set background=dark
" set background=light
" hi Search guibg=#ff2a50 guifg=#ffffff
" let &colorcolumn=join(range(81,250), ',')
" gruvbox's dark0, so it just looks like cursorline stops at 80
" highlight ColorColumn guibg=#282828
" highlight ColorColumn guibg=#ffe9ed
" so listchars are only visible on the current line
highlight SpecialKey guifg=#282828
if has('mouse') | set mouse=a | endif
set cino=:0,(shiftwidth
set clipboard=unnamedplus
set cursorline
set hidden
set ignorecase
set list
set magic
set nostartofline
set number
set shiftwidth=2
set smartcase
set tabstop=2
set termguicolors
set noexpandtab
set backupcopy=yes

" neoformat (prettier)
autocmd BufWritePre *.js Neoformat

" keys
"" leader
let g:mapleader="\<SPACE>"

"TODO maybe these keys should be with their package's settings so
"     the settings are grouped by purpose rather than type

" touch files after saving (to force inotify to update)
autocmd BufWritePost * silent! !touch %

"" normal
""" cd to current project root
""" ( https://gist.github.com/chee/492290caaf54e70caf37680bb05f7641 )
nnoremap <leader>cd :execute "cd " . system("project " . bufname("%"))<cr>:pwd<cr>
nnoremap <leader>lcd :execute "lcd " . system("project " . bufname("%"))<cr>:pwd<cr>
""" cd to current file
nnoremap <leader>fcd :cd %:h<cr>:pwd<cr>
nnoremap <leader>flcd :cd %:h<cr>:pwd<cr>
nnoremap <leader>/ :noh<cr>:<backspace>
nnoremap <leader>s. :so %<cr>
""" NERDTree
nnoremap <leader>\ :NERDTreeToggle<cr>
""" fzf!
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>fh :FZF ~<cr>
""" ack!
nnoremap <leader>fa :Ack!<space>
""" quickfix
nnoremap <leader>cn :cn<cr>
nnoremap <leader>cp :cp<cr>
""" buffer operations
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bl :call BufferList()<cr>
""" push words about
nnoremap <silent> gh "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> gl "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>
""" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
""" fugitive git bindings. thanks, jelle
""" https://github.com/jelly/Dotfiles/blob/master/.vimrc#L67
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Git push<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gbpr :!zsh -ci 'bpr; exit'<cr>
""" gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
""" neoterm
nnoremap <leader>xe :TREPLSendLine<cr>
nnoremap <leader>xr :TREPLSendFile<cr>
vnoremap <leader>xe :TREPLSendSelection<cr>

nnoremap <leader>tx :call neoterm#close()<cr>
nnoremap <leader>tl :call neoterm#clear()<cr>
nnoremap <leader>tc :call neoterm#kill()<cr>

"" insert
""" readline/emacs
nnoremap <C-p> k
nnoremap <C-n> j
nnoremap <C-e> $
nnoremap <C-a> ^
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-k> <C-o>d$
inoremap <C-M-k> <C-k>
inoremap <M-b> <C-o>b
inoremap <FocusLost> <esc>:w<cr>a
nnoremap <FocusLost> :w<cr>

inoremap <M-BS> <C-w>
cnoremap <M-BS> <C-w>
nnoremap <M-BS> <C-w>

command! SudoWrite w !sudo sponge %
cabbrev w!! <c-r>=(getcmdtype()==':' && getcmdpos()==-1 ? 'SudoWrite' : 'w!!')<cr>

" files/filetypes
au BufRead,BufNewFile *.wat set filetype=wast
au BufRead,BufNewFile .wmrc set filetype=dosini
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufNewFile,BufRead *.html set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

set visualbell

" deoplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_ignore_case = 1
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_camel_case = 1
" let g:deoplete#max_abbr_width = 0
" let g:deoplete#max_menu_width = 0
" let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('clang', 'filetypes', ['c', 'cpp', 'arduino'])
" let g:deoplete#enable_at_startup = 1

" tern
let g:tern_request_timeout = 1
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern#filetypes = [
      \ 'jsx',
      \ 'javascript.jsx'
      \ ]
"let g:deoplete#sources#tss#javascript_support = 1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" jsx
let g:jsx_ext_required = 0


" ale / airline-ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '△'
let g:ale_statusline_format = ['🔥 %d', '💁 %d', '']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline_skip_empty_sections = 1
let g:airline_section_error = '%{ALEGetStatusLine()}'
let g:ale_linters = {
      \ 'c': ['clang', 'clangtidy', 'flawfinder', 'cppcheck'],
      \ 'javascript': ['eslint', 'flow']
      \}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fix_on_save = 1

" NERDTree
let g:NERDTreeWinSize = 20

" vdebug
let g:vdebug_options = {'break_on_open': 0}

" use ag if avails
if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore node_modules'
endif

" fixmyjs
let g:fixmyjs_engine = 'eslint'
let g:fixmyjs_rc_filename = ['.eslintrc', '.eslintrc.json', 'eslintrc.js']
