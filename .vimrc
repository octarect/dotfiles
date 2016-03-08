if filereadable(expand("~/dotfiles/.vimrc_bundle"))
    source ~/dotfiles/.vimrc_bundle
endif

if filereadable(expand("~/dotfiles/.vimrc_tab"))
    source ~/dotfiles/.vimrc_tab
endif

"#####一般設定#####
set noswapfile
set clipboard=unnamedplus "yankでクリップボードへコピー
set timeoutlen=500
set nobackup
set autoread

"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set tabstop=2 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set autoindent
set shiftwidth=2
set cursorline
set hlsearch
set guifont=Inconsolata "アンダースコア問題の解決
set guifontwide=Takaoゴシック "アンダースコア問題の解決
set expandtab "タブをスペースに変換する

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"#####テーマ設定#####
syntax on
colorscheme molokai
set t_Co=256
hi Comment ctermfg=102
hi String ctermfg=228
hi Character ctermfg=228
hi Delimiter ctermfg=228
hi Visual ctermbg=240
hi Operator ctermfg=9

hi Normal ctermfg=255 ctermbg=none
hi LineNr ctermfg=white ctermbg=none
hi NonText ctermbg=none

"#####エンコーディング設定#####
set encoding=UTF-8

"#####
filetype plugin indent on
