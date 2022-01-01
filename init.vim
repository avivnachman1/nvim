call plug#begin()
"Aviv
Plug 'jiangmiao/auto-pairs'

Plug 'morhetz/gruvbox' " colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:gruvbox_contrast_dark="hard"


" coc stuff {{{
" coc also auto format the code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab to trigger completion after non whitespace character and navigation.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Splitting panes and moving around in panes
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" This doesn't break normal K usage :)
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


function! CocGetCurrentFunction()
    return get(b:,'coc_current_function','')
endfunction

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>l  :<C-u>CocListResume<CR>


let g:coc_global_extensions = [ 'coc-clangd', 'coc-rust-analyzer', 'coc-tsserver', 'coc-pyright' ]
" }}}

" fzf {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Rg call fzf#vim#grep("rg --no-ignore --hidden --glob '!.git' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

let g:fzf_files_options = '--preview "(cat {}) 2> /dev/null "'
nmap <C-t> :Files<CR>
" }}}


" Quickly comment / uncomment shenenigans
Plug 'tpope/vim-commentary'


" Don't overwrite my Coc expansion..
let g:UltiSnipsExpandTrigger       =  "<nop>"
let g:UltiSnipsListSnippets        =  "<nop>"
let g:UltiSnipsJumpForwardTrigger  =  "<nop>"
let g:UltiSnipsJumpBackwardTrigger =  '<nop>'
Plug 'SirVer/ultisnips'


" Semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'



" lightline already shows the current mode
set noshowmode

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

nmap <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" Startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" }


"adding some more plugins:
Plug 'nelstrom/vim-visual-star-search' "using # and * in visual  mode, better search, then use N and n for finding

Plug 'kamykn/spelunker.vim' " spell check
Plug 'kamykn/popup-menu.nvim' "popup for the spell check
set nospell " disable vim's default spell checker

" Plug 'mg979/vim-visual-multi', {'branch': 'master'} " i dont want this plugin enabled

Plug 'junegunn/vim-peekaboo'

Plug 'sickill/vim-pasta'
let g:pasta_disabled_filetypes = ['fugitive']

Plug 'farmergreg/vim-lastplace'

Plug 'airblade/vim-rooter'

Plug 'voldikss/vim-floaterm'

let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

augroup FloatermCustomisations
    autocmd!
    autocmd ColorScheme * highlight FloatermBorder guibg=none
augroup END


call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
highlight = {
enable = true,              -- false will disable the whole extension
-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- Instead of true it can also be a list of languages
additional_vim_regex_highlighting = false,
},
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
    indent = {
    enable = true
    }
}
EOF

" must be placed after plug#end

colorscheme gruvbox
" Bindings {{{

let mapleader = "\\"

" Aviv
"
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
nnoremap <silent> <leader><Left> :call WinMove('h')<CR>
nnoremap <silent> <leader><Down> :call WinMove('j')<CR>
nnoremap <silent> <leader><Up> :call WinMove('k')<CR>
nnoremap <silent> <leader><Right> :call WinMove('l')<CR>


" Go to the last file with double space this fucked up the visual tabs
" nnoremap <space><space> :b#<CR>

"fast skips lines:
noremap <C-Up> 5k
noremap <C-Down> 5j

" tab management
"nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Left> :bp<CR>
"nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Right> :bn<CR>
"nnoremap <C-d>       :tab split<CR>
" nnoremap <C-w>       :tabclose<CR>
"nnoremap <C-w>       :q<CR>
nnoremap <C-w>       :bd<CR>


" fuzzy fzf
nnoremap <silent> <leader>h       :History:<CR>
nnoremap <C-f> :Rg <CR>

" }}}
"Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
    fun! ReloadVimrc()
        let save_cursor = getcurpos()
        source $MYVIMRC
        call setpos('.', save_cursor)
    endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()
nnoremap <C-s> :e $MYVIMRC<CR>


" Options {{{


" Side numbers
set number
set relativenumber

set conceallevel=0 "for markdown 
set smartindent  "indenting
set autoindent "self explanatory 
set cursorline "highlight current line
set formatoptions-=cro
set clipboard=unnamedplus

" Stop newline continution of comments

" I like them in groups of 4 (tabs)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

autocmd Filetype html,typescript,typescriptreact setlocal ts=2 sw=2 sts=2

" Search is case insensitive, can be overriden with \c or \C
set ignorecase

" Always show 5 lines of context above and below current line
set scrolloff=7

" Persistent undo
set undofile
" no swap files its annoying
set noswapfile
"linux file format
set fileformat=unix

" Mouse is till nice
set mouse=a

" Show live substitution
set inccommand=nosplit

set list
set listchars=tab:▸\ ,trail:·
" }}}

" Command line abbreviations {{{
cnoreabbrev man Man
cnoreabbrev vimdir ~/.config/nvim/
cnoreabbrev So so
" }}}
" 

source ~/.config/nvim/autoload/highlight_words.vim

