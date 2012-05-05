" ------------------------------
"  vundle
" ------------------------------
set nocompatible " vi互換なし
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'vundle'
Bundle 'unite.vim'
Bundle 'quickrun.vim'
Bundle 'neocomplcache'
Bundle 'The-NERD-Commenter'
Bundle 'eregex.vim'
Bundle 'ZenCoding.vim'

filetype plugin indent on

" ------------------------------
"  設定
" ------------------------------

set scrolloff=5 " スクロール時の余白確保
set nobackup " バックアップ取らない
set number " 行番号表示
set autoindent " 自動でインデント
set smartindent " インデント量を合わせる
set smartcase " 大文字入力までは大文字小文字区別しない
set showmatch " 対応する括弧を強調表示
set showmode " モードを表示する
set autoread " 自動で読み込み直し
set noswapfile " swapファイルを作らない
set hidden " 保存しないで他ファイルを表示可能に
set vb t_vb= " beep音消す
set modelines=0 " modelineを無効に
" set list " 不可視文字を表示
" set listchars=trail:_ " 不可視文字の表示形式
set textwidth=0 " 行の折り返し文字数を設定しない
set nowrap " 行折り返しをしない

" タブ
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab


" ------------------------------
"  色関連
" ------------------------------

syntax on " シンタックスハイライトON
" colorscheme macvim
colorscheme torte
autocmd BufRead *.twig set filetype=html

" ------------------------------
"  status line
" ------------------------------
set laststatus=2
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%=%l,%c%v%8p
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

" When insert mode, change statusline.
 let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Red cterm=None ctermfg=Black ctermbg=Cyan'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
    exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" ------------------------------
"  キーマップ
" ------------------------------

" バッファ切り替え
nnoremap <silent> ; :bn<CR>
nnoremap <silent> + :bp<CR>

" Escの2回押しでハイライト消去
nmap <silent> <ESC><ESC> :nohlsearch<CR><ESC>

" INSERTモードを抜けるとIMEオフ
" Terminalの場合はKeyRemap4MacBookで設定する
" set noimdisableactivate
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" ------------------------------
"  unite.vim
" ------------------------------
" let g:unite_enable_start_insert=1 " unite呼び出し時にINSERTモード
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file file_mru<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	" 単語単位からパス単位で削除するように変更
	map <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction

" ------------------------------
"  neocomplcache
" ------------------------------
let g:neocomplcache_enable_at_startup = 1
