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
call plug#end()

let mapleader="\<SPACE>"

let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
map <Leader>e :NERDTreeToggle<CR>

" vim-airline
set noshowmode

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * call clearmatches()
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

