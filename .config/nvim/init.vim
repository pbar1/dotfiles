set nocompatible
syntax on
filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

"--------------------------------------------------------------
" vim-plug
"--------------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'

Plug 'tpope/vim-sensible'
Plug '/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'cespare/vim-toml'

call plug#end()

"--------------------------------------------------------------
" Themes / Visuals
"--------------------------------------------------------------

let g:airline_theme='one'
colorscheme one
let g:one_allow_italics = 1
set background=dark
"set background=light

syntax on
highlight Comment cterm=italic

:set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
filetype plugin on

"--------------------------------------------------------------
" Language Settings / Other
"--------------------------------------------------------------

let g:terraform_align=1
let g:terraform_fmt_on_save=0

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1
