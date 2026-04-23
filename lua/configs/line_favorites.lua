local M = {}

local line_favorites_dir = vim.fn.stdpath("data") .. "/line_favorites"
local line_favorites_sign_group = "LineFavoritesSigns"
local jump_slots = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

local function get_project_root()
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local git_dir = vim.fs.find(".git", { path = cwd, upward = true, type = "directory" })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end
  return cwd
end

local function get_line_favorites_file()
  local root = get_project_root()
  local project_name = vim.fn.fnamemodify(root, ":t")
  if project_name == "" then
    project_name = "project"
  end

  project_name = project_name:gsub("[^%w%-_]", "_")
  local hash = vim.fn.sha256(root):sub(1, 12)
  return line_favorites_dir .. "/" .. project_name .. "_" .. hash .. ".json"
end

local function load_line_favorites()
  local line_favorites_file = get_line_favorites_file()
  local f = io.open(line_favorites_file, "r")
  if not f then
    return {}
  end

  local content = f:read("*a")
  f:close()

  if not content or content == "" then
    return {}
  end

  local ok, decoded = pcall(vim.json.decode, content)
  if ok and type(decoded) == "table" then
    return decoded
  end

  return {}
end

local function save_line_favorites(favorites)
  vim.fn.mkdir(line_favorites_dir, "p")
  local line_favorites_file = get_line_favorites_file()
  local ok, encoded = pcall(vim.json.encode, favorites)
  if not ok then
    vim.notify("Failed to encode line favorites", vim.log.levels.ERROR)
    return
  end

  local f = io.open(line_favorites_file, "w")
  if not f then
    vim.notify("Failed to write line favorites file", vim.log.levels.ERROR)
    return
  end

  f:write(encoded)
  f:close()
end

local function same_file(a, b)
  if a == b then
    return true
  end

  local ra = vim.uv.fs_realpath(a)
  local rb = vim.uv.fs_realpath(b)
  return ra ~= nil and rb ~= nil and ra == rb
end

function M.refresh_signs(bufnr)
  if bufnr == nil or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  vim.fn.sign_unplace(line_favorites_sign_group, { buffer = bufnr })

  local current_file = vim.api.nvim_buf_get_name(bufnr)
  if current_file == "" then
    return
  end

  local max_line = vim.api.nvim_buf_line_count(bufnr)
  local line_favorites = load_line_favorites()
  for _, slot in ipairs(jump_slots) do
    local favorite = line_favorites[slot]
    if favorite and favorite.file and favorite.line and same_file(favorite.file, current_file) then
      local line = math.max(1, math.min(favorite.line, max_line))
      vim.fn.sign_place(
        1000 + tonumber(slot),
        line_favorites_sign_group,
        "LineFavorite" .. slot,
        bufnr,
        { lnum = line, priority = 30 }
      )
    end
  end
end

function M.set(slot)
  local line_favorites = load_line_favorites()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Cannot save favorite for unnamed buffer", vim.log.levels.WARN)
    return
  end

  line_favorites[slot] = {
    file = file,
    line = vim.api.nvim_win_get_cursor(0)[1],
  }
  save_line_favorites(line_favorites)
  M.refresh_signs()
  vim.notify("Saved line favorite " .. slot, vim.log.levels.INFO)
end

function M.remove(slot)
  local line_favorites = load_line_favorites()
  if not line_favorites[slot] then
    vim.notify("Favorite " .. slot .. " is empty", vim.log.levels.WARN)
    return
  end

  line_favorites[slot] = nil
  save_line_favorites(line_favorites)
  M.refresh_signs()
  vim.notify("Removed line favorite " .. slot, vim.log.levels.INFO)
end

function M.toggle(slot)
  local line_favorites = load_line_favorites()
  local favorite = line_favorites[slot]
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  if favorite and favorite.file and favorite.line and same_file(favorite.file, current_file) and favorite.line == current_line then
    M.remove(slot)
    return
  end

  M.set(slot)
end

function M.jump(slot)
  local line_favorites = load_line_favorites()
  local favorite = line_favorites[slot]
  if not favorite then
    vim.notify("Favorite " .. slot .. " is empty", vim.log.levels.WARN)
    return
  end

  if not vim.uv.fs_stat(favorite.file) then
    vim.notify("Favorite file not found: " .. favorite.file, vim.log.levels.ERROR)
    return
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" or not same_file(current_file, favorite.file) then
    vim.cmd("hide edit " .. vim.fn.fnameescape(favorite.file))
  end

  local max_line = vim.api.nvim_buf_line_count(0)
  local target = math.max(1, math.min(favorite.line or 1, max_line))
  vim.api.nvim_win_set_cursor(0, { target, 0 })
  vim.cmd "normal! zz"
  M.refresh_signs()
end

function M.setup()
  if M._is_setup then
    return
  end
  M._is_setup = true

  for _, slot in ipairs(jump_slots) do
    vim.fn.sign_define("LineFavorite" .. slot, {
      text = slot,
      texthl = "DiagnosticHint",
    })
  end

  local group = vim.api.nvim_create_augroup("LineFavorites", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = group,
    callback = function(args)
      M.refresh_signs(args.buf)
    end,
  })
end

return M