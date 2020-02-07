" Auto install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Explorer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completions
Plug 'vim-airline/vim-airline' " Helpful status bar
Plug 'editorconfig/editorconfig-vim' " Indent/EOL formatting rules
Plug 'prettier/vim-prettier', { 'do': 'npm install' } " Code formatter
Plug 'sheerun/vim-polyglot' " Language packs
call plug#end()

syntax on
colorscheme default

let mapleader="\<SPACE>"
set shiftwidth=0
set tabstop=4

" nerdtree
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
map <Leader>e :NERDTreeToggle<CR>

" vim-airline
set noshowmode

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


