local M = {}

local function escape_lua_pattern(text)
  return text:gsub("([^%w])", "%%%1")
end

function M.find_files_space_wildcard()
  local ok_sorters, telescope_sorters = pcall(require, "telescope.sorters")
  local ok_builtin, telescope_builtin = pcall(require, "telescope.builtin")

  if not (ok_sorters and ok_builtin) then
    vim.notify("Telescope is not available", vim.log.levels.WARN)
    return
  end

  local wildcard_sorter = telescope_sorters.Sorter:new {
    discard = true,
    scoring_function = function(_, prompt, line)
      if prompt == nil or prompt == "" then
        return 1
      end

      local normalized_prompt = prompt:lower():gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
      local normalized_line = (line or ""):lower()

      local tokens = {}
      for token in normalized_prompt:gmatch("%S+") do
        tokens[#tokens + 1] = escape_lua_pattern(token)
      end

      if #tokens == 0 then
        return 1
      end

      local pattern = table.concat(tokens, ".*")
      local start_idx = normalized_line:find(pattern)

      if not start_idx then
        return -1
      end

      return start_idx
    end,
    highlighter = function()
      return {}
    end,
  }

  telescope_builtin.find_files {
    sorter = wildcard_sorter,
  }
end

return M