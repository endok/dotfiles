" ------------------------------
"  vundle
" ------------------------------
set nocompatible " vi互換なし
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'vundle'
Bundle 'neocomplcache'
Bundle 'The-NERD-Commenter'
Bundle 'mattn/emmet-vim'
Bundle 'ctrlp.vim'
Bundle 'The-NERD-tree'
Bundle 'rbgrouleff/bclose.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'rails.vim'
Bundle 'Vim-Rspec'
Bundle 'endwise.vim'
Bundle 'bundler'
Bundle 'vim-coffee-script'
Bundle 'othree/html5.vim'
Bundle 'chase/vim-ansible-yaml'

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
set noundofile " undoファイルを作らない
set hidden " 保存しないで他ファイルを表示可能に
set vb t_vb= " beep音消す
set modelines=0 " modelineを無効に
" set list " 不可視文字を表示
" set listchars=trail:_ " 不可視文字の表示形式
set textwidth=0 " 行の折り返し文字数を設定しない
"set nowrap " 行折り返しをしない

" タブ
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab


" ------------------------------
"  色関連
" ------------------------------

syntax on " シンタックスハイライトON
colorscheme torte

" jsonファイルをjavascriptとして扱う
autocmd BufNewFile,BufRead *.json set ft=javascript

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
nnoremap <silent> <Space>; :bn<CR>
nnoremap <silent> <Space>: :bp<CR>

" Escの2回押しでハイライト消去
nmap <silent> <ESC><ESC> :nohlsearch<CR><ESC>

" INSERTモードを抜けるとIMEオフ
" Terminalの場合はKeyRemap4MacBookで設定する
" set noimdisableactivate
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" ------------------------------
"  neocomplcache
" ------------------------------
let g:neocomplcache_enable_at_startup = 1

" ------------------------------
"  ctrlp
" ------------------------------
let g:ctrlp_custom_ignore = '\v(/vendor/bundle/)|(/doc/)|(/spec/reports/)|(/coverage/)|(/tmp/cache/)|(\.so|\.swp|\.zip)'

" ------------------------------
"  bclose
" ------------------------------
nnoremap <silent> <Space>bc :Bclose<CR>


