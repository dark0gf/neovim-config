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

-- Modifier prefixes inside <...> tokens -> readable names.
-- nvim normalizes <A-...> to <M-...>, so both map to "alt".
local MOD_MAP = { C = "ctrl", A = "alt", M = "alt", S = "shift", D = "cmd", T = "meta" }

-- US-layout shifted symbols -> their unshifted base key.
local SHIFT_SYM = {
  ["!"] = "1", ["@"] = "2", ["#"] = "3", ["$"] = "4", ["%"] = "5",
  ["^"] = "6", ["&"] = "7", ["*"] = "8", ["("] = "9", [")"] = "0",
  ["_"] = "-", ["+"] = "=", ["{"] = "[", ["}"] = "]", ["|"] = "\\",
  [":"] = ";", ['"'] = "'", ["?"] = "/", ["~"] = "`",
}

local function split_dash(s)
  local out = {}
  for part in (s .. "-"):gmatch("(.-)%-") do
    out[#out + 1] = part
  end
  return out
end

-- Render one key token (the part after modifiers inside <...>).
local function render_key(key)
  if #key == 0 then
    return ""
  end
  if #key == 1 then
    -- single char: letters lowercased, symbols kept as-is
    return key:match("%a") and key:lower() or key
  end
  -- named key: <cr>, <tab>, <left>, <f5>, ...
  return "<" .. key:lower() .. ">"
end

-- Render the inside of a <...> token: <C-A-k> -> <ctrl>+<alt>+k
local function render_bracket(inner)
  local parts = split_dash(inner)
  if #parts <= 1 then
    -- no modifiers: <CR>, <Tab>, <Left>, or a lone char
    return render_key(inner)
  end
  local pieces = {}
  local i = 1
  while i < #parts and MOD_MAP[parts[i]] do
    pieces[#pieces + 1] = "<" .. MOD_MAP[parts[i]] .. ">"
    i = i + 1
  end
  local key = table.concat({ unpack(parts, i) }, "-")
  pieces[#pieces + 1] = render_key(key)
  return table.concat(pieces, "+")
end

-- Turn a raw lhs into readable keys.
-- Leader -> <leader>, <C-x> -> <ctrl>+x, capitals -> <shift>+<char>, space -> <space>.
local function pretty_lhs(lhs)
  local out = {}
  local leader = vim.g.mapleader
  local rest = lhs
  if type(leader) == "string" and #leader > 0 and rest:sub(1, #leader) == leader then
    out[#out + 1] = "<leader>"
    rest = rest:sub(#leader + 1)
  end

  local i, n = 1, #rest
  while i <= n do
    local c = rest:sub(i, i)
    if c == "<" then
      local close = rest:find(">", i + 1, true)
      if close then
        out[#out + 1] = render_bracket(rest:sub(i + 1, close - 1))
        i = close + 1
      else
        out[#out + 1] = c
        i = i + 1
      end
    elseif c == " " then
      out[#out + 1] = "<space>"
      i = i + 1
    elseif c:match("%u") then
      out[#out + 1] = "<shift>+" .. c:lower()
      i = i + 1
    elseif SHIFT_SYM[c] then
      out[#out + 1] = "<shift>+" .. SHIFT_SYM[c]
      i = i + 1
    else
      out[#out + 1] = c
      i = i + 1
    end
  end
  return table.concat(out)
end

-- Normalize a raw keymap entry into { lhs, pretty, desc }, or nil to skip it.
local function normalize(km)
  local lhs = km.lhs or ""
  if lhs == "" or lhs:find("^<Plug>") or lhs:find("^<SNR>") then
    return nil
  end
  local desc = km.desc
  if not desc or desc == "" then
    desc = km.rhs or (km.callback and "<lua function>") or ""
  end
  return { lhs = lhs, pretty = pretty_lhs(lhs), desc = desc }
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
          return a.pretty < b.pretty
        end)
        table.insert(lines, "#### " .. domain)
        table.insert(lines, "")
        for _, e in ipairs(entries) do
          local desc = e.desc:gsub("\n", " ")
          table.insert(lines, string.format("- `%s` — %s", e.pretty, desc))
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
