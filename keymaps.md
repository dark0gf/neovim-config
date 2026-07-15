# Neovim Keymaps

## Focus: Editor

### Mode: Normal

<details>
<summary>Bookmarks / History (22)</summary>

- `<alt>+<left>` — Line history back
- `<alt>+<right>` — Line history forward
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
- `<leader><shift>+0` — Toggle line favorite 0
- `<leader><shift>+1` — Toggle line favorite 1
- `<leader><shift>+2` — Toggle line favorite 2
- `<leader><shift>+3` — Toggle line favorite 3
- `<leader><shift>+4` — Toggle line favorite 4
- `<leader><shift>+5` — Toggle line favorite 5
- `<leader><shift>+6` — Toggle line favorite 6
- `<leader><shift>+7` — Toggle line favorite 7
- `<leader><shift>+8` — Toggle line favorite 8
- `<leader><shift>+9` — Toggle line favorite 9

</details>

<details>
<summary>Buffers / Tabs (5)</summary>

- `<leader>b` — buffer new
- `<leader>q` — Close current buffer or list
- `<leader>x` — buffer close
- `<shift>+<tab>` — buffer goto prev
- `<tab>` — buffer goto next

</details>

<details>
<summary>Comment (3)</summary>

- `<leader>/` — toggle comment
- `gc` — Toggle comment
- `gcc` — Toggle comment line

</details>

<details>
<summary>Copy / Paste / Registers (1)</summary>

- `<ctrl>+c` — general copy whole file

</details>

<details>
<summary>File Tree (3)</summary>

- `<leader><shift>+e` — Reveal current file in NvimTree
- `<leader>e` — Focus NvimTree
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

</details>

<details>
<summary>LSP / Code (19)</summary>

- `<ctrl>+w<ctrl>+d` — Show diagnostics under the cursor
- `<ctrl>+wd` — Show diagnostics under the cursor
- `<leader>d` — LSP go to definition
- `<leader>ds` — LSP diagnostic loclist
- `<leader>fm` — general format file
- `<leader>g<shift>+d` — LSP go to declaration
- `<leader>gi` — LSP go to implementation
- `<leader>r` — LSP references
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

</details>

<details>
<summary>Navigation / Movement (11)</summary>

- `<alt>+<ctrl>+j` — Down 10 lines, keep cursor screen position
- `<alt>+<ctrl>+k` — Up 10 lines, keep cursor screen position
- `<alt>+j` — Down one line, keep cursor screen position
- `<alt>+k` — Up one line, keep cursor screen position
- `<ctrl>+h` — Left 10 chars
- `<ctrl>+j` — Down 10 lines
- `<ctrl>+k` — Up 10 lines
- `<ctrl>+l` — Right 10 chars
- `<leader>n` — toggle line number
- `[<space>` — Add empty line above cursor
- `]<space>` — Add empty line below cursor

</details>

<details>
<summary>Other (39)</summary>

- `'` — <lua function>
- `;` — CMD enter command mode
- `<ctrl>+w` — <lua function>
- `<esc>` — general clear highlights
- `<leader>` — <lua function>
- `<leader>ch` — toggle nvcheatsheet
- `<leader>rn` — toggle relative number
- `<leader>w<shift>+k` — whichkey all keymaps
- `<shift>+'` — <lua function>
- `<shift>+7` — :help &-default
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

</details>

<details>
<summary>Quickfix / Lists (2)</summary>

- `[q` — Prev quickfix
- `]q` — Next quickfix

</details>

<details>
<summary>Save / Quit (1)</summary>

- `<ctrl>+s` — Save file

</details>

<details>
<summary>Search / Find (13)</summary>

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

</details>

<details>
<summary>Terminal (5)</summary>

- `<alt>+h` — terminal toggleable horizontal term
- `<alt>+i` — terminal toggle floating term
- `<alt>+v` — terminal toggleable vertical term
- `<leader>h` — terminal new horizontal term
- `<leader>v` — terminal new vertical term

</details>

<details>
<summary>Windows / Splits (10)</summary>

- `<ctrl>+n` — nvimtree toggle window
- `<leader><shift>+q` — Quit current window
- `<leader>o` — Focus editor window
- `<leader>wh` — Move to left window
- `<leader>wj` — Move to bottom window
- `<leader>wk` — Move to top window
- `<leader>wl` — Move to right window
- `<leader>ws` — Split window horizontal
- `<leader>wv` — Split window vertical
- `<leader>ww` — Cycle windows

</details>

### Mode: Edit (insert)

<details>
<summary>Navigation / Movement (8)</summary>

- `<ctrl>+b` — move beginning of line
- `<ctrl>+e` — move end of line
- `<ctrl>+h` — move left
- `<ctrl>+j` — move down
- `<ctrl>+k` — move up
- `<ctrl>+l` — move right
- `<shift>+<tab>` — vim.snippet.jump if active, otherwise <S-Tab>
- `<tab>` — vim.snippet.jump if active, otherwise <Tab>

</details>

<details>
<summary>Other (3)</summary>

- `<ctrl>+u` — :help i_CTRL-U-default
- `<ctrl>+w` — :help i_CTRL-W-default
- `jk` — <Esc>

</details>

<details>
<summary>Save / Quit (1)</summary>

- `<ctrl>+s` — Save file

</details>

### Mode: Select (visual)

<details>
<summary>Comment (5)</summary>

- `<leader>/` — toggle comment
- `<leader>/` — toggle comment
- `<leader>/` — toggle comment
- `gc` — Toggle comment
- `gc` — Toggle comment

</details>

<details>
<summary>Copy / Paste / Registers (2)</summary>

- `<leader>y` — Copy selection with path
- `<leader>y` — Copy selection with path

</details>

<details>
<summary>File Tree (2)</summary>

- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)
- `gx` — Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)

</details>

<details>
<summary>LSP / Code (6)</summary>

- `<ctrl>+s` — vim.lsp.buf.signature_help()
- `<ctrl>+s` — vim.lsp.buf.signature_help()
- `<leader>fm` — general format file
- `<leader>fm` — general format file
- `gra` — vim.lsp.buf.code_action()
- `gra` — vim.lsp.buf.code_action()

</details>

<details>
<summary>Navigation / Movement (12)</summary>

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

</details>

<details>
<summary>Other (16)</summary>

- `<shift>+2` — :help v_@-default
- `<shift>+2` — :help v_@-default
- `<shift>+3` — :help v_#-default
- `<shift>+3` — :help v_#-default
- `<shift>+8` — :help v_star-default
- `<shift>+8` — :help v_star-default
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

</details>

### Mode: Terminal

<details>
<summary>Terminal (4)</summary>

- `<alt>+h` — terminal toggleable horizontal term
- `<alt>+i` — terminal toggle floating term
- `<alt>+v` — terminal toggleable vertical term
- `<ctrl>+x` — terminal escape terminal mode

</details>

### Mode: Operator

<details>
<summary>Comment (1)</summary>

- `gc` — Comment textobject

</details>

<details>
<summary>Other (2)</summary>

- `an` — Select parent (outer) node
- `in` — Select child (inner) node

</details>

## Focus: Tree (NvimTree)

### Mode: Normal

<details>
<summary>Buffers / Tabs (1)</summary>

- `<shift>+b` — nvim-tree: Toggle Filter: No Buffer

</details>

<details>
<summary>Copy / Paste / Registers (6)</summary>

- `<shift>+y` — nvim-tree: Copy Relative Path
- `c` — nvim-tree: Copy
- `ge` — nvim-tree: Copy Basename
- `gy` — nvim-tree: Copy Absolute Path
- `p` — nvim-tree: Paste
- `y` — nvim-tree: Copy Name

</details>

<details>
<summary>File Tree (38)</summary>

- `-` — nvim-tree: Up
- `.` — nvim-tree: Run Command
- `<2-leftmouse>` — nvim-tree: Open
- `<2-rightmouse>` — nvim-tree: CD
- `<bs>` — nvim-tree: Close Directory
- `<cr>` — nvim-tree: Open
- `<ctrl>+]` — nvim-tree: CD
- `<ctrl>+e` — nvim-tree: Open: In Place
- `<ctrl>+k` — nvim-tree: Info
- `<ctrl>+t` — nvim-tree: Open: New Tab
- `<del>` — nvim-tree: Delete
- `<lt>` — nvim-tree: Previous Sibling
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
- `<tab>` — nvim-tree: Open Preview
- `>` — nvim-tree: Next Sibling
- `a` — nvim-tree: Create File Or Directory
- `bd` — nvim-tree: Delete Bookmarked
- `bmv` — nvim-tree: Move Bookmarked
- `bt` — nvim-tree: Trash Bookmarked
- `d` — nvim-tree: Delete
- `f` — nvim-tree: Live Filter: Start
- `g<shift>+/` — nvim-tree: Help
- `m` — nvim-tree: Toggle Bookmark
- `o` — nvim-tree: Open
- `q` — nvim-tree: Close
- `s` — nvim-tree: Run System
- `x` — nvim-tree: Cut

</details>

<details>
<summary>Git (4)</summary>

- `<shift>+c` — nvim-tree: Toggle Filter: Git Clean
- `<shift>+i` — nvim-tree: Toggle Filter: Git Ignored
- `[c` — nvim-tree: Prev Git
- `]c` — nvim-tree: Next Git

</details>

<details>
<summary>LSP / Code (6)</summary>

- `<ctrl>+r` — nvim-tree: Rename: Omit Filename
- `[e` — nvim-tree: Prev Diagnostic
- `]e` — nvim-tree: Next Diagnostic
- `e` — nvim-tree: Rename: Basename
- `r` — nvim-tree: Rename
- `u` — nvim-tree: Rename: Full Path

</details>

<details>
<summary>Other (2)</summary>

- `h` — <lua function>
- `l` — <lua function>

</details>

<details>
<summary>Search / Find (1)</summary>

- `<shift>+s` — nvim-tree: Search

</details>

<details>
<summary>Windows / Splits (3)</summary>

- `<ctrl>+v` — nvim-tree: Open: Vertical Split
- `<ctrl>+x` — nvim-tree: Open: Horizontal Split
- `<shift>+o` — nvim-tree: Open: No Window Picker

</details>

### Mode: Select (visual)

<details>
<summary>Copy / Paste / Registers (2)</summary>

- `c` — nvim-tree: Copy
- `c` — nvim-tree: Copy

</details>

<details>
<summary>File Tree (10)</summary>

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

</details>

