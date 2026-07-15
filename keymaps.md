# Neovim Keymaps

## Focus: Editor

### Mode: Normal

#### Bookmarks / History

- `<leader>!` — Toggle line favorite 1
- `<leader>#` — Toggle line favorite 3
- `<leader>$` — Toggle line favorite 4
- `<leader>%` — Toggle line favorite 5
- `<leader>&` — Toggle line favorite 7
- `<leader>(` — Toggle line favorite 9
- `<leader>)` — Toggle line favorite 0
- `<leader>*` — Toggle line favorite 8
- `<leader>0` — Go to line favorite 0
- `<leader>1` — Go to line favorite 1
- `<leader>2` — Go to line favorite 2
- `<leader>3` — Go to line favorite 3
- `<leader>4` — Go to line favorite 4
- `<leader>5` — Go to line favorite 5
- `<leader>6` — Go to line favorite 6
- `<leader>7` — Go to line favorite 7
- `<leader>8` — Go to line favorite 8
- `<leader>9` — Go to line favorite 9
- `<leader>@` — Toggle line favorite 2
- `<leader>^` — Toggle line favorite 6
- `<alt>+<left>` — Line history back
- `<alt>+<right>` — Line history forward

#### Buffers / Tabs

- `<leader>b` — buffer new
- `<leader>q` — Close current buffer or list
- `<leader>x` — buffer close
- `<shift>+<tab>` — buffer goto prev
- `<tab>` — buffer goto next

#### Comment

- `<leader>/` — toggle comment
- `gc` — Toggle comment
- `gcc` — Toggle comment line

#### Copy / Paste / Registers

- `<ctrl>+c` — general copy whole file

#### File Tree

- `<leader><shift>+e` — Reveal current file in NvimTree
- `<leader>e` — Focus NvimTree
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

#### LSP / Code

- `<leader>d` — LSP go to definition
- `<leader>ds` — LSP diagnostic loclist
- `<leader>fm` — general format file
- `<leader>g<shift>+d` — LSP go to declaration
- `<leader>gi` — LSP go to implementation
- `<leader>r` — LSP references
- `<ctrl>+w<ctrl>+d` — Show diagnostics under the cursor
- `<ctrl>+wd` — Show diagnostics under the cursor
- `[<shift>+d` — Jump to the first diagnostic in the current buffer
- `[d` — Jump to the previous diagnostic in the current buffer
- `]<shift>+d` — Jump to the last diagnostic in the current buffer
- `]d` — Jump to the next diagnostic in the current buffer
- `g<shift>+o` — vim.lsp.buf.document_symbol()
- `gra` — vim.lsp.buf.code_action()
- `gri` — vim.lsp.buf.implementation()
- `grn` — vim.lsp.buf.rename()
- `grr` — vim.lsp.buf.references()
- `grt` — vim.lsp.buf.type_definition()
- `grx` — vim.lsp.codelens.run()

#### Navigation / Movement

- `<leader>n` — toggle line number
- `<ctrl>+h` — Left 10 chars
- `<ctrl>+j` — Down 10 lines
- `<ctrl>+k` — Up 10 lines
- `<ctrl>+l` — Right 10 chars
- `<alt>+<ctrl>+j` — Down 10 lines, keep cursor screen position
- `<alt>+<ctrl>+k` — Up 10 lines, keep cursor screen position
- `<alt>+j` — Down one line, keep cursor screen position
- `<alt>+k` — Up one line, keep cursor screen position
- `[<space>` — Add empty line above cursor
- `]<space>` — Add empty line below cursor

#### Other

- `<leader>` — <lua function>
- `<leader>ch` — toggle nvcheatsheet
- `<leader>rn` — toggle relative number
- `<leader>w<shift>+k` — whichkey all keymaps
- `"` — <lua function>
- `&` — :help &-default
- `'` — <lua function>
- `;` — CMD enter command mode
- `<ctrl>+w` — <lua function>
- `<esc>` — general clear highlights
- `<shift>+y` — :help Y-default
- `[<ctrl>+l` — :lpfile
- `[<ctrl>+q` — :cpfile
- `[<ctrl>+t` — :ptprevious
- `[<shift>+a` — :rewind
- `[<shift>+b` — :brewind
- `[<shift>+l` — :lrewind
- `[<shift>+q` — :crewind
- `[<shift>+t` — :trewind
- `[a` — :previous
- `[b` — :bprevious
- `[l` — :lprevious
- `[t` — :tprevious
- `]<ctrl>+l` — :lnfile
- `]<ctrl>+q` — :cnfile
- `]<ctrl>+t` — :ptnext
- `]<shift>+a` — :last
- `]<shift>+b` — :blast
- `]<shift>+l` — :llast
- `]<shift>+q` — :clast
- `]<shift>+t` — :tlast
- `]a` — :next
- `]b` — :bnext
- `]l` — :lnext
- `]t` — :tnext
- ``` — <lua function>
- `c` — <lua function>
- `g` — <lua function>
- `v` — <lua function>

#### Quickfix / Lists

- `[q` — Prev quickfix
- `]q` — Next quickfix

#### Save / Quit

- `<ctrl>+s` — Save file

#### Search / Find

- `<leader>cm` — telescope git commits
- `<leader>fa` — telescope find all files
- `<leader>fb` — telescope find buffers
- `<leader>ff` — Find files (space = wildcard, case-insensitive)
- `<leader>fh` — telescope help page
- `<leader>fo` — telescope find oldfiles
- `<leader>fr` — Recent files
- `<leader>fw` — Live grep (fixed-string first, regex fallback)
- `<leader>fz` — telescope find in current buffer
- `<leader>gt` — telescope git status
- `<leader>ma` — telescope find marks
- `<leader>pt` — telescope pick hidden term
- `<leader>th` — telescope nvchad themes

#### Terminal

- `<leader>h` — terminal new horizontal term
- `<leader>v` — terminal new vertical term
- `<alt>+h` — terminal toggleable horizontal term
- `<alt>+i` — terminal toggle floating term
- `<alt>+v` — terminal toggleable vertical term

#### Windows / Splits

- `<leader><shift>+q` — Quit current window
- `<leader>o` — Focus editor window
- `<leader>wh` — Move to left window
- `<leader>wj` — Move to bottom window
- `<leader>wk` — Move to top window
- `<leader>wl` — Move to right window
- `<leader>ws` — Split window horizontal
- `<leader>wv` — Split window vertical
- `<leader>ww` — Cycle windows
- `<ctrl>+n` — nvimtree toggle window

### Mode: Edit (insert)

#### Navigation / Movement

- `<ctrl>+b` — move beginning of line
- `<ctrl>+e` — move end of line
- `<ctrl>+h` — move left
- `<ctrl>+j` — move down
- `<ctrl>+k` — move up
- `<ctrl>+l` — move right
- `<shift>+<tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<tab>` — vim.snippet.jump if active, otherwise <Tab>

#### Other

- `<ctrl>+u` — :help i_CTRL-U-default
- `<ctrl>+w` — :help i_CTRL-W-default
- `jk` — <Esc>

#### Save / Quit

- `<ctrl>+s` — Save file

### Mode: Select (visual)

#### Comment

- `<leader>/` — toggle comment
- `<leader>/` — toggle comment
- `<leader>/` — toggle comment
- `gc` — Toggle comment
- `gc` — Toggle comment

#### Copy / Paste / Registers

- `<leader>y` — Copy selection with path
- `<leader>y` — Copy selection with path

#### File Tree

- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

#### LSP / Code

- `<leader>fm` — general format file
- `<leader>fm` — general format file
- `<ctrl>+s` — vim.lsp.buf.signature_help()
- `<ctrl>+s` — vim.lsp.buf.signature_help()
- `gra` — vim.lsp.buf.code_action()
- `gra` — vim.lsp.buf.code_action()

#### Navigation / Movement

- `<ctrl>+h` — Left 10 chars
- `<ctrl>+h` — Left 10 chars
- `<ctrl>+j` — Down 10 lines
- `<ctrl>+j` — Down 10 lines
- `<ctrl>+k` — Up 10 lines
- `<ctrl>+k` — Up 10 lines
- `<ctrl>+l` — Right 10 chars
- `<ctrl>+l` — Right 10 chars
- `<shift>+<tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<shift>+<tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<tab>` — vim.snippet.jump if active, otherwise <Tab>
- `<tab>` — vim.snippet.jump if active, otherwise <Tab>

#### Other

- `#` — :help v_#-default
- `#` — :help v_#-default
- `*` — :help v_star-default
- `*` — :help v_star-default
- `@` — :help v_@-default
- `@` — :help v_@-default
- `<shift>+q` — :help v_Q-default
- `<shift>+q` — :help v_Q-default
- `[n` — Select previous node
- `[n` — Select previous node
- `]n` — Select next node
- `]n` — Select next node
- `an` — Select parent (outer) node
- `an` — Select parent (outer) node
- `in` — Select child (inner) node
- `in` — Select child (inner) node

### Mode: Terminal

#### Terminal

- `<ctrl>+x` — terminal escape terminal mode
- `<alt>+h` — terminal toggleable horizontal term
- `<alt>+i` — terminal toggle floating term
- `<alt>+v` — terminal toggleable vertical term

### Mode: Operator

#### Comment

- `gc` — Comment textobject

#### Other

- `an` — Select parent (outer) node
- `in` — Select child (inner) node

## Focus: Tree (NvimTree)

### Mode: Normal

#### Buffers / Tabs

- `<shift>+b` — nvim-tree: Toggle Filter: No Buffer

#### Copy / Paste / Registers

- `<shift>+y` — nvim-tree: Copy Relative Path
- `c` — nvim-tree: Copy
- `ge` — nvim-tree: Copy Basename
- `gy` — nvim-tree: Copy Absolute Path
- `p` — nvim-tree: Paste
- `y` — nvim-tree: Copy Name

#### File Tree

- `-` — nvim-tree: Up
- `.` — nvim-tree: Run Command
- `<2-leftmouse>` — nvim-tree: Open
- `<2-rightmouse>` — nvim-tree: CD
- `<bs>` — nvim-tree: Close Directory
- `<ctrl>+e` — nvim-tree: Open: In Place
- `<ctrl>+k` — nvim-tree: Info
- `<ctrl>+t` — nvim-tree: Open: New Tab
- `<ctrl>+]` — nvim-tree: CD
- `<cr>` — nvim-tree: Open
- `<del>` — nvim-tree: Delete
- `<tab>` — nvim-tree: Open Preview
- `<lt>` — nvim-tree: Previous Sibling
- `>` — nvim-tree: Next Sibling
- `<shift>+d` — nvim-tree: Trash
- `<shift>+e` — nvim-tree: Expand All
- `<shift>+f` — nvim-tree: Live Filter: Clear
- `<shift>+h` — nvim-tree: Toggle Filter: Dotfiles
- `<shift>+j` — nvim-tree: Last Sibling
- `<shift>+k` — nvim-tree: First Sibling
- `<shift>+l` — nvim-tree: Toggle Group Empty
- `<shift>+m` — nvim-tree: Toggle Filter: No Bookmark
- `<shift>+p` — nvim-tree: Parent Directory
- `<shift>+r` — nvim-tree: Refresh
- `<shift>+u` — nvim-tree: Toggle Filter: Custom
- `<shift>+w` — nvim-tree: Collapse All
- `a` — nvim-tree: Create File Or Directory
- `bd` — nvim-tree: Delete Bookmarked
- `bmv` — nvim-tree: Move Bookmarked
- `bt` — nvim-tree: Trash Bookmarked
- `d` — nvim-tree: Delete
- `f` — nvim-tree: Live Filter: Start
- `g?` — nvim-tree: Help
- `m` — nvim-tree: Toggle Bookmark
- `o` — nvim-tree: Open
- `q` — nvim-tree: Close
- `s` — nvim-tree: Run System
- `x` — nvim-tree: Cut

#### Git

- `<shift>+c` — nvim-tree: Toggle Filter: Git Clean
- `<shift>+i` — nvim-tree: Toggle Filter: Git Ignored
- `[c` — nvim-tree: Prev Git
- `]c` — nvim-tree: Next Git

#### LSP / Code

- `<ctrl>+r` — nvim-tree: Rename: Omit Filename
- `[e` — nvim-tree: Prev Diagnostic
- `]e` — nvim-tree: Next Diagnostic
- `e` — nvim-tree: Rename: Basename
- `r` — nvim-tree: Rename
- `u` — nvim-tree: Rename: Full Path

#### Other

- `h` — <lua function>
- `l` — <lua function>

#### Search / Find

- `<shift>+s` — nvim-tree: Search

#### Windows / Splits

- `<ctrl>+v` — nvim-tree: Open: Vertical Split
- `<ctrl>+x` — nvim-tree: Open: Horizontal Split
- `<shift>+o` — nvim-tree: Open: No Window Picker

### Mode: Select (visual)

#### Copy / Paste / Registers

- `c` — nvim-tree: Copy
- `c` — nvim-tree: Copy

#### File Tree

- `<del>` — nvim-tree: Delete
- `<del>` — nvim-tree: Delete
- `<shift>+d` — nvim-tree: Trash
- `<shift>+d` — nvim-tree: Trash
- `d` — nvim-tree: Delete
- `d` — nvim-tree: Delete
- `m` — nvim-tree: Toggle Bookmark
- `m` — nvim-tree: Toggle Bookmark
- `x` — nvim-tree: Cut
- `x` — nvim-tree: Cut

