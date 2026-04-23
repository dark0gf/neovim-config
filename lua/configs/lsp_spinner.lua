local M = {}

local spinner_frames = { "|", "/", "-", "\\" }
local tracked_methods = {
  ["textDocument/definition"] = "LSP: finding definition",
  ["textDocument/references"] = "LSP: finding references",
}

local state = {
  timer = nil,
  frame = 1,
  label = nil,
  pending = {},
}

local function echo_message(message)
  vim.api.nvim_echo({ { message, "ModeMsg" } }, false, {})
end

local function start_spinner(label)
  state.label = label

  if state.timer then
    return
  end

  local uv = vim.uv or vim.loop
  state.timer = uv.new_timer()

  state.timer:start(0, 100, vim.schedule_wrap(function()
    if not state.label then
      return
    end

    state.frame = (state.frame % #spinner_frames) + 1
    echo_message(string.format("%s %s", spinner_frames[state.frame], state.label))
  end))
end

local function stop_spinner()
  if state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end

  state.frame = 1
  state.label = nil
  vim.cmd "echo ''"
end

function M.setup()
  if M._setup_done then
    return
  end

  M._setup_done = true

  local ok = pcall(vim.api.nvim_create_autocmd, "LspRequest", {
    callback = function(args)
      local data = args.data or {}
      local request = data.request or {}
      local method = request.method
      local request_type = request.type

      if not method or not tracked_methods[method] then
        return
      end

      local key = string.format("%s:%s:%s", args.buf or 0, data.client_id or 0, data.request_id or 0)

      if request_type == "pending" then
        state.pending[key] = method
        start_spinner(tracked_methods[method])
        return
      end

      if request_type == "complete" or request_type == "cancel" then
        state.pending[key] = nil

        if next(state.pending) == nil then
          stop_spinner()
        end
      end
    end,
  })

  if not ok then
    M._setup_done = false
  end
end

return M