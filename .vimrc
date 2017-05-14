"vim original config
set ignorecase        " ignore upper- or lowercase in search model
set smartcase         " if there is uppercase in search string ignore 'ignorecase' setting. it only works with 'ignorecase' setting
set autowrite         " auto write changes into file after :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、<C-]> or <C-^> runs, as well as jumps to another file with :buffer、<C-O>、<C-I>、'{A-Z0-9}' or `{A-Z0-9}`
set nocompatible      " Donot compate with vi, to avoid some bugs
filetype on           " check the file type
set autoindent        " use auto-indentation
set smartindent       " use smart indentation
set tabstop=2         " set the width of tab key
set softtabstop=2     " set the width of soft key
set shiftwidth=2      " auto-indent with 2 spaces
set backspace=2       " enable to use backspace
set showmatch         " show the matched braces
set linebreak         " wrap without breakword
set whichwrap=b,s,<,>,[,]   "jump to previous/next line when cursor at the head/end of line when input 'b'/'w' in normal model
set relativenumber    " show relative line number
set previewwindow     " show preview window
set history=1000      " set command history to 1000
set laststatus=2      " show the last activited window's status line always
set ruler             " show line number and column number in status  line
set noerrorbells      " Disable error bells
"set mouse=a          " Enable use mouse in all mode
set ttyfast           " Optimize for fast terminal connections
set modeline          " Respect modeline in files
set modelines=4       " modeline numbers
set cursorline        " hightlight current line
set title             " show the filename in the window titlebar
set encoding=utf-8    " set encoding mode
set wildmenu          " Enhance command-line completion

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/*    " Don’t create backups when editing files in certain directories

"command line setting
set showcmd           " show inputted command in command line
set showmode          " show current model in command line
set showmatch         "show match brace
set guioptions=T      "remove the toolbar in GUI
filetype on           "check the file type

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

"finding setting
set incsearch         " show matched words when input string
set hlsearch          " Highlight dynamically as pattern is typed 

"pathongen
execute pathogen#infect()
syntax on
filetype plugin indent on

"airline
let g:airline_theme='molokai'    "use a theme called 'molokai'
let g:airline#extensions#tabline#enabled=1    "show the tab line on the top
let g:airline_powerline_fonts=1    "use powerline fonts

"emmet
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall    "enable for just html/css
let g:user_emmet_leader_key='<C-Z>'    "change the default key(<C-Y>) to <C-Z>,  the trailing ',' still needs to be entered as well

"editConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']    "ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['scp://.*']    "avoid loading EditorConfig for any remote files over ssh
let g:EditorConfig_exec_path = '~/.vim/.editorconfig'
let g:editorconfig_Beautifier = '~/.vim/.editorconfig'

"vim-javascript
let g:javascript_plugin_jsdoc=1    "Enables syntax highlighting for JSDocs.
let g:javascript_plugin_ngdoc=1    "Enables some additional syntax highlighting for NGDocs. Requires JSDoc plugin to be enabled as well.

"jsDoc
let g:jsdoc_enable_es6=1    "Enable to use ECMAScript6's Shorthand function, Arrow function.
let g:javascript_plugin_flow=1    "Enables syntax highlighting for Flow.

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting=1

"apt-vim
execute pathogen#infect()  
call pathogen#helptags() 

"jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

"vimCSS3syntsx
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

"vimCSScolor
let g:cssColorVimDoNotMessMyUpdatetime = 1

"YCM
let g:ycm_semantic_triggers =  { 'scss,css': [ 're!^\s{2,4}', 're!:\s+' ], 'html': ['<', '"', '</', ' '] } 

"less2css
let g:less_autocompile = 1  " 这是开关 设置1保存less自动生成css  设置0关闭
function! s:auto_less_compile() " {{{
  if g:less_autocompile != 0
    try
      let css_name = expand("%:r") . ".css"
      let less_name = expand("%")
      if filereadable(css_name) || 0 < getfsize(less_name)
        let cmd = ':!lessc '.less_name.' 'css_name.' '
        silent execute cmd
      endif
    endtry
  endif
endfunction " }}}
autocmd BufWritePost *.less call s:auto_less_compile()

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
  :%s/\s\+$//e
	call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
