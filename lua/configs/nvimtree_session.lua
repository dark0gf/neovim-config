local M = {}

local is_setup = false
local is_restoring = false
local pending_state
local last_state

local path_sep = package.config:sub(1, 1)

local function get_loaded_api()
  return package.loaded["nvim-tree.api"]
end

local function path_depth(path)
  local _, count = path:gsub(vim.pesc(path_sep), "")
  return count
end

local function sort_paths(paths)
  table.sort(paths, function(left, right)
    local left_depth = path_depth(left)
    local right_depth = path_depth(right)

    if left_depth == right_depth then
      return left < right
    end

    return left_depth < right_depth
  end)
end

local function normalize_state(state)
  if type(state) ~= "table" then
    return nil
  end

  local seen = {}
  local open_dirs = {}

  for _, path in ipairs(state.open_dirs or {}) do
    if type(path) == "string" and path ~= "" and not seen[path] then
      seen[path] = true
      table.insert(open_dirs, path)
    end
  end

  sort_paths(open_dirs)

  return {
    open_dirs = open_dirs,
    focused_path = type(state.focused_path) == "string" and state.focused_path or nil,
  }
end

local function collect_open_dirs(nodes, open_dirs, seen)
  for _, node in ipairs(nodes or {}) do
    if node.type == "directory" then
      if node.open and node.absolute_path and not seen[node.absolute_path] then
        seen[node.absolute_path] = true
        table.insert(open_dirs, node.absolute_path)
      end

      if node.nodes and #node.nodes > 0 then
        collect_open_dirs(node.nodes, open_dirs, seen)
      end
    end
  end
end

local function snapshot_state(api)
  if not api.tree.is_visible() then
    return nil
  end

  local open_dirs = {}
  collect_open_dirs(api.tree.get_nodes(), open_dirs, {})
  sort_paths(open_dirs)

  local focused = api.tree.get_node_under_cursor()

  return {
    open_dirs = open_dirs,
    focused_path = focused and focused.absolute_path or nil,
  }
end

local function has_state(state)
  return state and (#state.open_dirs > 0 or state.focused_path ~= nil)
end

local function find_node_by_path(nodes, path)
  for _, node in ipairs(nodes or {}) do
    if node.absolute_path == path then
      return node
    end

    local found = find_node_by_path(node.nodes, path)
    if found then
      return found
    end
  end

  return nil
end

local function restore_open_dirs(api, open_dirs)
  local remaining = {}

  for _, path in ipairs(open_dirs) do
    local node = find_node_by_path(api.tree.get_nodes(), path)

    if node and node.type == "directory" then
      if not node.open then
        pcall(api.node.open.edit, node)
      end
    else
      table.insert(remaining, path)
    end
  end

  return remaining
end

local function apply_pending_state()
  local api = get_loaded_api()
  if not api or not pending_state or not api.tree.is_visible() or is_restoring then
    return
  end

  is_restoring = true

  pending_state.open_dirs = restore_open_dirs(api, pending_state.open_dirs)

  if #pending_state.open_dirs > 0 then
    is_restoring = false
    return
  end

  if pending_state.focused_path then
    pcall(api.tree.find_file, { buf = pending_state.focused_path, focus = false })
  end

  last_state = snapshot_state(api) or pending_state
  pending_state = nil
  is_restoring = false
end

function M.setup()
  if is_setup then
    return
  end

  is_setup = true

  local api = require "nvim-tree.api"
  local Event = api.events.Event

  api.events.subscribe(Event.TreeRendered, function()
    if pending_state then
      vim.schedule(apply_pending_state)
      return
    end

    last_state = snapshot_state(api) or last_state
  end)
end

function M.save_extra_data()
  local api = get_loaded_api()
  if api and api.tree.is_visible() then
    last_state = snapshot_state(api) or last_state
  end

  if not has_state(last_state) then
    return nil
  end

  return vim.fn.json_encode({ nvim_tree = last_state })
end

function M.restore_extra_data(_, extra_data)
  if type(extra_data) ~= "string" or extra_data == "" then
    return
  end

  local ok, decoded = pcall(vim.fn.json_decode, extra_data)
  if not ok or type(decoded) ~= "table" then
    return
  end

  local state = normalize_state(decoded.nvim_tree)
  if not has_state(state) then
    return
  end

  pending_state = state
end

function M.restore_if_needed()
  apply_pending_state()
end

return M