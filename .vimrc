"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  来自c.vim的推荐设置, 学习并修改
"      AUTHOR:   Dr.-Ing. Fritz Mehner, Pieux Xi
"      CREATED:  04.04.2009
"     MODIFIED:  30.11.2011
"     REVISION:  $Id: customization.vimrc,v 1.6 2009/10/03 12:24:30 mehner Exp $
"===================================================================================
"
"===================================================================================
" {{{ 1 GENERAL SETTINGS
"===================================================================================
"
"-------------------------------------------------------------------------------
" {{{ 2 关闭vi兼容
" 必须放在配置文件最前面
"-------------------------------------------------------------------------------
set nocompatible
"
"-------------------------------------------------------------------------------
" 打开file type检测，使用默认的file type设置
" 加载indent文件，自动特定语言的缩进
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" 打开语法高亮
"-------------------------------------------------------------------------------
syntax    on            
"
" 2 }}}
"
"-------------------------------------------------------------------------------
" {{{ 2 平台特定项目
"-------------------------------------------------------------------------------
" - central backup directory (has to be created)
" - default dictionary
" Uncomment your choice.  
if  has("win16") || has("win32")     || has("win64") || 
  \ has("win95") || has("win32unix")
    "
"    runtime mswin.vim
"    set backupdir =$VIM\vimfiles\backupdir
"    set dictionary=$VIM\vimfiles\wordlists/german.list
else
"    set backupdir =$HOME/.vim.backupdir
"    set dictionary=$HOME/.vim/wordlists/german.list
endif
"
" Using a backupdir under UNIX/Linux: you may want to include a line similar to
"   find  $HOME/.vim.backupdir -name "*" -type f -mtime +60 -exec rm -f {} \;
" in one of your shell startup files (e.g. $HOME/.profile)
"
" 2 }}}
"
"-------------------------------------------------------------------------------
" {{{ 2 一些基本设置
"-------------------------------------------------------------------------------
set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,utf-16,big5
set termencoding=utf-8
set autoindent                  " 自动缩进对齐
set expandtab
set textwidth=79
set autoread                    " 自动加载文件变化
set autowrite                   " 切换buffer时自动写入
set backspace=indent,eol,start  " insert mode退格键
set backup                      " 修改即生成备份文件
set browsedir=current           " 设置file browser目录为当前buffer目录
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " command mode命令历史记录50
set hlsearch                    " 高亮搜索文本
set incsearch                   " 打开增量搜索
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=a                     " 使用鼠标
set nowrap                      " 不自动换行
set popt=left:8pc,right:3pc     " 打印选项
set ruler                       " 先是鼠标位置
set shiftwidth=4                " ?? 缩进所占空格为4
set showcmd                     " 显示未完成命令
set smartindent                 " 智能缩进
set tabstop=8                   " ?? Tab所占空格为8
set softtabstop=4
set visualbell                  " 虚拟铃声而不是bee
set wildignore=*.bak,*.o,*.e,*~ " 忽略此类扩展名文件
set wildmenu                    " command-line completion in an enhanced mode
set fdm=marker			" 文件夹折叠模式

" 根据文件类型，不同缩进
" sw:shiftwidth sts:softtabstop et:expandtab tw:textwidth
augroup vimrc
au!
autocmd FileType css setlocal sw=4 sts=4 et
autocmd FileType html setlocal sw=2 sts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 et
autocmd FileType python setlocal sw=4 sts=4 et tw=72
autocmd FileType ruby setlocal sw=2 sts=2 et
autocmd FileType sql setlocal et
autocmd FileType text setlocal sw=2 sts=2 et tw=79
augroup END
"
" 2 }}}
" 1 }}}
"===================================================================================
" {{{ 1 BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" {{{ 2 The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" 打开自动跳转到上次编辑位置
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
" 2 }}}
"
"-------------------------------------------------------------------------------
" {{{ 2 其他热键
"-------------------------------------------------------------------------------
"    F2   -  无须确认，直接写入文件
"    F3   -  call file explorer Ex
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error   
"-------------------------------------------------------------------------------
"
map   <silent> <F2>        :write<CR>
map   <silent> <F3>        :Explore<CR>
nmap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F5>        :copen<CR>
map   <silent> <F6>        :cclose<CR>
map   <silent> <F7>        :cp<CR>
map   <silent> <F8>        :cn<CR>
"
imap  <silent> <F2>   <Esc>:write<CR>
imap  <silent> <F3>   <Esc>:Explore<CR>
imap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F5>   <Esc>:copen<CR>
imap  <silent> <F6>   <Esc>:cclose<CR>
imap  <silent> <F7>   <Esc>:cp<CR>
imap  <silent> <F8>   <Esc>:cn<CR>
" 
"-------------------------------------------------------------------------------
" buffer快速切换
" 切换时当前buffer会自动保存
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
"
 map  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly && 
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
imap  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly && 
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" 输入逗号加一空格
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces 
" 自动配对括号，方括号，花括号
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
" 自动完成引号
"-------------------------------------------------------------------------------
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>
"
" 2 }}}
" 1 }}}
"===================================================================================
" {{{ 1 VARIOUS PLUGIN CONFIGURATIONS	
"===================================================================================
"
"-------------------------------------------------------------------------------
" c.vim
"-------------------------------------------------------------------------------
"            
" --empty --
"                         
"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for make
" taglist.vim : define the title texts for qmake
"-------------------------------------------------------------------------------
 noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select 				= 1

let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

if has("autocmd")
  " ----------  qmake : set filetype for *.pro  ----------
  autocmd BufNewFile,BufRead *.pro  set filetype=qmake
endif " has("autocmd")

imap jj <esc>			".Xmodmap, using Capslock to escape
colorscheme zenburn	"something like classical
" colorscheme solarized	"very white theme
" let Tabula_LNumUnderline=1 
" colorscheme tabula		"very refreshing green backcolor
" colorscheme molokai	"black
"
" 1 }}}
"===================================================================================
" {{{ 1 vimimrc:Chinese Input Method Configuration
"===================================================================================
"
"-------------------------------------------------------------------------------
" vimimrc,中文输入法配置
"-------------------------------------------------------------------------------
" 日期：2011年12月30日　星期五 
" 電腦：unix  0.023470 seconds 
" 版本：vim=703　vimim.vim=11461 
" 編碼：utf-8　ucs-bom,utf-8,default,latin1 
" 環境：en_US.UTF-8 
" 詞庫：雲詞庫：谷歌雲　搜狗雲　百度雲　ＱＱ雲　 
" 聯網：Python2 Interface to Vim 
" 輸入：VimIM　點石成金 　谷歌雲 　 
" 選項：vimimrc 
" 
" 暂时，搜狗云和搜狗本地词库在静态配置成功，
" 使用起来挺顺畅
" 点石成金，一会儿灵一会儿不灵
let g:vimim_map = '' 			" 默认Ctrl+_,打开vimim
let g:vimim_mode = 'static' 	"设置为静态模式，动态模式占内存
let g:vimim_punctuation = 2 	"常用的中文标点
let g:vimim_plugin = '/home/pieux/.vim/plugin'  
let g:vimim_shuangpin = 0  		"不使用双拼
" let g:vimim_cloud = -1
let g:vimim_cloud = 'sogou'
let g:vimim_toggle = 'sogou' 	"本地词库仅需直接放在plugin文件夹
let g:vimim_mycloud = 0  
" 1 }}}
"===================================================================================
" {{{ 1 Plugin Configuration
"===================================================================================
"
"-------------------------------------------------------------------------------
" {{{ 2 miniBufExplorer
"-------------------------------------------------------------------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" 2 }}}
"-------------------------------------------------------------------------------
" {{{ 2 TaskList and TlistToggle
"-------------------------------------------------------------------------------
map T :TaskList<CR>
map P :TlistToggle<CR>
" 2 }}}
" 1 }}}
