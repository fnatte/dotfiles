" Plugins to install:
" * vim-commaobject
" * tomtom/tcomment_vim
" * weierophinney/argumentrewrap

" Auto reload vim config
autocmd! BufWritePost *.vim source $MYVIMRC

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

call plug#begin()

" General
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/denite.nvim'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/vis'
Plug 'reedes/vim-pencil'
Plug 'romainl/vim-qf'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'emlow/vim-spellbuild'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

" Look
Plug 'junegunn/seoul256.vim'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine' " Show vertical line for tabs

" Language
Plug 'lervag/vimtex'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'm2mdas/phpcomplete-extended'
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'vim-scripts/MSIL-Assembly'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-highlight'
Plug 'tpope/vim-salve'
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim'
Plug 'hail2u/vim-css3-syntax'

" For vim only
if !has('nvim')
Plug 'tpope/vim-sensible'
endif

call plug#end()

colo seoul256
let mapleader = ','
let maplocalleader = "\\"
set noerrorbells
set list lcs=tab:\¦\
set tabstop=4 shiftwidth=4
set number

if !has('nvim')
	set encoding=utf-8
endif

" Map capital wq letters to lower, cuz of typos
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Highlight current line in current buffer
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Highlight matching braces etc.
set showmatch
set matchtime=1
set matchpairs+=<:>

" Show more lines when scrolling
set scrolloff=3

" Fix slow syntax highlighting for long lines
set synmaxcol=180

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Bash-like auto complete
set wildmode=longest:full,full

" Nerd tree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '◀'
let g:NERDTreeIgnore = ['\.aug$', '\.fdb_latexmk$', '\.fls$', '\.aux$', '\.cb$',
			\ '\.bib$', '\.bbl$', '\.bcf$', '\.blg$', '\.out$', '\.pdf$',
			\ '\.lof$', '\.toc$', '\.synctex\.gz$', '\.run\.xml$', '\~$']

" Airline
let g:airline_powerline_fonts = 1

" Fix for indentLine to prevent concealing fuckup
let g:indentLine_concealcursor=""

" PHP
let g:phpcomplete_index_composer_command = 'composer'
let g:php_cs_fixer_config_file = '.php_cs'

" Auto completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._=['omni', 'buffer', 'member', 'tag', 'file']
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.php = [
		\'[^. \t0-9]\.\w*',
		\'[^. \t0-9]\->\w*',
		\'[^. \t0-9]\::\w*',
		\]
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP

" Denite
call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Navigate with jk in insert
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <c-p> :Denite file_rec<CR>
nnoremap <Leader>g :Denite grep<CR>

" Go
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)

" Javascript
let g:javascript_plugin_jsdoc = 1
au FileType javascript nnoremap <silent> <buffer> <C-]> :TernDef<CR>

" Javascript/Typescript
au FileType typescript,javascript set backupcopy=yes

" Ack/ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Do not conceal JSON
let g:vim_json_syntax_conceal = 0

" Latex
if has('macunix')
	let g:vimtex_quickfix_mode = 0 "quickfix window not opened automatically
	" let g:vimtex_view_method = 'skim'
	let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
	let g:vimtex_view_general_options = '-r @line @pdf @tex'
	let g:vimtex_compiler_progname = 'nvr'
	let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
	let g:tex_flavor = 'latex'
	function! UpdateSkim(status)
		if !a:status | return | endif

		let l:out = b:vimtex.out()
		let l:tex = expand('%:p')
		let l:cmd = [g:vimtex_view_general_viewer, '-r']
		if !empty(system('pgrep Skim'))
			call extend(l:cmd, ['-g'])
		endif
		if has('nvim')
			call jobstart(l:cmd + [line('.'), l:out, l:tex])
		elseif has('job')
			call job_start(l:cmd + [line('.'), l:out, l:tex])
		else
			call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
		endif
	endfunction
else
	let g:vimtex_view_method = 'zathura'
endif


function! s:goyo_enter()
	set noshowcmd
	set noshowmode
	set scrolloff=999
	set nocursorline
	Limelight
endfunction

function! s:goyo_leave()
	set showcmd
	set showmode
	set scrolloff=3
	set cursorline
	Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

