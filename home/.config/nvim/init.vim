" Auto install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Explorer
Plug 'vim-airline/vim-airline' " Helpful status bar
Plug 'editorconfig/editorconfig-vim' " Indent/EOL formatting rules
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'preservim/nerdcommenter' " Language generic comments
Plug 'mhinz/vim-signify' " VCS highlights
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file finder
Plug 'dense-analysis/ale', { 'do': 'npm install -g prettier' } " Linter
" Completions
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Framework
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " JS
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go
call plug#end()

syntax on
filetype plugin on
colorscheme default

let mapleader="\<SPACE>"
set shiftwidth=0
set tabstop=4
set updatetime=100

" toggle comments with nerdcommenter (acts on ctrl-/)
map <C-_> <Leader>c<space>
" clear search highlights
nmap <Leader>- :nohlsearch<CR>
" copy selection to system clipboard
vmap <C-c> "+y<CR>
" open completions easier
imap <C-Space> <C-X><C-O>

" nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "right"
map <Leader>e :NERDTreeToggle<CR>

" vim-airline
set noshowmode

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
augroup trailingwhitespace
	autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
	autocmd InsertEnter * call clearmatches()
	autocmd InsertLeave * match TrailingWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
augroup END

set relativenumber number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" vcs highlights
highlight SignColumn        ctermbg=NONE   ctermfg=NONE guibg=NONE gui=NONE
highlight SignifySignDelete ctermbg=1      ctermfg=0    guibg=#d16969 guifg=#090909
highlight SignifySignChange ctermbg=2      ctermfg=0    guibg=#acc2a2 guifg=#090909
highlight SignifySignAdd    ctermbg=3      ctermfg=0    guibg=#d6db7b guifg=#090909

" linter
" see ftplugin files for fixer configuration
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" ctrlp
let g:ctrlp_working_path_mode = 'ra'

" completions
augroup omnifuncs
	autocmd!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	" auto close annoying scratch window after completions
	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#filter = 0
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#expand_word_forward = 0
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#in_literal = 0
if exists("deoplete#custom#option")
	call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
endif
