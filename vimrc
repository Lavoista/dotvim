" File: .vimrc
" Maintainer: Gavin Jaeger-Freeborn
"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"       ░   ░         ░      ░     ░ ░
"      ░                           ░

" Quick Init: {{{1 "

if has('nvim')
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
endif

" where to find python
let g:python_host_prog  = '/usr/bin/python2' "speed up python2 startup
let g:python3_host_prog = '/usr/bin/python3' "speed up python3 startup
" Disable extra plugins
let g:loaded_gzip            =  1
let g:loaded_tarPlugin       =  1
let g:loaded_zipPlugin       =  1
let g:loaded_2html_plugin    =  1
"dont use any remote plugins so no need to load them
let g:loaded_rrhelper        =  1
let g:loaded_remote_plugins  =  1
"prevent fzf form being unnecessary loaded if installed on system
let g:loaded_fzf = 1
" 1}}} "Quick Init

" Plugins: {{{1 "
" install vim-plug if it's not already
augroup PLUGGED
	if empty(glob('~/.vim/autoload/plug.vim'))  " vim
		silent !curl -fo ~/.vim/autoload/plug.vim --create-dirs
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
augroup end
call plug#begin('~/.vim/plugged')
" lsp {{{2
" using:
" vim & sh: efm-language-server
" c: ccls
" go: gopls (go-tools)
" java: jdtls (eclips.jdt.ls)
" javascript: typescript-language-server
" python: python-language-server
" 	autopep8
" 	yapf :guidline linting
" 	python-pylint :linting
" 	python-rope
" 	python-pydocstyle
" 	python-pyflakes :linting
if exists('*job_start') || exists('*jobstart')
	Plug 'natebosch/vim-lsc'
endif
" 2}}} "lsp

" Autocompletion {{{2 "
Plug 'valodim/vim-zsh-completion'
set completefunc=zsh_completion#Complete
if has('nvim')
	" floating preview window for neovim
	Plug 'ncm2/float-preview.nvim'
	let g:float_preview#docked = 0
else 
	"I find this super distracting
	set completeopt+=preview
	set completeopt+=popup
	" set completepopup=border:off
	" Plug 'chrisbra/colorizer', { 'on': 'ColorToggle' }
endif
" 2}}} "Autocompletion
" Snippets {{{2 "
if has('patch-7.4.775')
	Plug 'lifepillar/vim-mucomplete' "main source for completion
	Plug 'jonasw234/vim-mucomplete-minisnip'
endif
Plug 'tommcdo/vim-lion'
Plug 'joereynolds/vim-minisnip'
let g:name = 'Gavin Jaeger-Freeborn'
let g:email = 'gavinfreeborn@gmail.com'
let g:minisnip_trigger = '<C-f>'
let g:minisnip_dir = '~/.vim/extra/snip:' . join(split(glob('~/.vim/extra/snip/**/'), '\n'), ':')
imap <Nop> <Plug>(minisnip-complete)
" 2}}} "Snippets
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gpush', 'Gedit', 'Ggrep'] }
Plug 'mhinz/vim-signify'
" 2}}} "Git
" Writing {{{2 "
" Plug 'lervag/vimtex' " Latex support
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
let g:table_mode_map_prefix = '<Leader>T'
let g:table_mode_realign_map = '<Leader>TT'
set conceallevel=2
let g:tex_conceal='abdgm'
" 2}}} "Writing
" Org Mode {{{2 "
Plug 'dhruvasagar/vim-dotoo'
" 2}}} "Org Mode
" My Pluggins {{{2 "
Plug 'gavinok/spaceway.vim'
" 2}}} " My Plugins
" Tpope god bless the man {{{2 "
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
" 2}}} "Tpope
" vimscript {{{2 "
" Plug 'tpope/vim-scriptease'
Plug 'mhinz/vim-lookup'
Plug 'tweekmonster/helpful.vim'
" 2}}} "vimscript
" etc {{{2 "
Plug 'wellle/targets.vim'
" only seek on the same line
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll'
Plug 'othree/yajs.vim'
let g:colorizer_colornames_disable = 1
" color support
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
" 2}}} "etc.
call plug#end()

" Aesthetics: {{{2 "
colorscheme spaceway
set termguicolors
highlight Normal ctermbg=NONE
highlight Conceal ctermbg=NONE
hi Todo cterm=bold ctermfg=160 gui=bold

function! s:statusline_expr()
	let mod  = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
	let ft   = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
	let fug  = "%3*%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
	let job  = "%2*%{exists('g:job') ? '[Job Running!]' : ''}%*"
	let zoom = "%3*%{exists('t:maximize_hidden_save') ? '[Z]' : ''}%*"
	let sep  = ' %= '
	let pos  = ' %-14.(%l,%c%V%) '
	let pct  = ' %P'

	return '%<%f %<'.mod.fug.job.zoom.sep.pos.pct
endfunction
let &statusline = s:statusline_expr()
highlight User1 ctermbg=107  ctermfg=black
highlight User2 ctermbg=103  ctermfg=black
highlight User3 ctermbg=59   ctermfg=black
" 2}}} Aesthetics "
" 1}}} "Plugins

" General Mappings: {{{1
let g:mapleader="\\"
let maplocalleader = '|'
nmap <space> <leader>
vmap <space> <leader>

" shortcut to files and dirs uses shortcuts.sh
" it can be found at my scripts repo

nnoremap <leader>y :let @+ = expand("%:p")<cr>

if has('nvim')
	augroup TERMINAL
		autocmd!
		" autocmd BufWinEnter,WinEnter term://* startinsert
		autocmd BufLeave term://* stopinsert
		au TermOpen * setlocal nonumber
		au TermOpen * setlocal norelativenumber
	augroup end
	map <leader>ct :w! \| :split \| te cheat.sh <c-r>%
	tnoremap <leader>esc <C-\><C-N>
	nnoremap <leader><cr>  :split \| te<cr>i
	tnoremap <C-\>       <C-\><C-N>
	tnoremap <C-H>       <C-\><C-N><C-W><C-H>
	tnoremap <C-J>       <C-\><C-N><C-W><C-J>
	tnoremap <C-K>       <C-\><C-N><C-W><C-K>
	tnoremap <C-L>       <C-\><C-N><C-W><C-L>
	set noshowmode
	" tell neovim where runtime is
	let &packpath = &runtimepath
else
	set timeout           " for mappings
	set timeoutlen=1000   " default value
	set ttimeout          " for key codes
	set ttimeoutlen=10    " unnoticeable small value
	" set Vim-specific sequences for RGB colors allowing for gui colors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	runtime macro/matchit
endif
runtime vimshortcuts.vim
" delete a buffer
nnoremap <leader>bd :bdelete<CR>

" Open or compile file
map <silent><leader>co :!opout <c-r>%<CR><CR>
map <leader>cc :w! \| !compiler <c-r>%<CR>
" Write To File As Sudo
nnoremap <leader>sudo :w !sudo tee > /dev/null %

" POSIX Commands
nmap <leader>cp :!cp  <C-R>% ~/
nmap <leader>mv :!mv  <C-R>% ~/
nmap cd :cd <C-R>=expand('%:h')<CR>

" Toggle *conceallevel*
nnoremap <Leader>cl :let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>

" mark position before search
nnoremap / ms/

nnoremap <silent> <leader>/        :nohlsearch<CR>

" if this is a normal buffer use <CR> to toggle folding
nmap <expr> <CR> &buftype ==# '' ? 'za' : "\<CR>"

" Find References
if executable('ag')
	set grepprg=ag\ --vimgrep
endif

nnoremap <leader>G :Grep <C-R><C-W> .<CR>:copen<CR>

" change variable and repeat with .
nnoremap c*			*Ncgn
nnoremap <C-N>      yiW/<C-r>0<CR>Ncgn
xnoremap <C-N>      y/<C-r>0<CR>Ncgn
nnoremap <leader>n  yiw:%s/<C-r>0//gc<left><left><left>
xnoremap <leader>n  y:%s/<C-r>0//gc<left><left><left>

map ]a :cnext<CR>
map [a :cprevious<CR>
map ]A :lnext<CR>
map [A :lprevious<CR>

"quick buffer navigation
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" Find Files {{{2 "
nnoremap <leader>fT  :setfiletype<space>
nnoremap <leader>ff  :Root<CR>:edit **/*
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
nnoremap <leader>ft  :tjump<space>
nnoremap <leader>hg  :helpgrep .*.*<Left><Left>
nnoremap <leader>hh  :help<Space>

" bookmarked directories
nnoremap <leader>fp  :edit ~/Programming/**/**<Left>
nnoremap <leader>fh  :edit ~/**
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fw  :edit ~/Dropbox/DropsyncFiles/vimwiki/**/**

nnoremap <leader>fj  :ME<space>
command! -nargs=1 -complete=customlist,dotvim#MRUComplete ME call dotvim#MRU('edit', <f-args>)

let g:shortcuts = ['~/.scripts', '~/.config']
nnoremap <leader>fs  :Sc<space>
command! -nargs=1 -complete=customlist,dotvim#ShortcutComplete Sc call dotvim#Shortcut('edit', <f-args>)
" 2}}} "Find Files

" better navigation of command history
" allow next completion after / alternative 
" is <C-E> if <C-D> makes to long of a list
cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>
cnoremap <expr> <SPACE> dotvim#CSPACE()
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))

" better alternative to <C-W>_<C-W>\|
nnoremap <C-W>f		:silent call dotvim#ZoomToggle()<CR>
nnoremap <C-W><C-f>	:silent call dotvim#ZoomToggle()<CR>


"Better Mappings Imho
nnoremap Y  y$
xnoremap * "xy/<C-R>x<CR>

"i never use s so i may as well make it useful
function! Sort(type, ...)
	'[,']sort
endfunction
nmap <silent> s :set opfunc=Sort<CR>g@

" close preview if open when hitting escape
nnoremap <silent> <esc> :pclose<cr>

" copy all matches with the last seach
nmap ym :YankMatch<CR>
" delete matches
nmap dm :%s/<c-r>///g<CR>
" change matches
nmap cm :%s/<c-r>///g<Left><Left>

" Using Fugitive
nnoremap Q  :Gstatus<CR>

" Some Readline Keybindings When In Insertmode
inoremap <C-A> <C-O>^<C-g>u
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>
			\strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"

"For Proper Tabbing And Bracket Insertion"
inoremap {<CR> {<CR>}<c-o><s-o>
inoremap (<CR> (<CR>)<c-o><s-o>

" commandline mappings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>

" when rightclicking highlight copy it
xnoremap <RightMouse> "*y

" Toggle Quickfix
nnoremap <script> <silent> <leader>v :call dotvim#ToggleQuickfix()<CR>
" Quick format file
nnoremap gQ :<C-U>call dotvim#FormatFile()<CR>
" win resize
nnoremap <C-W>+ :call dotvim#RepeatResize('+')<CR>
nnoremap <C-W>- :call dotvim#RepeatResize('-')<CR>
nnoremap <C-W>< :call dotvim#RepeatResize('<')<CR>
nnoremap <C-W>> :call dotvim#RepeatResize('>')<CR>
" 1}}} "General

" Editing: {{{1 "
" use syntax for omnicomplete if none exists
augroup SyntaxComplete
	" this one is which you're most likely to use?
	autocmd Filetype *
				\	if &omnifunc == '' |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
augroup end
" Capital Quick first letter of a word or a regain
nnoremap + m[viwb<esc>gUl`[
nnoremap <leader>+ V:s/\<./\u&/g <BAR> nohlsearch<CR>
xnoremap + :s/\<./\u&/g <BAR> nohlsearch<CR>

"Insert Empty Line Above And Below
map <silent><leader>o  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
map <silent><leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>

" Quick spell correction shortcut
let g:quickdict='~/.vim/extra/dict/en_common.dict'
nnoremap <silent> <leader>ss :call dotvim#WordProcessor()<CR>
nmap <BS>     mz[s1z=`z

" Move a line of text 
xnoremap J :m'>+<cr>`<my`>mzgv`yo`z
xnoremap K :m'<-2<cr>`>my`<mzgv`yo`z
xnoremap < <gv
xnoremap > >gv
" 1}}} "Editing

" Plugin Configuration: {{{1 "
" Minimal Async Command {{{2
if exists('*job_start') || exists('*jobstart')
	command! -nargs=+ -complete=shellcmd Term call dotvim#TermCmd(<f-args>)
	command! -nargs=+ -complete=shellcmd Do call dotvim#Do(<f-args>)
	" dispatch compatability
	command! -bang -nargs=+ -complete=shellcmd Dispatch call dotvim#Do(<f-args>)
	command! -bang -nargs=+ -complete=file_in_path Grep call dotvim#Do(&grepprg,<f-args>)
	command! -bang -nargs=* -complete=file Make call dotvim#Do(&makeprg,<f-args>)
	nnoremap  '<CR>     :Term<Up><CR>
	nnoremap  '<Space>  :Term<Space>
	nnoremap  '<TAB>    :Term<Up>
	nnoremap  `<CR>     :Do<Up><CR>
	nnoremap  `<Space>  :Do<Space>
	nnoremap  `<TAB>    :Do<Up>
	nnoremap  m<CR>     :Make<CR>
	nnoremap  m<Space>  :Make<Space>
	nnoremap  m!		:setlocal makeprg=compiler\ %<CR>
	nnoremap  m?		:echo &makeprg<CR>
	nnoremap <leader>mm :call dotvim#ToggleAutocompile()<CR>
	"async tagging
	nnoremap <leader>t  :call dotvim#Quicktag(0)<CR>
else
	nnoremap  `<TAB>    :!<Up>
	nnoremap  `<Space>  :!
	nnoremap  m!        :make!<Space>
	nnoremap  m<CR>		:make!<CR>
endif
" 2}}} "Minimal Async Command
" netrw {{{2
" Poor mans Vim vinegar
let g:netrw_browsex_viewer='setsid xdg-open' "force gx to use xdg-open
let g:netrw_bufsettings = 'noswf noma nomod nowrap ro nobl'
let g:netrw_sort_options = 'i'
let g:netrw_banner=0 "disable banner
let g:netrw_fastbrowse=0
let g:netrw_localrmdir='rm -r'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" move up a directory and focus on the file
nmap - :call dotvim#Opendir('edit')<CR>

augroup netrw_mapping
	autocmd!
	autocmd Filetype netrw call dotvim#NetrwMapping()
	autocmd FileType netrw setl bufhidden=wipe
augroup end
" 2}}} "netrw
" Orgmode {{{2 "
map <silent>gO :e ~/Documents/org/mylife.org<CR>
command! -nargs=1 NGrep grep "<args>" ~/Dropbox/Documents/org/**/*.org
command! -nargs=1 WikiGrep grep "<args>" ~/Dropbox/DropsyncFiles/vimwiki/**/*.md
" 2}}} "Orgmode
" LSC {{{2 "
if exists('*job_start') || exists('*jobstart')
	let g:mucomplete#completion_delay = 200
	let g:mucomplete#reopen_immediately = 0
	nmap <leader>V :LSClientAllDiagnostics<CR>
	let g:lsc_enable_autocomplete = v:false
	let g:lsc_auto_map = {
				\ 'GoToDefinition': 'gd',
				\ 'GoToDefinitionSplit': ['<C-W>d', '<C-W><C-D>'],
				\ 'FindReferences': 'gr',
				\ 'NextReference': '<leader>*',
				\ 'PreviousReference': '<leader>#',
				\ 'FindImplementations': 'gI',
				\ 'FindCodeActions': 'ga',
				\ 'Rename': 'gR',
				\ 'ShowHover': v:true,
				\ 'DocumentSymbol': 'go',
				\ 'WorkspaceSymbol': 'gz',
				\ 'SignatureHelp': 'gm',
				\ 'Completion': 'omnifunc',
				\}
endif
" 2}}} LSC
" Mucomplete {{{2 "
let g:mucomplete#user_mappings = {
			\'mini': "\<C-r>=MUcompleteMinisnip#complete()\<CR>",
			\ }
set completeopt+=menuone
"-----------
if has('patch-7.4.775')
	" Tab complete dont accept until told to
	set completeopt+=noselect
	let g:mucomplete#enable_auto_at_startup = 1
	"----------- completion chains
	set complete-=i
	set complete-=t
	" remove beeps during completion
	set belloff=all

	let g:mucomplete#wordlist = {
				\       '': ['gavinfreeborn@gmail.com', 'Gavin', 'Jaeger-Freeborn'],
				\ }

	let g:mucomplete#chains = {}
	let g:mucomplete#chains['default']   =  ['mini',  'list',  'omni',  'path',  'c-n',   'uspl']
	let g:mucomplete#chains['html']      =  ['mini',  'omni',  'path',  'c-n',   'uspl']  
	let g:mucomplete#chains['vim']       =  ['mini',  'list',  'cmd',   'path',  'keyp']
	let g:mucomplete#chains['tex']       =  ['mini',  'path',  'omni',  'uspl',  'dict',  'c-n']
	let g:mucomplete#chains['sh']        =  ['mini',  'file',  'dict',  'keyp']  
	let g:mucomplete#chains['zsh']       =  ['mini',  'file',  'dict',  'keyp']  
	let g:mucomplete#chains['java']      =  ['mini',  'tags',  'keyp',  'omni',  'c-n']   
	let g:mucomplete#chains['c']         =  ['mini',  'list',  'omni',  'c-p']            
	let g:mucomplete#chains['go']        =  ['mini',  'list',  'omni',  'c-p']            
	let g:mucomplete#chains['markdown']  =  ['mini',  'path',  'c-n',   'uspl',  'dict']  
	let g:mucomplete#chains['dotoo']     =  g:mucomplete#chains['markdown']
	let g:mucomplete#chains['mail']      =  g:mucomplete#chains['markdown']
	let g:mucomplete#chains['groff']     =  g:mucomplete#chains['markdown']
	let g:mucomplete#chains['nroff']     =  g:mucomplete#chains['markdown']

	if !exists('g:mucomplete#can_complete')
		let s:c_cond = { t -> t =~# '\%(->\|\.\)$' }
		let s:latex_cond= { t -> t =~# '\%(\\\)$' }
		let g:mucomplete#can_complete = {}
		let g:mucomplete#can_complete['c']         =  {  'omni':  s:c_cond              }
		let g:mucomplete#can_complete['go']        =  {  'omni':  s:c_cond              }
		let g:mucomplete#can_complete['python']    =  {  'omni':  s:c_cond              }
		let g:mucomplete#can_complete['dotoo']     =  {  'dict':  s:latex_cond          }
		let g:mucomplete#can_complete['markdown']  =  {  'dict':  s:latex_cond          }
		let g:mucomplete#can_complete['org']       =  {  'dict':  s:latex_cond          }
		let g:mucomplete#can_complete['tex']       =  {  'omni':  s:latex_cond          }
		let g:mucomplete#can_complete['html']      =  {  'omni':  {t->t=~#'\%(<\/\)$'}  }
		let g:mucomplete#can_complete['vim']       =  {  'cmd':   {t->t=~#'\S$'}        }
	endif
	let g:mucomplete#no_popup_mappings = 0
	"spelling
	let g:mucomplete#spel#good_words = 1
endif
" 2}}} "Mucomplete
" TableMode {{{2 "
function! s:isAtStartOfLine(mapping)
	let text_before_cursor = getline('.')[0 : col('.')-1]
	let mapping_pattern = '\V' . escape(a:mapping, '\')
	let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
	return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
			\ <SID>isAtStartOfLine('\|\|') ?
			\ '<c-o>:TableModeEnable<cr><bar>' : '<bar><bar>'
" 2}}} "TableMode
" Signify {{{2 "
nnoremap <leader>hp :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>
command! Diff :SignifyDiff
" 2}}} "Signify
" 1}}} "Plugin Configuration

" Functions And Commands: {{{1 "
" termdebug {{{2
nmap gD <Plug>DumpDebugStringVar
nmap gL <Plug>DumpDebugStringVar
command! -nargs=0 Debug :packadd termdebug<CR>:Termdebug
nnoremap <leader>bb :Break<CR>
nnoremap <leader>b] :Step<CR>
nnoremap <leader>b} :Over<CR>
nnoremap <leader>bp :call TermDebugSendCommand('print' . expand(<cword>) )<CR>
" 2}}} "termdebug


" CustomSections {{{2 "
function! CustomSections(dir, regex)
	if a:dir ==# 'up'
		call search(a:regex,'bW')
	else
		call search(a:regex,'W')
	endif
endfunction
" 2}}} "CustomSections
" White space {{{2
" Highlight whitespace problems.
nnoremap <Leader>ws :call ToggleShowWhitespace()<CR>
function! ToggleShowWhitespace()
	if !exists('b:showws')
		let b:showws = 1
	endif
	let pat = '^\t*\zs \+\|\s\+$\| \+\ze\t\|[^\t]\zs\t\+'
	if !b:showws
		syntax clear ExtraWhitespace
		let b:showws = 1
	else
		exec 'syntax match ExtraWhitespace "'.pat.'" containedin=ALL'
		exec 'normal! /' . pat
		let b:showws = 0
	endif
endfunction

" Highlight trailing whitespace characters
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" remove trailing whitespaces
command! StripWhitespace :%s/\s\+$//e
" 2}}} "White Space
" Websearch {{{2 
nmap <silent> gs :set opfunc=dotvim#WebSearch<CR>g@
xmap <silent> gs :<C-u>call dotvim#WebSearch(visualmode(), 1)<Cr>
" 2}}} "Websearch
" VisualSort {{{2 
" sort based on visual block
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call dotvim#VisSort(<bang>0)
" use s to sort visual selection
xmap s :SortVis<CR>
" 2}}} "VisualSort
" Extra commands {{{2 
" Minimal Gist this is actually IX but i always think its XI
command! -range=% XI  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | xsel -i"
" Yank all matches in last search
command! -register YankMatch call dotvim#YankMatches(<q-reg>)
command! -nargs=0 MW call dotvim#MkdirWrite()
command! -nargs=0 Todo call dotvim#Todo('~/Documents/org')
" 2}}} "Extra commands
" 1}}} "Functions and Commands

" General Settings: {{{1 "
filetype plugin indent on
set encoding=utf-8                                  " allow emojis in vimrc
scriptencoding utf-8                                " allow emojis in vimrc
if has('virtualedit')
	set virtualedit=block                           " virtual block can go anywhere
endif

if has('gui_running')
	call dotvim#LoadGui()
else
	hi Normal      guibg=NONE
	hi ColorColumn guibg=NONE
	hi SignColumn  guibg=NONE
	hi Folded      guibg=NONE
endif

set mouse=a                                         "Add mouse control not that I use them very much
set clipboard^=unnamed,unnamedplus	                "xclip support
set tags+=.tags;	                                "make tagefiles hidden
set tags+=./.tags;../.tags                          "extra directories
set title                                           "Update window title
set hidden                                          "Allow to leave buffer without saving
set showcmd                                         "Show keys pressed in normal
set autochdir                                       "Auto cd
set tabstop=4                                       "Shorter hard tabs
set softtabstop=0                                   "no spaces
set smarttab
set shiftwidth=4                                    "Shorter shiftwidth
set autoindent                                      "Auto indent newline
set ruler                                           "Show line number and column
set scrolljump=-15                                  "Jump 15 when moving cursor bellow screen
set undofile                                        "Undo function after reopening

" check that directories exist
if !isdirectory(expand('~/.cache/vim'))
	call mkdir($HOME.'/.cache/vim/undo', 'p')
	call mkdir($HOME.'/.cache/vim/backup', 'p')
endif
set undodir=$HOME/.cache/vim/undo
set backupdir=$HOME/.cache/vim/backup
" set autowrite
" set autoread           "read/file when switching buffers
set lazyredraw                                      "redraw only when needed faster macros
set shortmess=aAtcT                                 "get rid of annoying messagesc
set incsearch         smartcase ignorecase hlsearch "better search
set backspace=2                                     "backspace through anything
set foldmethod=syntax                               "Enable folding
set foldlevel=99                                    "start with all folds open
set path+=**/*                                      "Autocompletion of path
set wildmenu                                        "Autocompletion of commands
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.tags,tags,*.o,*.class
set laststatus=2                                    "hide status bar for nvim
set splitbelow splitright

" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
if exists('##CmdLineEnter')
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif
" 1}}}                   "General Settings

" FileType Specific Stuff: {{{1 "
augroup GITCOMMITS
	" spelling for gitcommits
	autocmd!
	autocmd FileType gitcommit silent call dotvim#WordProcessor()
	autocmd FileType gitcommit startinsert
augroup end
augroup AUTOEXEC
	autocmd!
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts.sh
	" Run xrdb whenever Xresources are updated.
	autocmd BufWritePost *Xresources !xrdb ~/.Xresources
augroup end

augroup VIM
	autocmd!
	" used by 
	autocmd BufRead *.vimrc nnoremap <buffer><silent> gx yi':!<C-R>=dotvim#Open()<CR> https://github.com/<C-r>0<CR>
augroup END

augroup WRIGHTING
	autocmd!
	autocmd FileType pandoc nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>
	autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'))
	autocmd FileType dotoo,org nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'))
	autocmd BufRead,BufNewFile *.md,*.tex,*.wiki call dotvim#WordProcessor()
	autocmd FileType markdown,pandoc,dotoo,org execute 'setlocal dictionary+=~/.vim/extra/dict/latex_comp.txt'
augroup END

" 1 }}}" FileType Specific Stuff

" Abbreviations: {{{1 "
" Command Alias:  {{{2
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias('W','w')
call SetupCommandAlias("w'",'w')
call SetupCommandAlias('Wq','wq')
call SetupCommandAlias('Q','q')
call SetupCommandAlias('man','Man')
" 2}}} Command Alias

" quickly print the date
iab <expr> dts strftime("%c")
"add a comment in any language
" iab com <C-R>=&commentstring<CR><esc>F%c2w

" spelling
iab pyhton python
iab hte the
" 1}}} "Abbreviations

" Etc {{{1 "
" Diffs: {{{2 "
if has('patch-8.0.0283')
	set diffopt=vertical,filler,context:3,
				\indent-heuristic,algorithm:patience,internal
endif
" 2}}} "Diffs
if filereadable(expand('~/.config/vimlocal'))
	source ~/.config/vimlocal
endif
"}}} Etc "
" vim:foldmethod=marker:foldlevel=0
