"\Before using, install vim-plug, This is an example of how to install for Neovim:
"curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"you must also have fuzzy finder and silversearcher installed on the system to
"use <C-p> and <A-p> search commands.

"All plugins will be installed to ~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'nvie/vim-flake8'
Plug 'sheerun/vim-polyglot'
Plug 'ervandew/supertab'
Plug 'chrisbra/csv.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
call plug#end()

"Moving lines up and down in various modes using Alt+j and Alt+k
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv

"prevent read only files from being modified
autocmd BufRead * let &l:modifiable = !&readonly

nnoremap <esc> :noh<CR><esc>
set timeoutlen=2000
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = ' %linter%  [%severity%] %code%: %s'
let g:ackprg = 'ag --nogroup --nocolor --column' "use silver searcher
let g:ale_sign_error = '┃'
let g:ale_sign_warning = '┃'
let g:ale_linters = {'sql' : ['sqlint'], 'rust' : ['cargo', 'rustc'] }
let g:ale_fixers = {'javascript' : ['eslint']}
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
map <Leader>af :ALEFix<CR>
map <Leader>al :ALELint<CR>
map <Leader>aj :ALENext<CR>
map <Leader>ak :ALEPrevious<CR>
map <Leader>\| :vsplit<CR>
map <Leader>-  :split<CR>
map <Leader>q  <C-w>q
map <Leader>w  :w<CR>
map <Leader>_  :botright split<CR>

"On windows might need to use set clipboard=unnamed
set clipboard=unnamedplus


augroup cursorlines
    autocmd!
    "autocmd InsertEnter * set cursorline
    autocmd InsertEnter * set cursorcolumn
    "autocmd InsertEnter * hi CursorLine ctermbg=234
    autocmd InsertEnter * hi CursorColumn ctermbg=234
    "autocmd InsertLeave * set cursorline!
    autocmd InsertLeave * set cursorcolumn!
augroup end


"save with sudo

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ale_python_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_pylint_change_directory = 0

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
autocmd BufWritePost * GitGutter

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gta :Gcommit -v -q -a<CR>

let g:sql_type_default = 'pgsql'

let g:airline_theme='base16'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#show_tab_nr = 0

"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:ale_sign_column_always = 1

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=233
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=233

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

let g:SuperTabClosePreviewOnPopupClose = 1 

set number "line numbers

set tabstop=4 
set shiftwidth=4
set expandtab "set tabs to 4 spaces

set splitbelow
set splitright

let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR> 


" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

map <C-p> :Files<CR>
map <A-p> :Ag<CR>
map <A-b> :Buffers<CR>

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] "set when quickscope should highlight target letters


"base16 color schemes
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
else 
    colorscheme base16-think "default scheme
endif

highlight ALEErrorSign ctermbg=Black ctermfg=Red
highlight ALEWarning ctermbg=Yellow ctermfg=Black
highlight ALEError ctermbg=Red ctermfg=Black

if &term !=? 'linux' || has('gui_running')
    set listchars=tab:›\ ,extends:>,precedes:<,nbsp:˷,eol:⤶,trail:~
    set fillchars=vert:│,fold:─,diff:-
    augroup TrailingSpaces
        autocmd!
        autocmd InsertEnter * set listchars-=eol:⤶,trail:~
        autocmd InsertLeave * set listchars+=eol:⤶,trail:~
    augroup END
else
    set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,eol:$,trail:~
    set fillchars=vert:\|,fold:-,diff:-
    augroup TrailingSpaces
        autocmd!
        autocmd InsertEnter * set listchars-=eol:$,trail:~
        autocmd InsertLeave * set listchars+=eol:$,trail:~
    augroup END
endif

