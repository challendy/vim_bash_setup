" OSX: Specific keybindings
if has("mac")
  
  " TABS: safari style tab navigation
  nmap <D-[> :tabprevious<CR>
  nmap <D-]> :tabnext<CR>
  map <D-[> :tabprevious<CR>
  map <D-]> :tabnext<CR>
  imap <D-[> <C-O>:tabprevious<CR>
  imap <D-]> <C-O>:tabnext<CR>

  " TextMateLikeIndent: bind command-] to shift right
  nmap <D-]> >>
  vmap <D-]> >>
  imap <D-]> <C-O>>>

  " TextMateLikeDeindent: bind command-[ to shift left
  nmap <D-[> <<
  vmap <D-[> <<
  imap <D-[> <C-O><<


  " Change Apple+T to TextMate Like Fuzzy Finder
  nnoremap <D-t> :FufFile<CR>

  " Unmap Apple+Shift+T so we can...
  macmenu &File.Open\ Tab\.\.\. key=<nop>

  " CommandShiftT: Fuzzy Find by Tag
  nnoremap <D-T> :FufTag!<CR>


  " bind command-/ to toggle comment
  " requires NERD Commenter to be installed: http://www.vim.org/scripts/script.php?script_id=1218
  nmap <D-/> ,c<Space>
  vmap <D-/> ,c<Space>
  imap <D-/> <C-O>,c<Space>

  " LeaveInsertMode: Alternate Key mappings
  inoremap <D-i> <Esc>
  nnoremap <D-i> <Esc>

endif
