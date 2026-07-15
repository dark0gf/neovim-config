local M = {}

-- Mode codes grouped into the three buckets the user cares about.
-- Any mode not listed here is collected under "Other".
local MODE_GROUPS = {
  { name = "Normal", codes = { "n" } },
  { name = "Edit (insert)", codes = { "i" } },
  { name = "Select (visual)", codes = { "x", "v", "s" } },
  { name = "Command", codes = { "c" } },
  { name = "Terminal", codes = { "t" } },
  { name = "Operator", codes = { "o" } },
}

-- Ordered domain rules. First match wins, checked against desc then lhs.
local DOMAIN_RULES = {
  { name = "Copy / Paste / Registers", pats = { "yank", "copy", "paste", "put", "register", "clipboard", "duplicate" } },
  { name = "Search / Find", pats = { "search", "grep", "find", "telescope", "oldfiles", "recent", "buffers", "help tags" } },
  { name = "LSP / Code", pats = { "lsp", "definition", "reference", "implementation", "declaration", "hover", "rename", "code action", "signature", "symbol", "diagnostic", "format" } },
  { name = "Git", pats = { "git", "hunk", "blame", "diff", "stage" } },
  { name = "Windows / Splits", pats = { "window", "split", "pane" } },
  { name = "Buffers / Tabs", pats = { "buffer", "tabufline", "tab " } },
  { name = "File Tree", pats = { "tree", "nvimtree", "explorer", "reveal" } },
  { name = "Quickfix / Lists", pats = { "quickfix", "loclist", "list" } },
  { name = "Comment", pats = { "comment" } },
  { name = "Fold", pats = { "fold" } },
  { name = "Terminal", pats = { "terminal", "term" } },
  { name = "Save / Quit", pats = { "save", "write file", "quit", "close" } },
  { name = "Bookmarks / History", pats = { "favorite", "bookmark", "history", "mark" } },
  { name = "Navigation / Movement", pats = { "move", "cursor", "line", "up ", "down ", "left", "right", "scroll", "word", "jump", "goto", "go to", "top", "bottom", "char" } },
}

local function classify(lhs, desc)
  local hay_desc = (desc or ""):lower()
  local hay_lhs = (lhs or ""):lower()
  for _, rule in ipairs(DOMAIN_RULES) do
    for _, p in ipairs(rule.pats) do
      if hay_desc:find(p, 1, true) or hay_lhs:find(p, 1, true) then
        return rule.name
      end
    end
  end
  return "Other"
end

-- Normalize a raw keymap entry into { lhs, desc }, or nil to skip it.
local function normalize(km)
  local lhs = km.lhs or ""
  if lhs == "" or lhs:find("^<Plug>") or lhs:find("^<SNR>") then
    return nil
  end
  local desc = km.desc
  if not desc or desc == "" then
    desc = km.rhs or (km.callback and "<lua function>") or ""
  end
  return { lhs = lhs, desc = desc }
end

-- Collect maps for one mode-group from a source (global or a buffer).
-- Returns a table: domain -> list of { lhs, desc }.
local function collect(codes, bufnr)
  local by_domain = {}
  for _, code in ipairs(codes) do
    local raw = bufnr and vim.api.nvim_buf_get_keymap(bufnr, code)
      or vim.api.nvim_get_keymap(code)
    for _, km in ipairs(raw) do
      local n = normalize(km)
      if n then
        local d = classify(n.lhs, n.desc)
        by_domain[d] = by_domain[d] or {}
        table.insert(by_domain[d], n)
      end
    end
  end
  return by_domain
end

-- Find the first NvimTree buffer (buffer-local maps live there).
local function find_tree_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "NvimTree" then
      return buf
    end
  end
  return nil
end

local function sorted_keys(t)
  local keys = {}
  for k in pairs(t) do
    keys[#keys + 1] = k
  end
  table.sort(keys)
  return keys
end

-- Render one focus section (editor or tree) into markdown lines.
local function render_focus(lines, title, bufnr, tree_only)
  table.insert(lines, "## Focus: " .. title)
  table.insert(lines, "")
  local any_mode = false
  for _, group in ipairs(MODE_GROUPS) do
    local by_domain = collect(group.codes, bufnr)
    -- For the tree buffer, global maps also apply; skip empty groups quietly.
    local domains = sorted_keys(by_domain)
    if #domains > 0 then
      any_mode = true
      table.insert(lines, "### Mode: " .. group.name)
      table.insert(lines, "")
      for _, domain in ipairs(domains) do
        local entries = by_domain[domain]
        table.sort(entries, function(a, b)
          return a.lhs < b.lhs
        end)
        table.insert(lines, "#### " .. domain)
        table.insert(lines, "")
        for _, e in ipairs(entries) do
          local desc = e.desc:gsub("\n", " ")
          table.insert(lines, string.format("- `%s` — %s", e.lhs, desc))
        end
        table.insert(lines, "")
      end
    end
  end
  if not any_mode then
    table.insert(lines, "_No keymaps found. Open the tree first (`<leader>e`)._")
    table.insert(lines, "")
  end
  local _ = tree_only
end

-- Build the full document and write it to `path`.
function M.generate(path)
  path = path or (vim.fn.getcwd() .. "/keymaps.md")
  local lines = { "# Neovim Keymaps", "" }

  render_focus(lines, "Editor", nil)

  local tree_buf = find_tree_buf()
  if tree_buf then
    render_focus(lines, "Tree (NvimTree)", tree_buf)
  else
    table.insert(lines, "## Focus: Tree (NvimTree)")
    table.insert(lines, "")
    table.insert(lines, "_NvimTree buffer not open. Run `<leader>e` then re-run `:KeymapDoc`._")
    table.insert(lines, "")
  end

  vim.fn.writefile(lines, path)
  return path
end

function M.setup()
  vim.api.nvim_create_user_command("KeymapDoc", function(opts)
    local path = opts.args ~= "" and opts.args or nil
    local out = M.generate(path)
    vim.notify("Keymaps written to " .. out)
    vim.cmd("edit " .. vim.fn.fnameescape(out))
  end, {
    nargs = "?",
    complete = "file",
    desc = "Dump all keymaps to markdown, grouped by focus/mode/domain",
  })
end

return M
