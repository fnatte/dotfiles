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
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/denite.nvim'
Plug 'chemzqm/unite-location'
Plug 'Shougo/echodoc.vim'
Plug 'vim-scripts/vis'
Plug 'romainl/vim-qf'
Plug 'jamessan/vim-gnupg'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'prettier/vim-prettier'
Plug 'wellle/targets.vim'
Plug 'gyim/vim-boxdraw'

" File Explorer
if has('nvim')
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'kristijanhusak/defx-icons'
else
	Plug 'scrooloose/nerdtree'
endif

" Writing
Plug 'ron89/thesaurus_query.vim'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'

" Look
Plug 'junegunn/seoul256.vim'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine' " Show vertical line for tabs

" Language
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }
Plug 'lervag/vimtex'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'StanAngeloff/php.vim'
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
Plug 'hail2u/vim-css3-syntax'
Plug 'jxnblk/vim-mdx-js'
Plug 'kergoth/vim-bitbake'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'dag/vim-fish'


" For vim only
if !has('nvim')
Plug 'tpope/vim-sensible'
endif

" Load icons plugin as last one
Plug 'ryanoasis/vim-devicons'

call plug#end()


colo seoul256
let mapleader = ','
let maplocalleader = "\\"
set noerrorbells
set list lcs=tab:¦\ " Comment to prevent removal of last space
set tabstop=4 shiftwidth=4
set number
set hidden " Required by LanguageClient-neovim
set timeoutlen=400

" Using echodoc, we need in increased 'cmdheight' value.
set cmdheight=2
let g:echodoc_enable_at_startup = 1

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
set scrolloff=5

" Fix slow syntax highlighting for long lines
set synmaxcol=180

" Make double-<Esc> clear search highlights and close preview window
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>:pc<CR>

" Bash-like auto complete
set wildmode=longest:full,full

" Airline
let g:airline_powerline_fonts = 1

" Fix for indentLine to prevent concealing fuckup
let g:indentLine_concealcursor=""

" Do not run sleuth for markdown because it's slow somehow
autocmd Filetype markdown let b:sleuth_automatic = 0
autocmd Filetype * if &filetype != 'markdown' | let b:sleuth_automatic = 1 | endif


"""""""""""""""""""
" Auto completion "
"""""""""""""""""""
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> and jk to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"



""""""""""
" Denite "
""""""""""
nnoremap <c-p> :Denite -start-filter file/rec<CR>
nnoremap <leader>g :Denite grep<CR>
nnoremap <silent> <leader>ll  :<C-u>Denite -auto-resize location_list<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	imap <silent><buffer> <Esc> <Plug>(denite_filter_quit)
	inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
endfunction

" Ripgrep command on file/rec
call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--color', 'never', '--glob', '!.git'])

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#source('grep', 'converters', ['converter/abbr_word'])



" Thesaurus
nnoremap <Leader>tcw :ThesaurusQueryReplaceCurrentWord<CR>

" Go
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>e <Plug>(go-rename)

" Javascript
au FileType javascript setlocal backupcopy=yes

" Do not conceal JSON
let g:vim_json_syntax_conceal = 0

" Do not conceal markdown
let g:vim_markdown_conceal = 0

" Latex
if has('macunix')
	let g:vimtex_quickfix_enabled = 0
	let g:vimtex_quickfix_mode = 0 "quickfix window not opened automatically
	let g:vimtex_quickfix_open_on_warning = 0
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
	let g:vimtex_compiler_progname = 'nvr'
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

" Defx
call defx#custom#option('_', {
		\ 'ignored_files': '.*,*.aug,*.fdb_latexmk,*.fls,*.aux,*.cb,*.bib,
			\ \*.bbl,*.bcf,*.blg,*.out,*.pdf,*.lof,*.lot,*.toc,
			\ *.synctex.gz,\*.run.xml',
		\ 'columns': 'mark:indent:icons:filename:type'
		\ })
nnoremap <C-n><C-n> :Defx -search=`expand('%:p')` -listed -resume<CR>
nnoremap <C-n> :Defx -listed -resume<CR>

" map <C-n> :Defx -ignored-files=" 			\ -listed -resume
" 			\ -columns=mark:indent:icons:filename:type <CR>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	" Define mappings
	nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
	nnoremap <silent><buffer><expr> c defx#do_action('copy')
	nnoremap <silent><buffer><expr> m defx#do_action('move')
	nnoremap <silent><buffer><expr> p defx#do_action('paste')
	nnoremap <silent><buffer><expr> l defx#do_action('open')
	nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
	nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
	nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N defx#do_action('new_file')
	nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns',
	\                                                'mark:indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> d defx#do_action('remove')
	nnoremap <silent><buffer><expr> r defx#do_action('rename')
	nnoremap <silent><buffer><expr> !\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
	nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
	nnoremap <silent><buffer><expr> q defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
	nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
	nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
endfunction

""""""""""""""""""""""""""""""""""
" Language Server Protocol (LSP) "
""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
	\ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
	\ 'javascript.jsx': ['/usr/bin/javascript-typescript-stdio'],
	\ 'typescript': ['/usr/bin/typescript-language-server', '--stdio'],
	\ 'typescript.tsx': ['/usr/bin/typescript-language-server', '--stdio'],
	\ 'reason': ['/usr/bin/reason-language-server'],
	\ 'php': ['php', '/home/matteus/.config/composer/vendor/felixfbecker/language-server/bin/php-language-server.php']
	\ }

function! LC_maps()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <buffer> <slient> <F5>        :call LanguageClient_contextMenu()<CR>
		nnoremap <buffer> <silent> K           :call LanguageClient#textDocument_hover()<CR>
		nnoremap <buffer> <silent> gdp         :call LanguageClient#textDocument_typeDefinition()<CR>
		nnoremap <buffer> <silent> gd          :call LanguageClient#textDocument_definition()<CR>
		nnoremap <buffer> <silent> <c-]>       :call LanguageClient#textDocument_definition()<CR>
		nnoremap <buffer> <silent> <F2>        :call LanguageClient#textDocument_rename()<CR>
		nnoremap <buffer> <silent> <leader>r   :call LanguageClient#textDocument_rename()<CR>
		nnoremap <buffer> <silent> <leader>f   :call LanguageClient#textDocument_formatting()<CR>

		nnoremap <buffer> <silent> <leader>c  :Denite contextMenu<CR>
		nnoremap <buffer> <silent> <leader>ls :Denite documentSymbol<CR>
		nnoremap <buffer> <silent> <leader>lr :Denite references<CR>
		nnoremap <buffer> <silent> <leader><leader> :Denite codeAction<CR>
	endif
endfunction
autocmd FileType * call LC_maps()

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx setlocal signcolumn=yes

" To enable logging:
" let $RUST_BACKTRACE = 1
" let g:LanguageClient_loggingLevel = 'INFO'
" let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
" let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

" Prettier
let g:prettier#exec_cmd_async = 1


let g:pencil#autoformat_config = {
		\   'markdown': {
		\     'black': [
		\       'htmlH[0-9]',
		\       'markdown(Code|H[0-9]|Url|IdDeclaration|Link|Rule|Highlight[A-Za-z0-9]+)',
		\       'markdown(FencedCodeBlock|InlineCode)',
		\       'mkd(Code|Rule|Delimiter|Link|ListItem|ListItemLine|IndentCode|Snippet|NonListItem|NonListItemBlock)',
		\       'mmdTable[A-Za-z0-9]*',
		\     ],
		\     'white': [
		\      'markdown(Code|Link)',
		\     ],
		\ }
	\ }

" Livedown (preview of markdown)
let g:livedown_autorun = 0

" Auto build spell files
let s:dirs = split(globpath(&rtp, 'spell'), '\n')
for s:dir in s:dirs
	let s:add_files = split(globpath(s:dir, '*.add'), '\n')
	for s:add_file in s:add_files
		let s:spl_file = s:add_file . '.spl'
		let s:has_access = filereadable(s:add_file) && filewritable(s:add_file) == 1
		if s:has_access && getftime(s:add_file) > getftime(s:spl_file)
			silent exec 'mkspell! ' . fnameescape(s:add_file)
		endif
	endfor
endfor

let $NVIM_NODE_LOG_FILE='nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='warn'

" Disable default plugins
let g:loaded_netrwPlugin       = 1

