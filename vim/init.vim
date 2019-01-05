

"""""""""""""""""""
"Autoload vim-plug
"""""""""""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    silent! exec "!clear"
    exec "!time python3 %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'vimwiki'
    exec "MarkdownPreview"
  endif
endfunc


" ===
" === System
" ===
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8

set clipboard=unnamed

" Prevent incorrect backgroung rendering
let &t_ut=''

" ===
" === Main code display
" ===
set number
set ruler
set cursorline
set cursorcolumn
syntax enable
syntax on

" ===
" === Editor behavior
" ===
" Better tab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5

" Prevent auto line split
set wrap
set tw=0

set indentexpr=
" Better backspace
set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ===
" === Window behaviors
" ===
set splitright
set splitbelow

" ===
" === Status/command bar
" ===
set laststatus=2
set autochdir
set showcmd
set formatoptions-=tc

" Show command autocomplete
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" Searching options
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

" ===
" === Basic Mappings
" ===

source ~/.config/nvim/mdscript


map s <nop>

" Set <LEADER> as <SPACE>
let mapleader=" "
" Save & quit
map Q :q<CR>
map W :w<CR>
map X :x<CR>

" Set Search
noremap n nzz
noremap N Nzz
noremap <LEADER><CR> :nohlsearch<CR>

" K/J keys for 5 times k/j (faster navigation)
noremap K 5k
noremap J 5j

" Split
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>

map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"Tab operations
map tt :tabe<CR>

map th :-tabnext<CR>
map tl :+tabnext<CR>

"Spill Check
  "map <LEADER>sc :set spell!<CR>
  "inoremap <C-x> <ESC>ea<C-x>s
  "noremap <C-x> ea<C-x>s

" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i
map <LEADER>= <ESC>i<++><ESC>
inoremap <C-=> <ESC>a<++>

call plug#begin('~/.config/nvim/vimplugin')

"color theme
Plug 'liuchengxu/space-vim-theme'
set background=dark
colorscheme space_vim_theme
set termguicolors
"colorscheme snazzy
let g:space_vim_transp_bg = 1

" "start menu
" Plug 'mhinz/vim-startify'


" "airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_theme='wombat'
" let g:airline#extensions#tabline#enabled = 1

"limelight
Plug 'junegunn/limelight.vim'



" 自动补全
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-path'

" NCM2_maps
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NCM2 java support
Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}


" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0


" 注释
Plug 'scrooloose/nerdcommenter'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1



" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'



" ===
" === vim-table-mode
" ===
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
map <LEADER>tm :TableModeToggle<CR>


" ===
" === vimwiki
" ===
Plug 'vimwiki/vimwiki'
"set markdown syntax
let g:vimwiki_list = [{'path': '~/vimwiki/', 'ext': '.md', 'syntax': 'markdown'}]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checied = 1
let g:vimwiki_global_ext = 0


" ===
" === calendar-vim
" ===
Plug 'mattn/calendar-vim'
noremap <LEADER>c :Calendar<CR>

au BufRead,BufNewFile *.wiki set filetype=vimwiki
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction


" File navigation

" ===
" === NERDTree
" ===
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = ""
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

autocmd StdinReadPre * let s:std_in=1
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"NERDTree 窗口快捷键
map <C-n> :NERDTreeToggle<CR>

Plug 'Xuyuanp/nerdtree-git-plugin'


" Other visual enhancement
" ===
" === vim-indent-guide
" ===
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig


Plug 'itchyny/vim-cursorword'
"Plug 'tmhedberg/SimpylFold'


call plug#end()

"Calendar
autocmd FileType vimwiki map c :call ToggleCalendar()
