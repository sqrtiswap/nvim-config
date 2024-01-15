" ==============================================================================
" BASICS:
set nocompatible            " Disable vi compatibility restrictions.
syntax enable               " Enable syntax highlighting.
filetype plugin on          " Enable plugins (also needed for netrw).
set number                  " Show line number.
set relativenumber          " Show relative line numbers.
set showmode                " Display current mode.
set showmatch               " Show matching parenthesis, braces, etc.
set ruler                   " Display row/column information.
set wildmode=longest,list   " Get bash-like autocompletion
set cc=80                   " Column boarder at 80 characters.
set cursorline              " Highlight current line.
set ttyfast                 " Speed up scrolling.
set clipboard=unnamedplus   " Use system clipboard.
set scrolloff=7             " Center the cursor
"set mousescroll=ver:5,hor:2
set updatetime=100          " Reduce update delay
"set signcolumn=yes          " Always show the sign column
set encoding=utf-8
autocmd OptionSet * set wrap

" ==============================================================================
" MOVE AROUND:
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" ==============================================================================
" BACKUP:
set backup                  " Turn on backups
set backupdir=~/.cache/nvim " Directory to store backup files
set writebackup             " Make backup before overwriting current buffer
set backupcopy=yes          " Overwrite original backup file
" Meaningful backup name, ex: filename@2015-04-05.14:59
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

" SWAP:
set noswapfile              " Disable creating swap files

" ==============================================================================
" PLUGINS:
command! PU PlugUpdate | PlugUpgrade
call plug#begin('~/.config/nvim/pack')
Plug 'airblade/vim-gitgutter'          " git signs
Plug 'jreybert/vimagit'                " advanced git staging
Plug 'tpope/vim-fugitive'              " git blame support
Plug 'itchyny/lightline.vim'           " minimal statusline
Plug 'mg979/vim-visual-multi'          " multiple cursors
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/gv.vim'                 " git commit browser using vim-fugitive
Plug 'Yggdroot/indentLine'             " advanced indentation display
Plug 'ledger/vim-ledger'               " quality of life for ledger-cli
call plug#end()

" ======
" gv.vim
" o       commit in split
" O       commit in tab
" q       close
" :GV     open
" :GV!    open only affecting current file

" ==============================================================================
" COLOURS:
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox
let g:lightline = { 'colorscheme': 'apprentice' }
hi LineNrAbove     cterm=none guifg=grey ctermfg=grey
hi LineNrBelow     cterm=none guifg=grey ctermfg=grey
hi CursorLine      ctermbg=darkgrey
hi CursorLineNr    cterm=bold gui=bold guifg=white ctermfg=white
hi LineNr          cterm=bold gui=bold guifg=white ctermfg=white
hi ColorColumn     ctermbg=darkgrey
hi SignColumn      guibg=none ctermbg=none

" gitgutter
hi GitGutterAdd    cterm=bold ctermfg=lightgreen
hi GitGutterChange cterm=bold ctermfg=lightyellow
hi GitGutterDelete cterm=bold ctermfg=lightred
let g:gitgutter_override_sign_column_highlight = 1
autocmd BufWritePost * GitGutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk) " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)  " git undo (chunk)
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)

" vimagit
" Open vimagit pane
nnoremap <leader>gs :Magit<CR>
" Push to remote
nnoremap <leader>gP :! git push<CR>

" vim-fugitive
" Show commits for every source line (git blame)
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gh :Gsdiff<CR>:windo set wrap<CR>
nnoremap <Leader>gv :Gvdiff<CR>:windo set wrap<CR>

" indentLine
let g:indentLine_fileTypeExclude = ['tex','markdown']

" vim-ledger
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 80
let g:ledger_fold_blanks = 1
let g:ledger_date_format = '%Y/%m/%d'
function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()
" ==============================================================================
" WHITESPACE:
set list
set listchars=tab:▸\ ,trail:·,eol:⏎,nbsp:⎵  " more symbols: ⏎¬·▸⍿×┌┬┐⎵¦┆┊
set list lcs=tab:\▸\                        " use indentLine
autocmd BufWritePre * :%s/\s\+$//e          " Remove trailing whitespace when
                                            " saving
let g:indentLine_char = '¦'
let g:indentLine_defaultGroup = 'SpecialKey'

" ==============================================================================
" INDENTATION:
filetype plugin indent on " Indent depending on file type.
set autoindent            " Automatically indent.
set tabstop=4             " Number of spaces equal to tab (ts).
set shiftwidth=4          " width for autoindents (sw).
set softtabstop=4         " See multiple spaces as tabstops so <BS> works
"                           correctly (sts).
set noexpandtab           " Never convert tabs to spaces (noet).

autocmd BufRead,BufNewFile *.csv set ts=8 sw=8 noet colorcolumn&
autocmd BufRead,BufNewFile *.tsv set ts=8 sw=8 noet colorcolumn&
"augroup tsv
"autocmd!
	"au BufReadPost *.tsv setlocal tabstop=20
"augroup END

autocmd FileType magit set cc=72
autocmd FileType gitcommit set cc=72

autocmd BufRead,BufNewFile *.py set ts=4 sw=4 sts=4 et cc=79

autocmd FileType sh set ts=4 sw=4 sts=4 noet cc=80

autocmd FileType mail set cc=72 noautoindent et

autocmd FileType markdown set cc=80 ts=8 sw=8 noet sts=8

" ==============================================================================
" SEARCH:
set ignorecase     " Search case-insensitive.
set smartcase      " Unless uppercase is used.
set incsearch      " Incremental search.
set hlsearch       " Highlight search results.
nohlsearch         " Do not immediately turn on highlighting.

" ==============================================================================
" FOLDING:
" Folding should be set manually, never automatically.
set foldmethod=manual
" Do not fold anything by default.
set foldlevel=999

" ==============================================================================
" FINDING FILES:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b allows to autocomplete any open buffer, check buffers with :ls

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when tab-completing
set wildmenu

" ==============================================================================
" TAG JUMPING:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" Create the `tags` file (may need to install ctags first)
" ! executes as a shell command
command! MakeTags !ctags -R .

" ==============================================================================
" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|, the most important are:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with the path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" - Use ^n and ^p to go back and forth in the suggestion list

" ==============================================================================
" FILE BROWSING:
" netrw is a plugin but it's builtin
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" ==============================================================================
" SNIPPETS:
" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.config/nvim/snippets/skeleton.html<CR>3jwf>a
" n       -> applies in normal mode
" noremap -> don't allow to invoke itself or something that's named the same
" ,       -> leader
" html    -> command that runs whatever comes afterwards
" :       -> enter COMMAND mode
" -1      -> change line to not add another empty line
" read    -> read something and paste where the cursor is
" <CR>    -> carriage return, i.e. press Return to execute the read command,
"            remove it to allow editing the command before executing
" 3j      -> go down 3 lines
" w       -> go ahead a word
" f>       -> go to next >
" a       -> enter insert mode after the cursor

" get ISC licence template
nnoremap ,isc :-1read $HOME/.config/nvim/snippets/isc.licence<CR>j6wi
" get tex template
nnoremap ,tex :-1read $HOME/.config/nvim/snippets/master.tex<CR>Gdd4kf{a
" get tex makefile
nnoremap ,mk :-1read $HOME/.config/nvim/snippets/Makefile<CR>ggA
" get usage template
nnoremap ,shu :-1read $HOME/.config/nvim/snippets/usage.sh<CR>2jA
" get ansi colours for shellscripts
nnoremap ,shc :-1read $HOME/.config/nvim/snippets/colour.sh<CR>
" get ~/.mbsyncrc section template
nnoremap ,mbs :-1read $HOME/.config/nvim/snippets/mbsyncrc<CR>Wi
" get ~/.config/mpop section template
nnoremap ,mpop :-1read $HOME/.config/nvim/snippets/mpop<CR>jWi
" get ~/.config/mutt/accounts/<ID>-<ACCOUNT>.muttrc template
nnoremap ,mutt :-1read $HOME/.config/nvim/snippets/muttrc<CR>3jI

" ==============================================================================
" REGISTERS:
" dd   -> delete into default aka double-quote register
" "ad  -> delete into register a
" "a   -> paste from register a
" "+yy -> yank to register + (connected to system clipboard)

" ==============================================================================
" HELP SYSTEM:
" :help             -> enter help system
" ^ is for Ctrl
" :help ^n          -> find out what Ctrl-n does in normal mode
" :help i_^n        -> find out what Ctrl-n does in insert mode
" :help c_^n        -> find out what Ctrl-n does in command mode
" :helpgrep windows -> grep through all help pages for windows
" :cn, :cp, :cl     -> navigate within help system

" ==============================================================================
" SHORTCUTS:
map gS {j!}sort -ur
map gT :%!a=$(cat %);echo "$a"
map gY !'mtmux load-buffer -u
map ga :E %_test
map gd :r!date +\%Y-\%m-\%d
map ge :E
map gg 1G
map go :%!gofmt
map gp :r!xclip -o -selection clipboard
map gs {!}sort -u
map gt mM:%s/[[:space:]]*$//
" mark line above with mt, then execute on last line to reverse order
map gr :'t+1,.g/^/m 't

" ==============================================================================
" MULTI EDITING:
" vim-visual-multi:  ^Up, ^Down for additional cursors
" visual block mode: ^v (works on alignment)
"                    Shift-i and I enter insert-mode, Esc applies to all lines
" visual line mode:  Shift-v (indent with <,>)
" macros:            start/stop recording with q, repeat with n@i with n a
"                    number and i the macro (start with qi)
"                    ip pastes the buffer for later use
" gn text object:    1. search what to replace
"                    2. jump with n to first occurrence
"                    3. cgn (change with gn), type the change
"                    4. use .,n,u for all further occurrences
"                    gn can also use d,y, ...

" ==============================================================================
" CUSTOM BEHAVIOUR:
" remember cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" run macros over visual block
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
