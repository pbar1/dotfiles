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

" Visuals
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

" Workflow
Plug 'tpope/vim-sensible'
Plug '/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

" Backends for completion & linting
Plug 'vim-syntastic/syntastic'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language support
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'cespare/vim-toml'

" Debugging
Plug 'puremourning/vimspector'

call plug#end()

"--------------------------------------------------------------
" Themes / Visuals
"--------------------------------------------------------------

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
set noshowmode

syntax on
highlight Comment cterm=italic

:set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
filetype plugin on

"--------------------------------------------------------------
" Language Settings / Other
"--------------------------------------------------------------

if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set undofile
set undodir=~/.local/share/nvim/undo

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

" Source plugin configuration
"source ~/.config/nvim/coc.nvim.vim
