# Neovim Keymaps

## Focus: Editor

### Mode: Normal

#### Bookmarks / History

- ` !` — Toggle line favorite 1
- ` #` — Toggle line favorite 3
- ` $` — Toggle line favorite 4
- ` %` — Toggle line favorite 5
- ` &` — Toggle line favorite 7
- ` (` — Toggle line favorite 9
- ` )` — Toggle line favorite 0
- ` *` — Toggle line favorite 8
- ` 0` — Go to line favorite 0
- ` 1` — Go to line favorite 1
- ` 2` — Go to line favorite 2
- ` 3` — Go to line favorite 3
- ` 4` — Go to line favorite 4
- ` 5` — Go to line favorite 5
- ` 6` — Go to line favorite 6
- ` 7` — Go to line favorite 7
- ` 8` — Go to line favorite 8
- ` 9` — Go to line favorite 9
- ` @` — Toggle line favorite 2
- ` ^` — Toggle line favorite 6
- `<M-Left>` — Line history back
- `<M-Right>` — Line history forward

#### Buffers / Tabs

- ` b` — buffer new
- ` q` — Close current buffer or list
- ` x` — buffer close
- `<S-Tab>` — buffer goto prev
- `<Tab>` — buffer goto next

#### Comment

- ` /` — toggle comment
- `gc` — Toggle comment
- `gcc` — Toggle comment line

#### Copy / Paste / Registers

- `<C-C>` — general copy whole file

#### File Tree

- ` E` — Reveal current file in NvimTree
- ` e` — Focus NvimTree
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

#### LSP / Code

- ` d` — LSP go to definition
- ` ds` — LSP diagnostic loclist
- ` fm` — general format file
- ` gD` — LSP go to declaration
- ` gi` — LSP go to implementation
- ` r` — LSP references
- `<C-W><C-D>` — Show diagnostics under the cursor
- `<C-W>d` — Show diagnostics under the cursor
- `[D` — Jump to the first diagnostic in the current buffer
- `[d` — Jump to the previous diagnostic in the current buffer
- `]D` — Jump to the last diagnostic in the current buffer
- `]d` — Jump to the next diagnostic in the current buffer
- `gO` — vim.lsp.buf.document_symbol()
- `gra` — vim.lsp.buf.code_action()
- `gri` — vim.lsp.buf.implementation()
- `grn` — vim.lsp.buf.rename()
- `grr` — vim.lsp.buf.references()
- `grt` — vim.lsp.buf.type_definition()
- `grx` — vim.lsp.codelens.run()

#### Navigation / Movement

- ` n` — toggle line number
- `<C-H>` — Left 10 chars
- `<C-J>` — Down 10 lines
- `<C-K>` — Up 10 lines
- `<C-L>` — Right 10 chars
- `<M-C-J>` — Down 10 lines, keep cursor screen position
- `<M-C-K>` — Up 10 lines, keep cursor screen position
- `<M-j>` — Down one line, keep cursor screen position
- `<M-k>` — Up one line, keep cursor screen position
- `[ ` — Add empty line above cursor
- `] ` — Add empty line below cursor

#### Other

- ` ` — <lua function>
- ` ch` — toggle nvcheatsheet
- ` rn` — toggle relative number
- ` wK` — whichkey all keymaps
- `"` — <lua function>
- `&` — :help &-default
- `'` — <lua function>
- `;` — CMD enter command mode
- `<C-W>` — <lua function>
- `<Esc>` — general clear highlights
- `Y` — :help Y-default
- `[<C-L>` — :lpfile
- `[<C-Q>` — :cpfile
- `[<C-T>` — :ptprevious
- `[A` — :rewind
- `[B` — :brewind
- `[L` — :lrewind
- `[Q` — :crewind
- `[T` — :trewind
- `[a` — :previous
- `[b` — :bprevious
- `[l` — :lprevious
- `[t` — :tprevious
- `]<C-L>` — :lnfile
- `]<C-Q>` — :cnfile
- `]<C-T>` — :ptnext
- `]A` — :last
- `]B` — :blast
- `]L` — :llast
- `]Q` — :clast
- `]T` — :tlast
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

- `<C-S>` — Save file

#### Search / Find

- ` cm` — telescope git commits
- ` fa` — telescope find all files
- ` fb` — telescope find buffers
- ` ff` — Find files (space = wildcard, case-insensitive)
- ` fh` — telescope help page
- ` fo` — telescope find oldfiles
- ` fr` — Recent files
- ` fw` — Live grep (fixed-string first, regex fallback)
- ` fz` — telescope find in current buffer
- ` gt` — telescope git status
- ` ma` — telescope find marks
- ` pt` — telescope pick hidden term
- ` th` — telescope nvchad themes

#### Terminal

- ` h` — terminal new horizontal term
- ` v` — terminal new vertical term
- `<M-h>` — terminal toggleable horizontal term
- `<M-i>` — terminal toggle floating term
- `<M-v>` — terminal toggleable vertical term

#### Windows / Splits

- ` Q` — Quit current window
- ` o` — Focus editor window
- ` wh` — Move to left window
- ` wj` — Move to bottom window
- ` wk` — Move to top window
- ` wl` — Move to right window
- ` ws` — Split window horizontal
- ` wv` — Split window vertical
- ` ww` — Cycle windows
- `<C-N>` — nvimtree toggle window

### Mode: Edit (insert)

#### Navigation / Movement

- `<C-B>` — move beginning of line
- `<C-E>` — move end of line
- `<C-H>` — move left
- `<C-J>` — move down
- `<C-K>` — move up
- `<C-L>` — move right
- `<S-Tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<Tab>` — vim.snippet.jump if active, otherwise <Tab>

#### Other

- `<C-U>` — :help i_CTRL-U-default
- `<C-W>` — :help i_CTRL-W-default
- `jk` — <Esc>

#### Save / Quit

- `<C-S>` — Save file

### Mode: Select (visual)

#### Comment

- ` /` — toggle comment
- ` /` — toggle comment
- ` /` — toggle comment
- `gc` — Toggle comment
- `gc` — Toggle comment

#### Copy / Paste / Registers

- ` y` — Copy selection with path
- ` y` — Copy selection with path

#### File Tree

- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

#### LSP / Code

- ` fm` — general format file
- ` fm` — general format file
- `<C-S>` — vim.lsp.buf.signature_help()
- `<C-S>` — vim.lsp.buf.signature_help()
- `gra` — vim.lsp.buf.code_action()
- `gra` — vim.lsp.buf.code_action()

#### Navigation / Movement

- `<C-H>` — Left 10 chars
- `<C-H>` — Left 10 chars
- `<C-J>` — Down 10 lines
- `<C-J>` — Down 10 lines
- `<C-K>` — Up 10 lines
- `<C-K>` — Up 10 lines
- `<C-L>` — Right 10 chars
- `<C-L>` — Right 10 chars
- `<S-Tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<S-Tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<Tab>` — vim.snippet.jump if active, otherwise <Tab>
- `<Tab>` — vim.snippet.jump if active, otherwise <Tab>

#### Other

- `#` — :help v_#-default
- `#` — :help v_#-default
- `*` — :help v_star-default
- `*` — :help v_star-default
- `@` — :help v_@-default
- `@` — :help v_@-default
- `Q` — :help v_Q-default
- `Q` — :help v_Q-default
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

- `<C-X>` — terminal escape terminal mode
- `<M-h>` — terminal toggleable horizontal term
- `<M-i>` — terminal toggle floating term
- `<M-v>` — terminal toggleable vertical term

### Mode: Operator

#### Comment

- `gc` — Comment textobject

#### Other

- `an` — Select parent (outer) node
- `in` — Select child (inner) node

## Focus: Tree (NvimTree)

### Mode: Normal

#### Buffers / Tabs

- `B` — nvim-tree: Toggle Filter: No Buffer

#### Copy / Paste / Registers

- `Y` — nvim-tree: Copy Relative Path
- `c` — nvim-tree: Copy
- `ge` — nvim-tree: Copy Basename
- `gy` — nvim-tree: Copy Absolute Path
- `p` — nvim-tree: Paste
- `y` — nvim-tree: Copy Name

#### File Tree

- `-` — nvim-tree: Up
- `.` — nvim-tree: Run Command
- `<2-LeftMouse>` — nvim-tree: Open
- `<2-RightMouse>` — nvim-tree: CD
- `<BS>` — nvim-tree: Close Directory
- `<C-E>` — nvim-tree: Open: In Place
- `<C-K>` — nvim-tree: Info
- `<C-T>` — nvim-tree: Open: New Tab
- `<C-]>` — nvim-tree: CD
- `<CR>` — nvim-tree: Open
- `<Del>` — nvim-tree: Delete
- `<Tab>` — nvim-tree: Open Preview
- `<lt>` — nvim-tree: Previous Sibling
- `>` — nvim-tree: Next Sibling
- `D` — nvim-tree: Trash
- `E` — nvim-tree: Expand All
- `F` — nvim-tree: Live Filter: Clear
- `H` — nvim-tree: Toggle Filter: Dotfiles
- `J` — nvim-tree: Last Sibling
- `K` — nvim-tree: First Sibling
- `L` — nvim-tree: Toggle Group Empty
- `M` — nvim-tree: Toggle Filter: No Bookmark
- `P` — nvim-tree: Parent Directory
- `R` — nvim-tree: Refresh
- `U` — nvim-tree: Toggle Filter: Custom
- `W` — nvim-tree: Collapse All
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

- `C` — nvim-tree: Toggle Filter: Git Clean
- `I` — nvim-tree: Toggle Filter: Git Ignored
- `[c` — nvim-tree: Prev Git
- `]c` — nvim-tree: Next Git

#### LSP / Code

- `<C-R>` — nvim-tree: Rename: Omit Filename
- `[e` — nvim-tree: Prev Diagnostic
- `]e` — nvim-tree: Next Diagnostic
- `e` — nvim-tree: Rename: Basename
- `r` — nvim-tree: Rename
- `u` — nvim-tree: Rename: Full Path

#### Other

- `h` — <lua function>
- `l` — <lua function>

#### Search / Find

- `S` — nvim-tree: Search

#### Windows / Splits

- `<C-V>` — nvim-tree: Open: Vertical Split
- `<C-X>` — nvim-tree: Open: Horizontal Split
- `O` — nvim-tree: Open: No Window Picker

### Mode: Select (visual)

#### Copy / Paste / Registers

- `c` — nvim-tree: Copy
- `c` — nvim-tree: Copy

#### File Tree

- `<Del>` — nvim-tree: Delete
- `<Del>` — nvim-tree: Delete
- `D` — nvim-tree: Trash
- `D` — nvim-tree: Trash
- `d` — nvim-tree: Delete
- `d` — nvim-tree: Delete
- `m` — nvim-tree: Toggle Bookmark
- `m` — nvim-tree: Toggle Bookmark
- `x` — nvim-tree: Cut
- `x` — nvim-tree: Cut

