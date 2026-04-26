local M = {}

local uv = vim.uv or vim.loop
local debounce_ms = 250
local min_line_delta = 30
local max_entries = 1000

local state = {
  entries = {},
  index = 0,
  pending = nil,
  navigating = false,
  timer = uv.new_timer(),
}

local function is_trackable_buffer(bufnr)
  return bufnr
    and bufnr > 0
    and vim.api.nvim_buf_is_valid(bufnr)
    and vim.bo[bufnr].buflisted
    and vim.bo[bufnr].buftype == ""
    and vim.api.nvim_buf_get_name(bufnr) ~= ""
end

local function canonical_path(path)
  if path == nil or path == "" then
    return ""
  end

  return vim.uv.fs_realpath(path) or path
end

local function get_current_entry()
  local bufnr = vim.api.nvim_get_current_buf()
  if not is_trackable_buffer(bufnr) then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local file = vim.api.nvim_buf_get_name(bufnr)

  return {
    bufnr = bufnr,
    file = canonical_path(file),
    line = cursor[1],
  }
end

local function same_entry(a, b)
  return a ~= nil and b ~= nil and a.file == b.file and a.line == b.line
end

local function should_commit_entry(previous, entry)
  if entry == nil then
    return false
  end

  if previous == nil then
    return true
  end

  if previous.file ~= entry.file then
    return true
  end

  return math.abs(previous.line - entry.line) > min_line_delta
end

local function trim_history()
  while #state.entries > max_entries do
    table.remove(state.entries, 1)
    state.index = math.max(0, state.index - 1)
  end
end

local function commit_entry(entry)
  if entry == nil then
    return
  end

  local current = state.entries[state.index]
  if same_entry(current, entry) then
    return
  end

  if state.index < #state.entries then
    for i = #state.entries, state.index + 1, -1 do
      state.entries[i] = nil
    end
  end

  table.insert(state.entries, entry)
  state.index = #state.entries
  trim_history()
end

local function flush_pending()
  if state.pending == nil then
    return
  end

  state.timer:stop()

  local pending = state.pending
  state.pending = nil
  commit_entry(pending)
end

local function checkpoint_current_location()
  flush_pending()

  local entry = get_current_entry()
  if entry == nil then
    return
  end

  local current = state.entries[state.index]
  if same_entry(current, entry) then
    return
  end

  commit_entry(entry)
end

local function schedule_commit(entry)
  state.pending = entry
  state.timer:stop()
  state.timer:start(
    debounce_ms,
    0,
    vim.schedule_wrap(function()
      local pending = state.pending
      state.pending = nil
      commit_entry(pending)
    end)
  )
end

local function track_current_location()
  if state.navigating then
    return
  end

  local entry = get_current_entry()
  if entry == nil then
    return
  end

  local current = state.entries[state.index]
  if same_entry(current, entry) or same_entry(state.pending, entry) then
    return
  end

  if state.pending ~= nil then
    schedule_commit(entry)
    return
  end

  if should_commit_entry(current, entry) then
    schedule_commit(entry)
  end
end

local function jump_to_entry(entry)
  if entry == nil then
    return false
  end

  state.navigating = true

  local target_bufnr = entry.bufnr
  if is_trackable_buffer(target_bufnr) then
    vim.cmd("buffer " .. target_bufnr)
  elseif entry.file ~= "" and vim.uv.fs_stat(entry.file) then
    vim.cmd("hide edit " .. vim.fn.fnameescape(entry.file))
  else
    state.navigating = false
    vim.notify("History target is no longer available", vim.log.levels.WARN)
    return false
  end

  local max_line = vim.api.nvim_buf_line_count(0)
  local line = math.max(1, math.min(entry.line, max_line))
  vim.api.nvim_win_set_cursor(0, { line, 0 })
  vim.cmd "normal! zz"

  vim.schedule(function()
    state.navigating = false
  end)

  return true
end

function M.back()
  checkpoint_current_location()

  if state.index <= 1 then
    vim.notify("No previous history", vim.log.levels.INFO)
    return
  end

  state.index = state.index - 1
  if not jump_to_entry(state.entries[state.index]) then
    state.index = math.min(#state.entries, state.index + 1)
  end
end

function M.forward()
  flush_pending()

  if state.index >= #state.entries then
    vim.notify("No forward history", vim.log.levels.INFO)
    return
  end

  state.index = state.index + 1
  if not jump_to_entry(state.entries[state.index]) then
    state.index = math.max(1, state.index - 1)
  end
end

function M.setup()
  if M._is_setup then
    return
  end
  M._is_setup = true

  local group = vim.api.nvim_create_augroup("LineHistory", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "WinEnter" }, {
    group = group,
    callback = track_current_location,
  })

  vim.schedule(function()
    commit_entry(get_current_entry())
  end)
end

return M