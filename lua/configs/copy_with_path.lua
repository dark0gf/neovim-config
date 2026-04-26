local M = {}

local path_sep = package.config:sub(1, 1)

local function normalize_path(path)
  local real_path = vim.uv.fs_realpath(path)
  return vim.fs.normalize(real_path or path)
end

local function relative_path(root, path)
  root = normalize_path(root)
  path = normalize_path(path)

  if path == root then
    return vim.fs.basename(path)
  end

  local prefix = root .. path_sep

  if vim.startswith(path, prefix) then
    return path:sub(#prefix + 1)
  end

  return path
end

local function get_visual_selection()
  local saved_register = {
    value = vim.fn.getreg("z"),
    type = vim.fn.getregtype("z"),
  }

  vim.cmd('normal! "zy')

  local selection = vim.fn.getreg("z")
  vim.fn.setreg("z", saved_register.value, saved_register.type)

  return selection
end

function M.copy_visual_selection()
  local file_path = vim.api.nvim_buf_get_name(0)

  if file_path == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local selection = get_visual_selection()

  if selection == "" then
    return
  end

  file_path = normalize_path(file_path)
  local cwd = normalize_path(vim.uv.cwd() or vim.fn.getcwd())
  local payload = "@" .. relative_path(cwd, file_path) .. "\n" .. selection

  vim.fn.setreg('"', payload, "v")
  pcall(vim.fn.setreg, "+", payload, "v")
  pcall(vim.fn.setreg, "*", payload, "v")

  vim.notify("Copied selection with path", vim.log.levels.INFO)
end

return M