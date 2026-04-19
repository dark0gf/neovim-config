local api = require "nvim-tree.api"
local uv = vim.uv or vim.loop

local OpenedFolderDecorator = api.Decorator:extend()

local path_sep = package.config:sub(1, 1)
local is_windows = path_sep == "\\"

local function normalize_path(path)
  local normalized = uv.fs_realpath(path) or path

  if is_windows then
    normalized = normalized:lower()
  end

  return normalized
end

local function get_open_buffer_paths()
  local seen = {}
  local open_paths = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufloaded(bufnr) == 1 then
      local path = vim.api.nvim_buf_get_name(bufnr)

      if path ~= "" then
        path = normalize_path(path)

        if not seen[path] then
          seen[path] = true
          table.insert(open_paths, path)
        end
      end
    end
  end

  return open_paths
end

function OpenedFolderDecorator:new()
  self.enabled = true
  self.highlight_range = "name"
  self.icon_placement = "none"
  self.open_buffer_paths = get_open_buffer_paths()
end

function OpenedFolderDecorator:highlight_group(node)
  if node.type ~= "directory" or not node.absolute_path then
    return nil
  end

  local directory_prefix = normalize_path(node.absolute_path) .. path_sep

  for _, open_path in ipairs(self.open_buffer_paths) do
    if vim.startswith(open_path, directory_prefix) then
      return "NvimTreeOpenedHL"
    end
  end

  return nil
end

return OpenedFolderDecorator