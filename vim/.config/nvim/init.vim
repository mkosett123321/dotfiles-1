set nocompatible
filetype off

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'git://repo.or.cz/vcscommand'
Plug 'vimwiki'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-latex/vim-latex'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'lukaszkorecki/workflowish'
Plug 'tpope/vim-sleuth'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

call plug#end()

syntax on
filetype plugin indent on

set backspace=indent,eol,start
set softtabstop=4
set shiftwidth=4
set tabstop=4
set noexpandtab
set number
set ruler
set showcmd
set errorformat^=%-GIn\ file\ included\ %.%#
set foldmethod=syntax

set title

set nojoinspaces

set mouse=a

cmap w!! w !sudo tee > /dev/null %

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

let delimitMate_expand_cr = 1

command Bc bp|bd #

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function WrapOn()
	setlocal wrap linebreak nolist
	set virtualedit=
	setlocal display+=lastline
	noremap  <buffer> <silent> <Up>   g<Up>
	noremap  <buffer> <silent> <Down> g<Down>
	noremap  <buffer> <silent> <Home> g<Home>
	noremap  <buffer> <silent> <End>  g<End>
	inoremap <buffer> <silent> <Up>   <C-o>gk
	inoremap <buffer> <silent> <Down> <C-o>gj
	inoremap <buffer> <silent> <Home> <C-o>g<Home>
	inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction
function WrapOff()
	setlocal nowrap
	set virtualedit=all
	silent! nunmap <buffer> <Up>
	silent! nunmap <buffer> <Down>
	silent! nunmap <buffer> <Home>
	silent! nunmap <buffer> <End>
	silent! iunmap <buffer> <Up>
	silent! iunmap <buffer> <Down>
	silent! iunmap <buffer> <Home>
	silent! iunmap <buffer> <End>
endfunction
function ToggleWrap()
	if &wrap
		echo "Wrap OFF"
		call WrapOff()
	else
		echo "Wrap ON"
		call WrapOn()
	endif
endfunction
call WrapOn()

if $TERM =~ '^rxvt'
  set background=dark
  colorscheme solarized
endif

set spellfile=~/.vim/spell/en.utf-8.add

set laststatus=2

let g:airline_powerline_fonts = 1

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='latexmk -pdf -synctex=1'

set printoptions+=paper:letter

let hostfile= $HOME . '/vimrc-' . hostname()
if filereadable(hostfile)
	exe 'source ' . hostfile
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif

if $TERM =~ '^xterm\\|rxvt'
  " solid underscore
  let &t_SI .= "\<Esc>[4 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

if has('nvim')
  tnoremap <Leader><Esc> <C-\><C-n>
endif

let g:ycm_enable_diagnostic_signs=0
" Thanks to http://superuser.com/questions/558876/how-can-i-make-the-sign-column-show-up-all-the-time-even-if-no-signs-have-been-a
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')