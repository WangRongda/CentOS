set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/c.vim'
let g:C_Styles = { '*.c,*.h' : 'default', '*.cc,*.cpp,*.cxx,*.xx,*.hh' : 'CPP' }
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/taglist.vim'
Plugin 'xuhdev/SingleCompile'
"Plugin 'msanders/snipmate.vim'  
"ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"展开"
let g:UltiSnipsExpandTrigger="<c-k>"
"下一个
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
"ultisnips
"
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'mcandre/Conque-Shell'
"Plugin 'Shougo/vimshell.vim'
" let Vundle manage Vundle, required

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
set nocp
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" my vim ------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker 
	autocmd FileType text setlocal cursorline
	autocmd BufNewFile,BufRead *.mytxt  setlocal filetype=mytxt
	autocmd BufNewFile *.c,*.h exec "call SetCComment()" 
	autocmd BufNewFile *.cpp,*.hh,*.cxx,*.cc exec "call SetCPPComment()" 
	autocmd FileType mytxt setlocal  conceallevel=2 concealcursor=nc cursorline
augroup END

augroup note
	autocmd FileType c exec ":call FileType_C()"  
	autocmd FileType cpp exec ":call FileType_CPP()"
	autocmd FileType sh,python nnoremap <localleader># 0i#<esc>
augroup END

set nu
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
"set noexpandtab 
set expandtab   " TAB 替换为空格（按Tab相当于输入4个空格）
set showcmd
set hlsearch incsearch
set backup
set patchmode=.orig
set showcmd
set foldcolumn=0
highlight foldcolumn ctermbg=none
let maplocalleader=","
nnoremap <localleader>w :close<cr>
"nnoremap <enter> <c-w>]
nnoremap <localleader>ev :split $MYVIMRC<cr>
nnoremap <localleader>sv :source $MYVIMRC<cr>
nnoremap <localleader>*  :nohlsearch<cr>
nnoremap <localleader>sj :set autoindent! cindent!<cr>
nnoremap <localleader>f :call FoldColumnToggle()<cr>
nnoremap <localleader>- :set iskeyword=@,48-57,_,192-255,#,-,: <cr>
nnoremap <localleader>fy :execute "!fy  " . shellescape(expand("<cWORD>"))  <cr>
nnoremap <localleader>bk :execute "!python ~/python/baike.py " . shellescape(expand("<cWORD>"))  <cr>
nnoremap <localleader>pa :set paste!<cr>
vnoremap <localleader>fy "ay :!fy  '<c-r>"' <cr>
vnoremap <localleader>bk "ay :!python ~/python/baike.py  '<c-r>"' <cr>
vn <localleader>~ c~<C-r>"~<ESC>
vn <localleader>[ c[<C-r>"]<ESC>`[evi[
vn <localleader>( c(<C-r>")<ESC>`[evi(
vn <localleader>< c<<C-r>"><ESC>`[evi<
vn <localleader>{ c{<C-r>"}<ESC>`[evi{
vn <localleader>" c"<C-r>""<ESC>`[evi"
inoremap <c-l> <tab>
function! FoldColumnToggle()
    if &foldcolumn
	    setlocal foldcolumn=0
    else
	setlocal foldcolumn=4
	endif
endfunction
nnoremap <localleader>q :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! FileType_CPP()
    setlocal foldmethod=syntax 
	"set foldlevel=9999
	"select and comment block
	vn <localleader>// mao<esc>O<enter><esc>080a/<esc>j0<c-v>`aI// <esc>`ao<esc>78a/<esc>o<c-w><esc>
	"select and delete comment block
	vn <localleader>d// mao<esc>dd0<c-v>`a0llx`add
	"comment this line
	nnoremap <localleader>// <esc>ma0i// <esc>`a
	"del commnent of this line
	nnoremap <localleader>d// <esc>ma0xx`a<esc>
	"Insert a comment block
	nnoremap <localleader>cfr <esc>o<esc>80I/<esc>o<enter><esc>78a/<esc>o<c-w><esc>kk$a 
	nnoremap <localleader>form :call FormatCFile()<cr>
endfunction

function! FileType_C()
    setlocal foldmethod=syntax 
"	set foldlevel=9999
	vn <localleader>// mao<esc>O<enter><esc>0i/*<esc>78a-<esc>j0<c-v>`aI * <esc>`ao<esc>76a-<esc>a*/<enter><esc>
	vn <localleader>d// mao<esc>dd0<c-v>`a0lld`add
	"comment this line
	nnoremap <localleader>/* <esc>ma0i/* <esc>$a */<esc>`a
	"del commnent of this line
	nnoremap <localleader>d// <esc>ma0xx$xx`a<esc>

	"Insert a comment block
	nnoremap <localleader>cfr <esc>o<esc>I/*<esc>78a-<esc>o<enter><esc>76a-<esc>a*/<enter><esc>kk$a 
	nnoremap <localleader>form :call FormatCFile()<cr>
endfunction

function! FormatCFile()
	:%s/\s\+/ /g

	:%s/\(for\s*([^;]*\)\(;\)\([^;]*\)\(;\)/\1@\3@/g
	:%s/;\([^ /]\)\@=/;\r/g
	:%s/;\(\s[^/]\)\@=/;\r/g
	:%s/\*\/\(\s*\S\)\@=/\*\/\r/g
	:%s/\(for\s*(.*\)\(@\)\(.*\)\(@\)/\1;\3;/g

	:%s/\(#include[^>"]\+[<"][^>"]\+[>"]\)\@<=\s*\(\S\)\@=/\r/g
	:%s/\(\S\s*\)\@<=\([{}]\)/\r\2/g
	:%s/\([{}]\)\(\s*\S\)\@=/\1\r/g

	:%s/\(\S\)\@<=\(\s\+(\)/(/g
	:%s/\((\s\+\)\(\S\)\@=/(/g
	:%s/\(\S\)\@<=\(\s\+)\)/)/g
	:%s/\()\s\+\)\(\S\)\@=/)/g
	:%s/\(for\|if\|while\)\@<=(/ (/g

	:v/#include\|f\?scanf\|f\?printf\|\/\*/s/\([^%/=!<>+-]\s*\)\@<=\([%/=<>+-]\)\(\s*[^%/=<>+-]\)\@=/ \2 /g
	:%s/\(\(\w\|[()]\)\s*\)\@<=\([*!]\)\(\s*\)\(\w\|[()]\)\@=/ \3/g

	:%s/\([^%*/=!<>+-]\s*\)\@<=\([%*/=!<>+-]=\)\(\s*[^%*/=!<>+-]\)\@=/ \2 /g
	:%s/\(\s*\)\(||\)\(\s*\)/ \2 /g
	:%s/\(\s*\)\(&&\)\(\s*\)/ \2 /g

	:%s/\(\s\)\+\([,;]\)/\2/g
	:%s/\([,;]\)\(\S\)\@=/\1 /g

	:g/^\s*$/d
	:%s/\s\+$//g
	normal! gg=G
	:g/^}/s//}\r/g
	:%s/\([^>"]\n\)\@<=#\(include\)\@=/\r#/g
	:%s/\(#include.*\)\@<=\s*\(\n[^#]\)\@=/\r/g
	:%s/\s\{2,\}/ /g
	normal! gg=G
endfunction	
" }}}

execute pathogen#infect()
syntax on

let g:C_MapLeader  = ','
let  g:C_MenuHeader = 'yes'
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

" vim-colors-solarized{{{1
"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
" NERDTree
map <F2> :NERDTreeToggle<CR>
" TagBar
nmap <F8> :TagbarToggle<CR>
" YouCompleteMe
"let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['<Down>', '<Enter>']
"
"let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>*'
"let g:ycm_confirm_extra_conf = 0

"let g:ycm_collect_identifiers_from_tags_files=1
"let g:ycm_seed_identifiers_with_syntax=1
"let g:ycm_collect_identifiers_from_comments_and_strings=1
nnoremap <localleader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <localleader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <localleader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
"compile
nmap <F5> :SCCompile<cr>
nmap <S-F5> :call SCCompile_with_args()<cr>
function! SCCompile_with_args()
    let args = input("Input your compile arguments:\n", "")
    exec ":SCCompileAF ". args
endfunction
nmap <F6> :SCCompileRun<cr>
nmap <S-F6> :call Run_with_args()<cr>
function! Run_with_args()
    let args = input("Input your run arguments:\n", "")
    exec ":!./"."%:t:r ". args
endfunction

"run ns
call SingleCompile#SetCompilerTemplate('tcl', 'ns', 'Cns',
             \'ns', '', '')
call SingleCompile#ChooseCompiler('tcl', 'ns')

func SetCComment()
set filetype=c
call append(0, '/*')
call append(1, ' * =============================================================================')
call append(2, ' *')
call append(3, ' *       Filename:  '.expand("%"))
call append(4, ' *')
call append(5, ' *    Description:   ')
call append(6, ' *')
call append(7, ' *        Version:  1.0')
call append(8, ' *        Created:  '.strftime("%Y-%m-%d %H:%M:%S"))
call append(9, ' *       Revision:  none')
call append(10, ' *       Compiler:  gcc')
call append(11, ' *')
call append(12, ' *         Author:  WangRongda (WRD), 123899696@qq.com')
call append(13, ' *   Organization:  HDU')
call append(14, ' *')
call append(15, ' * Copyright (c) 2016, WangRongda')
call append(16, ' *')
call append(17, ' * =============================================================================')
call append(18, ' */')
:normal! 6gg$
start
endfunc

func SetCPPComment()
set filetype=cpp
call append(0, '////////////////////////////////////////////////////////////////////////////////')
call append(1, '//       Filename:  '.expand("%"))
call append(2, '//')
call append(3, '//    Description:   ')
call append(4, '//')
call append(5, '//        Version:  1.0')
call append(6, '//        Created:  '.strftime("%Y-%m-%d %H:%M:%S"))
call append(7, '//       Revision:  none')
call append(8, '//       Compiler:  gcc')
call append(9, '//')
call append(10, '//         Author:  WangRongda (WRD), 123899696@qq.com')
call append(11, '//   Organization:  HDU')
call append(12, '//')
call append(13, '// Copyright (c) 2016, WangRongda')
call append(14, '////////////////////////////////////////////////////////////////////////////////')
:normal! 4gg$
start

endfunc
