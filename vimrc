scriptencoding utf-8
if &compatible || exists('g:loaded_lazyvim')
     finish
endif
let g:loaded_lazyvim = 1

let s:save_cpo = &cpo
set cpo&vim

let mapleader = "\<Space>"
"set guifont=Monaco:h16
set guifont=YaHei-Consolas-Hybrid:h16

" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"1 - open files in a new horizontal split
"2 - open files in a new vertical split
"3 - open files in a new tab
"4 - open in previous window
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 15
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END
"Toggles explorer buffer
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let g:netrw_browse_split = 3
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        let g:netrw_browse_split = 4
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
" -- end of netrw settings

"对于markdown文件需要进行换行方便书写
autocmd FileType markdown set wrap

" Plug - Specify a directory for plugins
call plug#begin('~/.vim/plug')
    " On-demand loading
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
    Plug 'airblade/vim-gitgutter'
    "Plug 'tpope/vim-fugitive' " 显示git branch
    Plug 'yggdroot/indentLine'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'scrooloose/nerdcommenter' " 代码注释
    "Plug 'SirVer/ultisnips' " 预定义模板
    "Plug 'honza/vim-snippets' " 模板库
    Plug 'alvan/vim-closetag' " html自动补全
    Plug 'lazywalker/auto-pairs' " 符号自动补全
    Plug 'godlygeek/tabular' " 按符号自动对齐如: Tab \= , : Tab \|
    "Plug 'iamcco/mathjax-support-for-mkdp' " mardown实时预览辅助插件
    "Plug 'iamcco/markdown-preview.vim' " mardown实时预览插件
    "Plug 'mzlogin/vim-markdown-toc', { 'for':  'md' }
    Plug 'plasticboy/vim-markdown', { 'for':  'md' }
    Plug 'kien/ctrlp.vim' " CtrlP文件名搜索
    Plug 'dyng/ctrlsf.vim' " 全文搜索功能
    "Plug 'w0rp/ale' " 语法提示
    Plug 'vim-syntastic/syntastic' "语法提示
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'majutsushi/tagbar' " tagbar显示文件大纲
    Plug 'morhetz/gruvbox' "gruv box colorscheme
call plug#end()

"
"" statusline
"
"  (Lazy)  README.md[+] /home/mic/.vim [unix:utf-8:MARKDOWN]       18,5      50%
"  +----+  +----------+ +------------+ +-------------------+       +--+      +-+
"  1       2         3                 4                           5         6

function Version ()
    return system("grep -o '^v[0-9\.]*' ~/.vim/version|tr -d '\n'")
endfunction
set laststatus=2
set statusline=[Lazy.%{Version()}]\ \ %<%f
set statusline+=%w%h%m%r
set statusline+=\ %{getcwd()}
set statusline+=\ [%{&ff}:%{&fenc}:%Y]
set statusline+=%=%-14.(%l,%c%V%)\ %p%%

"
" coc settings
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" end of coc settings.

"
" syntastic settings
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"
" rust.vim settings
"
let g:rustfmt_autosave = 1

"
" NERDTree
"
let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowHidden          = 1
let g:NERDTreeBookmarksFile       = $HOME.'/.vim/.nerdbookmarks'
let g:NERDTreeShowBookmarks       = 0
let g:NERDTreeShowFiles           = 1
let g:NERDTreeShowLineNumbers     = 0
let g:NERDTreeWinSize             = 29
let g:NERDTreeMinimalUI           = 0
let g:NERDTreeDirArrows           = 1
let g:NERDTreeIgnore              = [
            \ '.*\.class',
            \ '.*\.pyc',
            \ '.*\.chm',
            \ '.*\.ttf',
            \ '.*\.lnk',
            \ '.*\.cproj',
            \ '.*\.exe',
            \ '.*\.dll',
            \ '.*\.out',
            \ '.*\.files',
            \ '.*\.zip',
            \ '.*\.rar',
            \ '.*\.gif',
            \ '.git$',
            \ '.DS_Store'
            \ ]
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

"
" ctrlp
"
" Making CtrlP.vim load 100x faster — A Tiny Piece of Vim — Medm
" https://medium.com/a-tiny-piece-of-vim/making-ctrlp-vim-load-100x-faster-7a722fae7df6#.emcvo89nx
let g:ctrlp_user_command = [
            \ '.git/',
            \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
            \ ]
let g:ctrlp_match_window       = 'bottom,order:btt,min:5,max:5,results:10'
let g:ctrlp_cmd                = 'CtrlPMixed'
let g:ctrlp_mruf_default_order = 1
let g:ctrlsf_backend = "ag" "macOS: brew install ag / debian: sudo apt install silversearcher-ag

" tagbar 
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_ctags_bin = "ctags" "macOS: brew install --HEAD universal-ctags/universal-ctags/universal-ctags / debian: apt install universal-ctags

" nerdcommenter
let g:NERDCustomDelimiters = { 'tt': { 'left': '#NOP '} }

let g:gitgutter_terminal_reports_focus=1
let g:vim_markdown_conceal_code_blocks = 0
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:AutoPairs = {'(':')', '[':']', '{':'}', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Neovim has set these as default：
if !has('nvim')

    set nocompatible

    syntax on                      " Syntax highlighting
    filetype plugin indent on      " Automatically detect file types
    set autoindent                 " Indent at the same level of the previous line
    set autoread                   " Automatically read a file changed outside of vim
    set backspace=indent,eol,start " Backspace for dummies
    set complete-=i                " Exclude files completion
    set display=lastline           " Show as much as possible of the last line
    set encoding=utf-8             " Set default encoding
    set history=10000              " Maximum history record
    set hlsearch                   " Highlight search terms
    set incsearch                  " Find as you type search
    set laststatus=2               " Always show status line
    set mouse=a                    " Automatically enable mouse usage
    set smarttab                   " Smart tab
    set ttyfast                    " Faster redrawing
    set viminfo+=!                 " Viminfo include !
    set wildmenu                   " Show list instead of just completing

    set ttymouse=xterm2
endif

set updatetime=1000 " 1000ms, default value is 4000
set shortmess=atOI " No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set ignorecase     " Case insensitive search
set smartcase      " ... but case sensitive when uc present
set scrolljump=5   " Line to scroll when cursor leaves screen
set scrolloff=3    " Minumum lines to keep above and below cursor
set nowrap         " Do not wrap long lines
set shiftwidth=4   " Use indents of 4 spaces
set tabstop=4      " An indentation every four columns
set softtabstop=4  " Let backspace delete indent
set splitright     " Puts new vsplit windows to the right of the current
set splitbelow     " Puts new split windows to the bottom of the current
set autowrite      " Automatically write a file when leaving a modified buffer
set mousehide      " Hide the mouse cursor while typing
set hidden         " Allow buffer switching without saving
set t_Co=256       " Use 256 colors
"set termguicolors  " enable true color
set ruler          " Show the ruler
set showcmd        " Show partial commands in status line and Selected characters/lines in visual mode
set showmode       " Show current mode in command-line
set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set report=0       " Always report changed lines
set linespace=0    " No extra spaces between rows
set pumheight=20   " Avoid the pop up menu occupying the whole screen

if !exists('g:lazyvim_tabs_as_spaces') || g:lazyvim_tabs_as_spaces
    set expandtab    " Tabs are spaces, not tabs
end

" http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
set t_ut=

set winminheight=0
set wildmode=list:longest,full

set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries

set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Change cursor shape for iTerm2 on macOS {
    " bar in Insert mode
    " inside iTerm2
    if $TERM_PROGRAM =~# 'iTerm'
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif

    " inside tmux
    if exists('$TMUX') && $TERM != 'xterm-kitty'
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        " True color fixed
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    " inside neovim
    if has('nvim')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
    endif
" }

if get(g:, 'lazyvim_minimum', 0)
    finish
endif

if get(g:, 'lazyvim_backup_on', 0)
    set backup
else
    set nobackup
    set noswapfile
    set nowritebackup
endif

if get(g:, 'lazyvim_enable_folding', 1)
    set foldenable
    set foldmarker={,}
    set foldlevel=0
    set foldmethod=marker
    " set foldcolumn=3
    set foldlevelstart=99
endif

set background=dark         " Assume dark background
"colorscheme solarized8_flat
autocmd vimenter * colorscheme gruvbox
set cursorline              " Highlight current line
set fileformats=unix,dos,mac        " Use Unix as the standard file type
set number                  " Line numbers on
"set relativenumber          " Relative numbers on
set fillchars=stl:\ ,stlnc:\ ,fold:\ ,vert:│

" Annoying temporary files
set directory=/tmp//,.
set backupdir=/tmp//,.
if v:version >= 703
    set undodir=/tmp//,.
endif

highlight clear SignColumn  " SignColumn should match background
" highlight clear LineNr      " Current line number row will have same background color in relative mode

if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
else
    set clipboard+=unnamed
endif

if get(g:, 'lazyvim_persistent_undo', 0)
    if has('persistent_undo')
        set undofile             " Persistent undo
        set undolevels=1000      " Maximum number of changes that can be undone
        set undoreload=10000     " Maximum number lines to save for undo on a buffer reload
    endif
endif

if has('gui_running')
    set guioptions-=r        " Hide the right scrollbar
    set guioptions-=L        " Hide the left scrollbar
    set guioptions-=T
    set guioptions-=e
    set shortmess+=c
    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set visualbell t_vb=
endif

" Key (re)Mappings {

    if get(g:, 'lazyvim_key_mapping', 1)

        " Basic {
          if get(g:, 'lazyvim_basic_key_mapping', 1)
            " Add <slient> for the rhs is Ex-cmd as some GUI app, e.g., gnvim,
            " flashes when you use these mappings.
            " Quit normal mode
            nnoremap <silent> <Leader>q  :q<CR>
            nnoremap <silent> <Leader>Q  :qa!<CR>
            nnoremap <silent> <Leader>tr :NERDTreeToggle<CR>
            nnoremap <silent> <Leader>tf :NERDTreeFind<CR>
            nnoremap <silent> <Leader>tg :GitGutterToggle<CR>
            " CtrlSF mapping
            nmap     <Leader>sf <Plug>CtrlSFPrompt
            nnoremap <silent> <Leader>tsf :CtrlSFToggle<CR>
            nnoremap <silent> <Leader>te :call ToggleVExplorer()<CR>
            nnoremap <silent> <Leader>tb :Tagbar<CR>
            " tab switching
            nnoremap <silent> <Leader>tac  :tabnew<CR>
            nnoremap <silent> <Leader>tan  :tabnext<CR>
            nnoremap <silent> <Leader>tap  :tabprevious<CR>

            " Move half page faster
            nnoremap <Leader>d  <C-d>
            nnoremap <Leader>u  <C-u>
            " Insert mode shortcut
            inoremap <C-j> <Down>
            inoremap <C-k> <Up>
            inoremap <C-h> <Left>
            inoremap <C-l> <Right>
            " Bash like
            inoremap <C-a> <Home>
            inoremap <C-e> <End>
            inoremap <C-d> <Delete>
            " Command mode shortcut
            cnoremap <C-j> <Down>
            cnoremap <C-k> <Up>
            cnoremap <C-h> <Left>
            cnoremap <C-l> <Right>
            cnoremap <C-a> <Home>
            cnoremap <C-e> <End>
            cnoremap <C-d> <Delete>
            " jj | escaping
            inoremap jj <Esc>
            cnoremap jj <C-c>
            " Quit visual mode
            vnoremap v <Esc>
            " Move to the start of line
            nnoremap H ^
            " Move to the end of line
            nnoremap L $
            " Redo
            nnoremap U <C-r>
            " Quick command mode
            nnoremap <CR> :
            " In the quickfix window, <CR> is used to jump to the error under the
            " cursor, so undefine the mapping there.
            autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
            " Yank to the end of line
            nnoremap Y y$
            " Auto indent pasted text
            " nnoremap p p=`]<C-o>
            " Open shell in vim
            if has('nvim') || has('terminal')
                map <silent> <Leader>' :terminal<CR>
            else
                map <silent> <Leader>' :shell<CR>
            endif
            " Search result highlight countermand
            nnoremap <silent> <Leader>sc :nohlsearch<CR>
            " Toggle pastemode
            nnoremap <silent> <Leader>tp :setlocal paste!<CR>
          endif
        " }

        " Buffer {
          if get(g:, 'lazyvim_buffer_key_mapping', 1)
            nnoremap <silent> <Leader>bp :bprevious<CR>
            nnoremap <silent> <Leader>bn :bnext<CR>
            nnoremap <silent> <Leader>bf :bfirst<CR>
            nnoremap <silent> <Leader>bl :blast<CR>
            nnoremap <silent> <Leader>bd :bd<CR>
            nnoremap <silent> <Leader>bk :bw<CR>
          endif
        " }

        " File {
          if get(g:, 'lazyvim_file_key_mapping', 1)
            " File save
            nnoremap <silent> <Leader>fs :update<CR>
          endif
        " }

        " Fold {
          if get(g:, 'lazyvim_fold_key_mapping', 1)
            nnoremap <silent> <Leader>f0 :set foldlevel=0<CR>
            nnoremap <silent> <Leader>f1 :set foldlevel=1<CR>
            nnoremap <silent> <Leader>f2 :set foldlevel=2<CR>
            nnoremap <silent> <Leader>f3 :set foldlevel=3<CR>
            nnoremap <silent> <Leader>f4 :set foldlevel=4<CR>
            nnoremap <silent> <Leader>f5 :set foldlevel=5<CR>
            nnoremap <silent> <Leader>f6 :set foldlevel=6<CR>
            nnoremap <silent> <Leader>f7 :set foldlevel=7<CR>
            nnoremap <silent> <Leader>f8 :set foldlevel=8<CR>
            nnoremap <silent> <Leader>f9 :set foldlevel=9<CR>
          endif
        " }

        " Window {
          if get(g:, 'lazyvim_window_key_mapping', 1)
            nnoremap <Leader>ww <C-W>w
            nnoremap <Leader>wr <C-W>r
            nnoremap <Leader>wd <C-W>c
            nnoremap <Leader>wq <C-W>q
            nnoremap <Leader>wj <C-W>j
            nnoremap <Leader>wk <C-W>k
            nnoremap <Leader>wh <C-W>h
            nnoremap <Leader>wl <C-W>l
            if has('nvim') || has('terminal')
                tnoremap <Leader>wj <C-W>j
                tnoremap <Leader>wk <C-W>k
                tnoremap <Leader>wh <C-W>h
                tnoremap <Leader>wl <C-W>l
            endif
            nnoremap <Leader>wH <C-W>5<
            nnoremap <Leader>wL <C-W>5>
            nnoremap <Leader>wJ :resize +5<CR>
            nnoremap <Leader>wK :resize -5<CR>
            nnoremap <Leader>w= <C-W>=
            nnoremap <Leader>ws <C-W>s
            nnoremap <Leader>w- <C-W>s
            nnoremap <Leader>wv <C-W>v
            nnoremap <Leader>w\| <C-W>v
            nnoremap <Leader>w2 <C-W>v
          endif
        " }

    endif

" }

" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
	au!
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid, when inside an event handler
	" (happens when dropping a file on gvim) and for a commit message (it's
	" likely a different one than last time).
	autocmd BufReadPost *
				\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ |   exe "normal! g`\""
				\ | endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
