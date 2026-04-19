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

local function find_project_root(bufnr, file_path)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local root_dir = client.config.root_dir

    if type(root_dir) == "string" and root_dir ~= "" then
      root_dir = normalize_path(root_dir)

      if file_path == root_dir or vim.startswith(file_path, root_dir .. path_sep) then
        return root_dir
      end
    end
  end

  local git_dir = vim.fs.find(".git", {
    path = vim.fs.dirname(file_path),
    upward = true,
  })[1]

  if git_dir then
    return normalize_path(vim.fs.dirname(git_dir))
  end

  return normalize_path(vim.uv.cwd() or vim.fn.getcwd())
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
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.api.nvim_buf_get_name(bufnr)

  if file_path == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local selection = get_visual_selection()

  if selection == "" then
    return
  end

  file_path = normalize_path(file_path)

  local root = find_project_root(bufnr, file_path)
  local payload = "@" .. relative_path(root, file_path) .. "\n" .. selection

  vim.fn.setreg('"', payload, "v")
  pcall(vim.fn.setreg, "+", payload, "v")
  pcall(vim.fn.setreg, "*", payload, "v")

  vim.notify("Copied selection with path", vim.log.levels.INFO)
end

return M