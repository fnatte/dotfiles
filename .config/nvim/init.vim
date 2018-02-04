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
set tabstop=4
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

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Nerd tree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '◀'
let g:NERDTreeIgnore = ['\.aug$', '\.fdb_latexmk$', '\.fls$', '\.aux$',
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
call denite#custom#option('default', {
			\	'prompt' : '  ',
			\	'direction' : 'dynamictop'
			\ })
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
nnoremap <c-p> :Denite file_rec<CR>


" Go
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)

" Javascript/Typescript
au FileType typescript,javascript set backupcopy=yes

" Ack/ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Latex
let g:vimtex_view_method = 'zathura'

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

