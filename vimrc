" .vimrc
" Author: Andrew Simms <andrew@andrewdsimms.com>
" Vundle --------------------------------------- {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'sjl/gundo.vim'
Plugin 'SirVer/ultisnips'
Plugin 'tmhedberg/SimpylFold'
Plugin 'rking/ag.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'calendar.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'oblitum/rainbow'
Plugin 'godlygeek/tabular'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-markdown'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rkitover/vimpager'
Plugin 'tpope/vim-speeddating'
" Plugin 'shougo/neocomplete.vim'
" Plugin 'troydm/easybuffer.vim'
Plugin 'jmcantrell/vim-journal'
Plugin 'ervandew/supertab'
Plugin 'wting/rust.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-expand-region'
call vundle#end()
filetype plugin indent on

" }}}
" Basic Options {{{

set encoding=utf-8
set modelines=0
set textwidth=0
set wrap
set autoindent
set cindent
set hidden
"Turn on status line
set laststatus=2
"Allow backspacing over everything in insert mode
set backspace=indent,eol,start
"Store lots of :cmdline history
set history=1000
"Show incomplete cmds down the bottom
set showcmd
"Show current mode down the bottom
set showmode
"Show line numbers
set number
"Display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,extends:,precedes:
set linebreak
" Configuring backup and related
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
" Make directory folders
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
"Autocomplete matches
set wildmenu
"Faster Macros
set lazyredraw
"Break Indent 'Woo!'
set breakindent
" let &showbreak='  ▶'
set breakindentopt=shift:4,sbr
" Turn off parentheses matching, its driving me crazy
let loaded_matchparen = 1
" Toggle from relative numbering to regular numbering in normal/insert
set rnu
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu
" Fixing Delays?
" set ttimeoutlen=10
" set timeoutlen=300
" Better tab completion?
set wildmode=longest,list,full
set wildmenu
" Ignore directories
set wildignore+=*/.git/*,*/.sass-cache/*,*/lib/*,*/migrations/*
" Ignore files
set wildignore+=*.pyc,*.jpg,*.png,*.log,*.o,*.so,*.gif
" Spelling
set dictionary=/usr/share/dict/words
set spelllang=en_us
" Use zsh if available
if system("which zsh")
    set shell=`echo system("which zsh")`
endif
" Make test-name and test_name auto completable
set iskeyword+=\-,\_
" Don't highlight really long lines
set synmaxcol=500
" Window titles for tmux
function! TruncateFilename(max_len)
    let filename=expand("%:t")
    if len(filename) <= a:max_len
        return filename
    else
        let filename_len=len(filename)
        let half = a:max_len / 2
        return filename[0:half-1] . "…" . filename[filename_len-(half):filename_len-1]
endfunction
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window " . TruncateFilename(8))

" Color scheme -------------------------------------------------- {{{

syntax on
colorscheme pychimp
" Highlight current line
set cursorline

" }}}
" Tabs and Spaces -------------------------------------------------- {{{

"Use spaces instead of tabs
set expandtab
"Be smart when using tabs
set smarttab
"1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" }}}

" }}}
" Abbreviations {{{
" }}}
" Dvorak -------------------------------------------------- {{{

noremap h gj
noremap t gk
noremap d <Left>
noremap n <Right>

" j is now jump, swapping with t
noremap j t
" k is now kill swapping with d
noremap k d
" l is now look up next swapping with n
noremap l n
nnoremap K dd
"easier navigation of finds
nmap - :

" }}}
" Convience Mappings ------------------------------------------------- {{{

"<Ctrl-l> redraws the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Set insert mode timeout, returns to normal mode after 15 seconds
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore
"Remap command mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
"Changing number incrementing
nnoremap <C-j> <C-a>
nnoremap <C-k> <C-x>
"Split file vertically <leader>vs
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
"Quicker Commands
nnoremap ; :
vmap ; :
nnoremap : ;
" Insert multiple lines (o stays in normal mode and works with a count)
nnoremap o o<Esc>S
nnoremap O @='O<C-V><Esc>'<CR>S
" Quicker Movement
nnoremap D ^
nnoremap N g_
nnoremap H %
nnoremap T {
vnoremap D ^
vnoremap N g_
vnoremap H %
vnoremap T {
" Easier tabbing of selections
vnoremap < <gv
vnoremap > >gv
" Faster repeat command
nnoremap <C-P> :<C-P><CR>
"Quickfix mappings
autocmd BufReadPost quickfix nnoremap <buffer> <C-N> <Down>
autocmd BufReadPost quickfix nnoremap <buffer> <C-T> <Up>
" Get to the shell faster
nnoremap S :!<Space>
" Make <C-P> behave like it should and also zsh like
cnoremap <C-P> <Up>
cnoremap <C-T> <Up>
" Easier uppercase
imap <C-u> <ESC>mzgUiw`zi<C-f>
" Faster window switching
nnoremap ss <C-w><C-w>
nnoremap sh <C-w><Down>
nnoremap st <C-w><Up>
nnoremap sd <C-w><Left>
nnoremap sn <C-w><Right>
nnoremap sq <C-w>q
" Remap man command
nnoremap M K
" Faster tab in insert mode.
imap <C-t> <tab>
" I always use A and never use a, so why not save a motion
nnoremap a A
" Zipping
" Zip current char to the last char
nmap ze xNp
" Easier system copy and paste
vmap <Leader>y "+y
vmap <Leader>k "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Make y jump to the end of the selection
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" nnoremap <silent> y y`]

" Leader Mappings -------------------------------------------------- {{{

" Map leader key to space
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
" <Space> w to save a file
nnoremap <Leader>w :w<CR>
" <Space> t to switch tabs
nnoremap <Leader>t gt
"<Space> s to source VIMRC
nnoremap <Leader>s :so ~/.vimrc<CR>
"Easy buffer switching
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>d :bd<CR>
" Substitute like * (\< and \> select only that word)
nnoremap <Leader>; :%s:\<<C-R><C-W>\>:
" Spell Checking (Change cursorline to underline to retain highlights)
function! ToggleSpellCheck()
    if (&spell == 0)
        setlocal spell
        hi Cursorline ctermfg=NONE ctermbg=NONE cterm=underline
        setlocal complete+=kspell
        echo "Spell Check On!"
    else
        setlocal nospell
        hi Cursorline ctermfg=NONE ctermbg=8 cterm=NONE
        setlocal complete-=kspell
        echo "Spell Check Off!"
    endif
endfunction
nnoremap <Leader>sc :call ToggleSpellCheck()<CR>
" Spelling suggestions
nnoremap <Leader>ss z=
" Navigate misspelled words
" Next misspelled word
function! NextMisspelledWord()
    normal ]s
    normal zo
    call repeat#set("\ sn")
endfunction
nnoremap <Leader>sn :call NextMisspelledWord()<CR>
" Previous misspelled word
function! PreviousMisspelledWord()
    normal [s
    normal zo
    call repeat#set("\ sp")
endfunction
nnoremap <Leader>sp :call PreviousMisspelledWord()<CR>

" }}}
" Emacs Insert Mode -------------------------------------------------- {{{

imap <C-e> <End>
" Go forward in insert mode
imap <C-f> <Right>
" Go back in insert mode
imap <C-b> <Left>

" }}}

" }}}
" Cool Functions -------------------------------------------------- {{{

"Make sure vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Change cursor shape for different modes
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" }}}
" Searching and Movement {{{

"Find the next match as we type the search
set incsearch
"Highlight searches by default
set hlsearch
set smartcase
set ignorecase
set showmatch
set gdefault
set infercase

" }}}
" Quick Editing  ------------------------------------------------- {{{

nnoremap <Leader>ev :e ~/.vim/vimrc<CR>
nnoremap <Leader>ez :e ~/.zshrc<CR>
nnoremap <Leader>ea :e ~/.aliases.zsh<CR>
nnoremap <Leader>ec :e ~/Desktop/Programming/vim/vim_cheatsheet.md<CR>

" }}}
" Folding {{{
set foldenable
set foldlevelstart=0
set foldmethod=marker
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
" Easier Folding
nnoremap <Leader><Space> za
nnoremap <Leader>z zM
" Jump to top level fold and fold it
nnoremap zz 10[zzc
" Give me back zz functionality
nnoremap z. zz

nmap <Leader>f o<Esc>50i-<Esc>A<Space>{{{<CR>}}}<Esc>gcc2t0gcchkktf<Space>i<Space><Esc>ni
" NeatFoldText -------------------------------------------------- {{{

function! NeatFoldText()
  " let line = ' ' . substitute(getline(v:foldstart), '^\s#*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let line = substitute(getline(v:foldstart), '{{' . '{', '', 'g') . ' '
  let commentless_line = ' ' . substitute(line, '//\|#\|/\*\|\*/\|"\|-', '', 'g')
  let markdown_line = line
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = ' ' . printf("%s", lines_count . ' lines') . ' '
  let foldchar = "─"
  if (&ft=='markdown')
      let foldtextstart = strpart(markdown_line, 0, (winwidth(0)*2)/3)
  else
      let foldtextstart = strpart(commentless_line, 0, (winwidth(0)*2)/3)
  endif
  let foldtextend = lines_count_text
  let foldtextlength = strlen(substitute(foldtextstart, '.', 'x', 'g')) + &foldcolumn
  let foldtextstartlength = strlen(substitute(foldtextstart, '.', 'x', 'g')) + strlen(foldtextend) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength - 17) . foldtextend . "      "
endfunction
set foldtext=NeatFoldText()

" }}}

" }}}
" Filetype Specific -------------------------------------------------- {{{

" C -------------------------------------------------- {{{

function! CompileC(position)
    :w
    let filename = expand("%:r")
    if(a:position == "i")
        " Could not find a way to save the output when scanf is involved
        call repeat#set("ci")
        execute ":! make f=" . filename
        return
    endif
    let outputwin = bufwinnr("output")
    if (outputwin >= 0)
        execute ":bd output"
    endif
    if (a:position == "v")
        :vs output
        call repeat#set("cv")
    else
        :10sp output
        call repeat#set("cc")
    endif
    :winc r
    :%d
    execute ":r! make f=" . filename
    normal ggK
    :w
endfunction

augroup ft_c
    autocmd!
    au FileType c setlocal foldmethod=syntax
    au FileType c setlocal commentstring=//\ %s
    au FileType c syn match Function /\w\+(/me=e-1
    au FileType c setlocal makeprg=make\ f=%:r
    au FileType c nnoremap <buffer> cc :call CompileC("b")<CR>
    au FileType c nnoremap <buffer> cv :call CompileC("v")<CR>
    au FileType c nnoremap <buffer> ci :call CompileC("i")<CR>
augroup END

" }}}
" C++ -------------------------------------------------- {{{

au FileType cpp syn match Special /*\s\|+\s\|-\s\|\/\s\|%\s/
au FileType cpp syn match Operator /=/
au FileType cpp syn match Todo /==/
au FileType cpp syn match Exception />\|</
au FileType cpp setlocal commentstring=//\ %s

" }}}
" Git -------------------------------------------------- {{{

au FileType gitcommit setlocal spell

" }}}
" Html -------------------------------------------------- {{{

augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au FileType xhtml setlocal filetype=htmldjango
    au FileType htmldjango IndentGuidesEnable

    " Django tags
    au FileType htmldjango inoremap <buffer> <C-T> {%<Space><Space>%}<Left><Left><Left>

    " Django variables
    au FileType htmldjango inoremap <buffer> <C-V> {{<Space><Space>}}<Left><Left><Left>

    " Two space indenting for max screen real estate usage
    au Filetype htmldjango setlocal ts=2 sw=2 expandtab

    " Set comments
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    if &foldmethod != "indent"
        au FileType htmldjango setlocal foldmethod=indent
    endif

augroup END

" }}}
" Man -------------------------------------------------- {{{

au Filetype man nnoremap h <Down>
au Filetype man nnoremap t <Up>
au Filetype man nnoremap <C-D> <PageDown>
au Filetype man nnoremap <C-U> <PageUp>

" }}}
" Markdown -------------------------------------------------- {{{

function! CompileMD()
    execute ":! md2pdf " . expand("%:r")
endfunction

augroup ft_md
    autocmd!
    " Forcing vim to read .md as markdown and not as 'modula2' or whatever
    au BufNewFile,BufReadPost *.md set filetype=markdown
    " Folding for markdown
    au Filetype markdown set foldcolumn=4
    au Filetype markdown set breakat-=\*
    au Filetype markdown nnoremap <buffer> cc :call CompileMD()<CR>
augroup END

let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'html', 'css']

" }}}
" Org -------------------------------------------------- {{{

function! OrgDayFilename()
    silent !org -day
    redraw!
    return "/Users/macuser/org/days/" . strftime("%Y-%m-%d") . ".org"
endfunction
function! OrgWeekFilename()
    silent !org -week
    redraw!
    return "/Users/macuser/org/weeks/" . strftime("%Y-%W") . ".org"
endfunction
function! OrgAgenda()
    " silent !echo Hello, world.
    " redraw!
    execute ":e " . OrgWeekFilename()
    execute ":sp " . OrgDayFilename()
endfunction
function! OrgQuit()
    execute ":w"
    execute ":bd"
    execute ":w"
    execute ":bd"
endfunction
function! OrgTimestamp()
    let line=getline('.')

    let org_states = ["* ", "* TODO ","* UNDERWAY ", "* DONE "]

    " Testing for org state
    for test_state in range(3, 0, -1)
        if match(line, org_states[test_state]) != -1
            let current_org_state = test_state
            break
        else
            let current_org_state = 1000
        endif
    endfor

    " substituting current org state for next org state
    if current_org_state < 1000
        let org_state_substituted_line = substitute(line, org_states[current_org_state], org_states[(current_org_state + 1) % 4], "")
        let line = org_state_substituted_line
    endif

    " Handling insertion of timestamp
    let timestamp_regex = "\[.*"
    let timestamp = "[" . strftime("%b %d, %I:%M:%S %p") . "]"

    " if the timestamp exists, replace it with the current timestamp
    if match(line, timestamp_regex) != -1
        let new_time_stamp_line = substitute(line, "\[.*", timestamp, "")
        let line = new_time_stamp_line
    " or else append the timestamp
    else
        let line = line  . " " . timestamp
    endif

    call repeat#set("\<C-T>\<C-T>")
    call setline('.', line)
endfunction
function! OrgSort()
    normal zM
    normal gg
    execute ":/\*"
    normal VG
    " normal :SortUnfolded
    " execute ":normal gv :vi :SortUnfolded"
    " visual :SortUnfolded
    " visual ":'<,'>:SortUnfolded"
    " execute ":%s/%x00/\r"
endfunction
nnoremap <Leader>od :e `=OrgDayFilename()`<CR>
nnoremap <Leader>ow :e `=OrgWeekFilename()`<CR>
nnoremap <Leader>op :e ~/org/
nnoremap <Leader>oa :call OrgAgenda()<CR>
autocmd Filetype org nnoremap <Leader>oq :call OrgQuit()<CR>
autocmd Filetype org nnoremap <C-T><C-T> :silent call OrgTimestamp()<CR>
autocmd Filetype org nnoremap <Leader>os zMgg/\*VG:SortUnfolded:%s/\%x00/\rzM

" }}}
" Python -------------------------------------------------- {{{

let python_highlight_all = 1
au BufNewFile,BufRead *.py set keywordprg=pydoc

" }}}
" Ruby -------------------------------------------------- {{{

" 2 space tabs in ruby
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype eruby setlocal ts=3 sw=2 expandtab

" }}}

" }}}
" Plugin Settings -------------------------------------------------- {{{

" Ag -------------------------------------------------- {{{

nnoremap <Leader>/ :Ag<Space>

" }}}
" Ctrl P -------------------------------------------------- {{{

let g:ctrlp_map = 'go'
let g:ctrlp_cmd = 'CtrlP'
nnoremap gu :CtrlPBuffer<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_prompt_mappings = {'PrtSelectMove("k")': ['<c-t>'], 'ToggleByFName()':['<c-f>'], 'AcceptSelection("t")': ['<c-y>'], 'PrtCurLeft()': ['<left>'], 'PrtSelectMove("j")':['<c-n>'], 'PrtHistory(-1)': ['<c-l>'],}

" Make ctrlp super fast
let g:ctrlp_use_caching = 0
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

" }}}
" Fugitive --------------------------------------------------" {{{

" Fugitive custom mappings
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction
command! ToggleGStatus :call ToggleGStatus()
nnoremap <Leader>g :ToggleGStatus<CR>
nnoremap gs :ToggleGStatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>

" }}}
" Gundo -------------------------------------------------- {{{

nnoremap <Leader>u :GundoToggle<CR>

" }}}
" Jedi -------------------------------------------------- {{{

let g:jedi#completions_command = "<C-P>"
let g:jedi#goto_assignments_command = "<Leader>pg"
let g:jedi#goto_definitions_command = "<Leader>pg"
let g:jedi#documentation_command = "<Leader>pd"
let g:jedi#rename_command = "<Leader>pr"
let g:jedi#usages_command = "<Leader>pu"
let g:jedi#show_call_signatures = "1"

" }}}
" Kien Rainbow -------------------------------------------------- {{{

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['166',     'DarkOrchid3'],
    \ ['163',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au FileType cpp RainbowParenthesesToggle
au FileType cpp RainbowParenthesesLoadRound
au FileType cpp RainbowParenthesesLoadSquare
au FileType cpp RainbowParenthesesLoadBraces

" }}}
" Matchit -------------------------------------------------- {{{

runtime macros/matchit.vim

" }}}
" neocomplete -------------------------------------------------- {{{

" let g:neocomplete#enable_at_startup = 1
" imap <expr> - pumvisible() ? "\<Plug>(neocomplete_start_unite_quick_match)" : '-'

" }}}
" Oblitum Rainbow -------------------------------------------------- {{{

au FileType c,python,java,ruby,arduino call rainbow#load()
let g:rainbow_ctermfgs = [196, 129, 202, 126, 184, 14, 40]
nnoremap <Leader>r :RainbowToggle<CR>

" }}}
" Syntastic -------------------------------------------------- {{{

let g:syntastic_python_checkers = ['python']
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11"
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_full_redraws = 1
" let g:syntastic_auto_jump = 2         " Jump to syntax errors
let g:syntastic_auto_loc_list = 1     " Auto-open the error list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}
" Tabularize ------------------------------------------------ {{{

nnoremap <Leader>ap :Tabularize /\|<CR> | " Align Pipe
nnoremap <Leader>at :Tabularize /\|<CR> | " Align Table
nnoremap <Leader>aa :Tabularize /       | " Align Choice
nnoremap <Leader>av :Tab /\|\ "<CR>     | " Align Vim inline comment
vmap <Leader>ap :Tabularize /\|<CR>     | " Align Pipe
vmap <Leader>at :Tabularize /\|<CR>     | " Align Table
vmap <Leader>aa :Tabularize /           | " Align Choice
vmap <Leader>av :Tab /\|\ "<CR>         | " Align Vim inline comment
vmap <Leader>ae :Tab /=<CR>             | " Align equals

" }}}
" UltiSnips -------------------------------------------------- {{{

" UltiSnips Config
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsExpandTrigger="<C-S>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-S>"
" let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" }}}
" unite.vim -------------------------------------------------- {{{

" Move unite window to the bottom like ctrlp
" let g:unite_split_rule = "botright"
" let g:unite_winheight = 10
" Quick buffer switching
" nnoremap <Leader>b :Unite -quick-match buffer<CR>
" Better quick-match letters
" let g:unite_quick_match_table =
"       \ get(g:, 'unite_quick_match_table', {
"       \     'h' : 0, 'u' : 1, 't' : 2, 'e' : 3, 'n' : 4, 'o' : 5, 'a' : 6, 's' : 7, 'i' : 8, 'd' : 9,
"       \     'p' : 10, 'g' : 11, '.' : 12, 'c' : 13, 'y' : 14, 'f' : 15, 'b' : 16, 'k' : 17, 'm' : 18, 'j' : 19,
"       \     '1' : 20, '2' : 21, '3' : 22, '4' : 23, '5' : 24, '6' : 25, '7' : 26, '8' : 27, '9' : 28, '0' : 29,
"       \ })
" autocmd FileType unite call s:unite_settings()

" function! s:unite_settings()
    " imap <buffer> <C-t> <Plug>(unite_select_previous_line)
    " nmap <buffer> h <Down>
    " imap <buffer> <C-n> <Plug>(unite_select_next_line)
    " nmap <buffer> t <Up>
" endfunction

" }}}
" vim airline -------------------------------------------------- {{{

let g:airline_powerline_fonts=1
let g:airline_theme='relative'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#displayed_head_limit=7
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#eclim#enabled = 0
function! AirlineFilename()
    return "/" . TruncateFilename(24)
endfunction
let g:airline_section_c="%{AirlineFilename()}"

function! AirlineNull()
    return ""
endfunction
let g:airline_section_y="%{AirlineNull()}"

function! FileProgress()
    let current_line = str2nr(line("."))
    let total_lines = str2nr(line("$"))
    let percent_of_file = (current_line * 10 / total_lines)
    let actual_percent = (current_line * 100) / (total_lines * 1)
    let total_lines = 10
    let percent_left = 10 - percent_of_file
    let indicator = "█"
    let non_indicator = "░"
    let start_char = ""
    let end_char = ""
    let delim="-"
    return repeat(indicator, percent_of_file) . delim . actual_percent . "%" . delim . repeat(non_indicator, percent_left)
endfunction
let g:airline_section_z="%{FileProgress()}"

" }}}
" vim expand region -------------------------------------------------- {{{

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" }}}
" vim gitgutter -------------------------------------------------- {{{

function! JumpToHunkAndUnfold(keypress)
    if(a:keypress == "c")
        :GitGutterNextHunk
    endif

    if(a:keypress == "C")
        :GitGutterPrevHunk
    endif
    " Unfold just where the cursor is (supposed to be)
    normal zv
    " Move cursor to the middle of the screen
    normal z.
endfunction

nnoremap <Leader>c :call JumpToHunkAndUnfold('c')<CR>
nnoremap <Leader>C :call JumpToHunkAndUnfold('C')<CR>

" }}}
" vim go -------------------------------------------------- {{{

let g:go_disable_autoinstall = 1

" }}}
" vim indent guides -------------------------------------------------- {{{

let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=NONE
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=8

" }}}
" vim journal -------------------------------------------------- {{{

let g:journal_directory="~/.journal"
let g:journal_extension="md"

" }}}
" vim markdown folding ----------------------------------------------- {{{

let g:markdown_fold_style = 'nested'
let g:markdown_fold_override_foldtext = 0

" }}}
" vim org mode -------------------------------------------------- {{{

autocmd Filetype org setl noai nocin nosi inde=

" }}}
" vim-sneak -------------------------------------------------- {{{

nmap s <Plug>Sneak_s
nmap - <Plug>SneakNext
nmap _ <Plug>SneakPrevious
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap j <Plug>Sneak_t
nmap J <Plug>Sneak_T

" }}}

" }}}
" Fold Settings -------------------------------------------------- {{{
" vim:foldmethod=marker:foldlevel=0 }}}
