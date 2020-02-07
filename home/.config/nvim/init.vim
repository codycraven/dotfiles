" Install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Use plugged directory for plugins
call plug#begin('~/.config/nvim/plugged')
" Explorer, auto load
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Initialize plugin system
call plug#end()

let mapleader="\<SPACE>"

let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
map <Leader>e :NERDTreeToggle<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

