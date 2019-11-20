"  .-.-----------.-.
"  | |-----------|#|
"  | |-STEPHEN'S-| |
"  | |---VIMRC---| |
"  | |-----------| |
"  | "-----------' |
"  |  .-----.-..   |
"  |  |     | || |||
"  |  |     | || \/|
"  "--^-----^-^^---'

"""""""""""
" vim-plug
" https://github.com/junegunn/vim-plug

" vim-plug auto-installer
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plugin plugin auto-installer
autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif

" vim-plug configuration block
call plug#begin('~/.vim/plugged')

" smarttab
" Plug 'https://github.com/vim-scripts/Smart-Tabs.git'
Plug 'https://github.com/dpc/vim-smarttabs.git', { 'as': 'smarttab' }

" dracula theme
" https://draculatheme.com/vim/
Plug 'dracula/vim', { 'as': 'dracula' }

" initialize vim-plug
" vim-plug automatically activates the following settings:
"   filetype off
"   filetype plugin intent on
"   syntax on
call plug#end()


""""""""""""""""
" other plugins

" matchit
" extends % matching to more easily accomodate HTML, Python, et al.
silent! runtime macros/matchit.vim


""""""""""
" general

" ancient shorthand for 'not totally vi compatible', ergo, to us, 'better'
set nocompatible

" make backspacing work as one might expect nowadays
set backspace=indent,eol,start

" of vim's options for autocompleting phrases, remove the 'included files' flag
set complete-=i

" better behavior for the quickfix window and :sb
set switchbuf=useopen,usetab

" of vim's accepted targets for increase/decrease hotkeys, remove the 'octal'
" flag (practically, this prevents numbers starting with 0 from being
" interpreted as octal)
set nrformats-=octal

" for non-neovim clients, if no macro hotkey timeout is set, set a reasonable
" one (rather than the long and error-promoting default)
if !has('nvim') && &ttimeoutlen == -1
	set ttimeout
	set ttimeoutlen=100
endif

" enable incremental search (e.g. jump to partial match mid-type)
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if &synmaxcol == 3000
    " Lowering this improves performance in files with long lines.
    set synmaxcol=500
endif

" Preserves undo chain when using <C-U> and <C-W> in insert mode
if empty(mapcheck('<C-U>', 'i'))
    inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
endif

" enables mouse support
if has('mouse')
    set mouse=a
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" search tags files efficiently
" see: https://vimhelp.org/editing.txt.html#file-searching
if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" set internal vim CLI to bash even if invoking CLI is fish
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276')) 
    set shell=/usr/bin/env\ bash
endif

" quick buffer navigation
nnoremap gb :buffers<CR>:sb<Space>

" allows hot reloading of buffered file that has been changed outside of vim
set autoread

" trigger autoread when buffer switches or vim reattains focus
au FocusGained,BufEnter * :silent! !

" autosave when losing focus or leaving buffer
au FocusLost,WinLeave * :silent! w

" set history length to sane minimum default
if &history < 1000
    set history=1000
endif

" set tab page maximum to sane minimum default
if &tabpagemax < 50
    set tabpagemax=50
endif



"""""""""
" vim ui

" blaaaaahhh!!!!!
color dracula

" always display statusbar
set laststatus=2

" display current cursor position (e.g. 'ruler') in the corner of the vim window
set ruler

" display command completion matches in a status line
set wildmenu

" display incomplete commands to the left of the ruler
set showcmd

" if editor isn't set to vertically center your cursor, set it to do so
if !&scrolloff
	set scrolloff=1
endif

" if editor isn't set to horizontally center your cursor, set it to do so
if !&sidescrolloff
	set sidescrolloff=5
endif

" when document is taller than the screen, don't show '@@@' to indicate overflow
set display+=lastline


""""""""""""""
" indentation

" set human-readable tab length (what the fuck, 70s terminal people)
set tabstop=4

" use spaces instead of the tab character
set expandtab

" indenting is 4 spaces
set shiftwidth=4

" apply indentation of current line to the next
set autoindent

" handle indentation rules better in language-specific contexts
set smartindent

" use the smart tabs plugin (see vim-plug configuration block)
set smarttab

" modeline settings for this file only
" vim:set ft=vim et sw=2:
