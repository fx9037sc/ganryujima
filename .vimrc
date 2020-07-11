" Basic {
	set nocompatible
	set autoindent
	set smartindent
	set ruler
	syntax on	
	set mouse=a
	set number
	set showmatch
" }

" General {
	set incsearch                   " Find as you type search
	set hlsearch                    " Highlight search terms
	set ignorecase                  " Case insensitive search
    	set smartcase                   " Case sensitive when uc present
    	set wildmenu                    " Show list instead of just completing	
	set clipboard=unnamed
	nnoremap <silent> <F5> :tabnew 
	highlight Pmenu    guibg=darkgrey  guifg=black
	highlight PmenuSel guibg=lightgrey guifg=black
" }


" Cscope {
	if has("cscope")
        	set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
           	" check cscope for definition of a symbol before checking ctags:
           	" set to 1 if you want the reverse search order.
             	set csto=1

             	" add any cscope database in current directory
             	if filereadable("cscope.out")
                 	cs add cscope.out
             	" else add the database pointed to by environment variable
             	elseif $CSCOPE_DB !=""
                 	cs add $CSCOPE_DB
             	endif

             	" show msg when any other cscope db added
             	set cscopeverbose

             	nmap <C-\>a :cs find s <C-R>=expand("<cword>")<CR><CR>
             	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
             	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
             	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
             	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
             	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
             	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
             	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	endif
" }

" NerdTree {
	nnoremap <silent> <F10> :NERDTreeToggle<CR>
	let NERDTreeWinPos="right"
" }

" TagList {
	" 按F8按钮，在窗口的左侧出现taglist的窗口,像vc的左侧的workpace
	nnoremap <silent> <F6> :TlistToggle<CR><CR>
	" :Tlist              调用TagList
	let Tlist_Auto_Open=1
	let Tlist_Show_One_File=0                    " 只显示当前文件的tags
	let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
	let Tlist_Use_Right_Window=0                 " 在右侧窗口中显示
	let Tlist_File_Fold_Auto_Close=1             " 自动折叠
" }

" Neocomplete {
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 0
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
	
	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }
	
	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'
	
	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()
	
	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplete#close_popup()
	inoremap <expr><C-e>  neocomplete#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
	
	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplete#enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplete#enable_insert_char_pre = 1
	
	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1
	
	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
	
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	
	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
	
	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }

