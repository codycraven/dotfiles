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
Plug 'prettier/vim-prettier', { 'do': 'npm install' } " Code formatter
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'preservim/nerdcommenter' " Language generic comments
Plug 'airblade/vim-gitgutter'
" Completions
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Framework
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " JS support
call plug#end()

syntax on
filetype plugin on
colorscheme default

let mapleader="\<SPACE>"
set shiftwidth=0
set tabstop=4
set updatetime=100

map <Leader>- :nohlsearch<CR>

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

" gitgutter
let g:gitgutter_escape_grep = 1 " prevent issues with color output alias
"let g:gitgutter_diff_args = '-w' " ignore whitespace
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
highlight GitGutterDelete guifg=#f44747 guibg=#d16969 ctermfg=9 ctermbg=1
highlight GitGutterChange guifg=#a0e580 guibg=#a0e580 ctermfg=10 ctermbg=2
highlight GitGutterAdd guifg=#dfe74b guibg=#a0e580 ctermfg=11 ctermbg=3

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
map <Leader>n :set relativenumber! nonumber!<CR>

" Completions
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
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'vue',
                \ ]
