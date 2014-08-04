""""""""""""""""""""""""""
" NeoBundle configuration
""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-sleuth'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


""""""""""""""""""""""""
" Convenience functions
""""""""""""""""""""""""
" detect windows version of gVim
function! RunningWindows()
  return has('win16') || has('win32') || has('win64')
endfunction

" detect mac version of gVim
function! RunningMac()
  return has('mac')
endfunction

" easy configuration of Solarize & options
function! Solarize(...)
  if a:0 >= 1
    let &background=a:1
  else
    let &background='light'
  endif
  if a:0 >= 2
    let g:solarized_termcolors=a:2
  else
    let g:solarized_termcolors=16
  endif
  colorscheme solarized
endfunction

""""""""""""""""
" Configuration
""""""""""""""""
" remove old autocommands
autocmd!

" map a leader character for keybindings
let mapleader = ","

" no more bells and whistles
set visualbell
set t_vb=

" longer history
set history=200

" general ui settings
set ruler
set showcmd

" smart case in searches: "/" search will be case insensitive unless terms
" contain a capital letter
set ignorecase
set smartcase

" filetype detection
filetype on
filetype plugin on
filetype plugin indent on

" syntax settings
syntax enable

" search settings
set incsearch
set hlsearch
set listchars=tab:>-
" backspace settings
set backspace=indent,eol,start
" mac file format support
set fileformats=unix,dos,mac

""""""""""""""""""""""""""
" Key bindings and remaps
""""""""""""""""""""""""""
if version >= 700
  " keybindings for tabbed windows
  map <leader>t :tabnew 
  map <leader>T :tabnew<CR>
  map <leader>D :tabclose<CR>
  ""map <leader>D :tabonly<CR>

  " shell integration
  map <leader>hh :ConqueTerm
  map <leader>hb :ConqueTerm bash<CR>

  " NERDTree support
  try
    map <leader>n :execute 'NERDTreeToggle ' . escape(getcwd(), '\ ')<CR>
    map <leader>N :NERDTree 
    map <leader>m :Bookmark 
    map <leader>' :BookmarkToRoot 
  catch
  endtry
endif

" write to buffer as root
map <leader>## :!sudo vim %<CR>
map <leader>#w :w !sudo tee %<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

""""""""""""""""""""
" GUI configuration
""""""""""""""""""""
if has('gui_running')
  set t_Co=256

  if RunningWindows()
    " in windows shutting off the visual bell seem to register when running
    " gVim, so use the following to force the bloody screen flash to go away
    autocmd GuiEnter * set t_vb=
    " windows preferred font
    set guifont=Consolas:h9
    " set lines to 999 - force autoscaling of window height
    set lines=999
  elseif RunningMac()
    set guifont=Anonymous\ Pro:h11
    call Solarize('dark', 256)
  else
    " linux preferred font
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
  end

  " use better labels for GUI tabs
  set guitablabel=%!expand(\"\%:t\")

  " remove the, largely useless, toolbar
  set guioptions-=T
else
  " color scheme for terminal operation - special case if 256 colors are
  " available
  if &t_Co == 256
    call Solarize('dark')
  else
    colorscheme desert
    call Solarize('dark', 16)
  endif
end
