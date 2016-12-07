
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" Amir Salihefendic
" http://amix.dk - amix@amix.dk
"
" Version:
" 5.0 - 29/05/12 15:43:36
"
" Blog_post:
" http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
" Get this config, nice color schemes and lots of plugins!
"
" Install the awesome version from:
"
" https://github.com/amix/vimrc
"
" Syntax_highlighted:
" http://amix.dk/vim/vimrc.html
"
" Raw_version:
" http://amix.dk/vim/vimrc.txt
"
" Sections:
" -> General
" -> VIM user interface
" -> Colors and Fonts
" -> Files and backups
" -> Text, tab and indent related
" -> Visual mode related
" -> Moving around, tabs and buffers
" -> Status line
" -> Editing mappings
" -> vimgrep searching and cope displaying
" -> Spell checking
" -> Misc
" -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set nu
set history=700
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp


" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leaderd>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

"Highlight current line of cursor
set cursorline

"vimdiff is vertical
set diffopt+=vertical

"Cliboard stuff
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"set ttyfast
" Add mouse support
if has("mouse")
    set mouse=a
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General and Mode-Switching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap escape key for exiting insert mode
"map jk <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable


syntax on
set background=light

let g:solarized_termtrans = 1
try
    colorscheme solarized
catch
endtry

try
    colorscheme base16-default
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"Make vertical separators and fillchars empty
set fillchars=""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
" <leader>cc
"
" To go to the next search result do:
" <leader>n
"
" To go to the previous search results do:
" <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>e :e ~/buffer<cr>

" Easily close a buffer
map <leader>q :q<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"Diff between currently edited file and unmodified version in filesystem.
"From: http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"For Vundle to work properly
set nocompatible
filetype off

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let vundle manage vundle(required)
Plugin 'gmarik/Vundle.vim'

""""""Add Plugins here

"In-buffer navigation
Plugin 'easymotion/vim-easymotion'

"Text manipulation
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'ntpeters/vim-better-whitespace'

"Filesystem
Plugin 'scrooloose/nerdtree.git'
"Make NERDTRee feel 'like a true panel'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

"Bash interaction
Plugin 'tpope/vim-eunuch'

"git
Plugin 'tpope/vim-fugitive'

"Languages, text formatting, etc
Plugin 'elzr/vim-json'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-abolish'

"Elixir
Plugin 'elixir-lang/vim-elixir'

"Elm
Plugin 'lambdatoast/elm.vim'

"Html, CSS
Plugin 'mattn/emmet-vim' "Emmet

"Javascript-specific
"Plugin 'valloric/youcompleteme'
Plugin 'marijnh/tern_for_vim'
Plugin 'pangloss/vim-javascript' "Better JS indenting and formatting
Plugin 'mxw/vim-jsx' "React.js autoindent, formatting. Requires vim-javascript
Plugin 'othree/javascript-libraries-syntax.vim' "Syntax for JS libraries

"JSHint -- not managed via Vundle
set runtimepath+=~/.vim/bundle/jshint2.vim/

"AngularJS
Plugin 'burnettk/vim-angular'

"Project, IDE-type stuff
Plugin 'majutsushi/tagbar'

"Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"Visual
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Base-16 colorscheme
Plugin 'chriskempson/base16-vim'

"Enhanced marks, see and navigate better
Plugin 'kshenoy/vim-signature'

"vim Improvement
Plugin 'tpope/vim-repeat'

"TODO 12/5: INSTALL SNIPMATE

""""" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin customization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"TODO: Ultisnips not working ..... 11/3/15
""""Ultisnips
let g:UltisnipsExpandTrigger="<tab>"
let g:UltisnipsJumpForwardTrigger="<c-b>"
let g:UltisnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsListSnippets="<c-s>"

""""JSX formatting for React.js
let g:jsx_ext_required = 0 "Allow JSX in normal JS files

""""For react.js, configure syntastic to use ESLINT
"This depends on the global .elslintrc file
"See https://jaxbot.me/articles/setting-up-vim-for-react-js-jsx-02-03-2015
""""
"make sure the javascript checkers listed are installed
let g:syntastic_javascript_checkers = ['eslint'] "alternative: 'jshint'
let g:jsx_ext_required = 0 "Allow JSX in normal JS files, and proper autoindent in JSX files

"""""Syntastic tidy-html checker ignoring angular tags, etc...
" Set up the arrays to ignore for later
if !exists('g:syntastic_html_tidy_ignore_errors')
  let g:syntastic_html_tidy_ignore_errors = []
endif

if !exists('g:syntastic_html_tidy_blocklevel_tags')
  let g:syntastic_html_tidy_blocklevel_tags = []
endif

" Try to use HTML5 Tidy for better checking?
let g:syntastic_html_tidy_exec = '/usr/local/bin/tidy5'
" AP: honestly can't remember if this helps or not
" installed with homebrew locally

" Ignore ionic tags in HTML syntax checking
" See http://stackoverflow.com/questions/30366621
" ignore errors about Ionic tags
let g:syntastic_html_tidy_ignore_errors += [
  \ "<ion-",
  \ "discarding unexpected </ion-"]

" Angular's attributes confuse HTML Tidy
let g:syntastic_html_tidy_ignore_errors += [
  \ " proprietary attribute \"ng-"]

" Angular UI-Router attributes confuse HTML Tidy
let g:syntastic_html_tidy_ignore_errors += [
  \ " proprietary attribute \"ui-sref"]

" Angular in particular often makes 'empty' blocks, so ignore
" this error. We might improve how we do this though.
" See also https://github.com/scrooloose/syntastic/wiki/HTML:---tidy
" specifically g:syntastic_html_tidy_empty_tags
let g:syntastic_html_tidy_ignore_errors += ["trimming empty "]

" Angular ignores
let g:syntastic_html_tidy_blocklevel_tags += [
  \ 'ng-include',
  \ 'ng-form'
  \ ]

" Angular UI-router ignores
let g:syntastic_html_tidy_ignore_errors += [
  \ " proprietary attribute \"ui-sref"]

"""""Syntastic javascript error highlighting config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""vim-airline customization
"Theme
let g:airline_theme='solarized'
"Show the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
"Use powerline fonts with airline
let g:airline_powerline_fonts = 1

"So vim handles powerline/airline fonts correctly
set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly

"""Vim Fugitive customization
nmap <leader>a :Gwrite<CR>

"""Tagbar customization
"nmap  <leader>t :TagbarToggle<CR>

"""ctrlp customization
"ctrlp search on word under cursor
nmap <leader>gf :CtrlP<CR><C-\>w

""""tern for vim customization
nmap <leader>td :TernDef<CR>
nmap <leader>tpd :TernDefPreview<CR>
nmap <leader>tsd :TernDefSplit<CR>
nmap <leader>ttd :TernDefTab<CR>
nmap <leader>tD :TernDoc<CR>
nmap <leader>tt :TernType<CR>
nmap <leader>tr :TernRefs<CR>
nmap <leader>tR :TernRename<CR>

"""Nerdtree customization
"Open Nerdtree on startup and new buffer
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
"Go to previous (last accessed) window. This will set cursor to file window on vim start and not nerdtree window
" autocmd VimEnter * wincmd p

"If Nerdtree is only buffer quit buffer (close application)
function! NERDTreeQuit()
  redir => buffersoutput
      silent buffers
        redir END
         "1BufNo  2Mods.     3File           4LineNo
         let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
         let windowfound = 0

         for bline in split(buffersoutput, "\n")
         let m = matchlist(bline, pattern)

          if (len(m) > 0)
            if (m[2] =~ '..a..')
              let windowfound = 1
            endif
          endif
        endfor

       if (!windowfound)
           quitall
       endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

"Toggle NERDTREETabsToggle open or closed - E for Explore!
nmap <leader>E :NERDTreeTabsToggle<cr>


"Matchit plugin for % tag matching on html tags
runtime macros/matchit.vim

"For syntastic and jshint, find a .jshintrc file
function s:find_jshintrc(dir)
  let l:found = globpath(a:dir, '.jshintrc')
  if filereadable(l:found)
    return l:found
  endif

  let l:parent = fnamemodify(a:dir, ':h')
  if l:parent != a:dir
    return s:find_jshintrc(l:parent)
  endif

  return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
  let l:dir = expand('%:p:h')
  let l:jshintrc = s:find_jshintrc(l:dir)
  "let g:syntastic_javascript_jshint_conf = l:jshintrc
  let g:syntastic_javascript_jshint_args = '--config /Users/adamcee/.jshintrc'
endfunction

au BufEnter * call UpdateJsHintConf()



set number
