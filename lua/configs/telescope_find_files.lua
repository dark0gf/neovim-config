local M = {}

local function escape_lua_pattern(text)
  return text:gsub("([^%w])", "%%%1")
end

local function systemlist(command)
  local output = vim.fn.systemlist(command)

  if vim.v.shell_error ~= 0 then
    return {}
  end

  return output
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

function M.live_grep_fixed_or_regex()
  local ok_finders, telescope_finders = pcall(require, "telescope.finders")
  local ok_pickers, telescope_pickers = pcall(require, "telescope.pickers")
  local ok_make_entry, telescope_make_entry = pcall(require, "telescope.make_entry")
  local ok_previewers, telescope_previewers = pcall(require, "telescope.previewers")
  local ok_sorters, telescope_sorters = pcall(require, "telescope.sorters")
  local ok_config, telescope_config = pcall(require, "telescope.config")

  if not (ok_finders and ok_pickers and ok_make_entry and ok_previewers and ok_sorters and ok_config) then
    vim.notify("Telescope is not available", vim.log.levels.WARN)
    return
  end

  local vimgrep_arguments = vim.deepcopy(telescope_config.values.vimgrep_arguments)
  local rg = vimgrep_arguments[1]

  if vim.fn.executable(rg) ~= 1 then
    vim.notify("ripgrep is not available", vim.log.levels.WARN)
    return
  end

  local entry_maker = telescope_make_entry.gen_from_vimgrep {}

  local function build_args(prompt, use_regex)
    local args = vim.deepcopy(vimgrep_arguments)

    if not use_regex then
      table.insert(args, "--fixed-strings")
    end

    table.insert(args, "--")
    table.insert(args, prompt)

    return args
  end

  local function run_grep(prompt, use_regex)
    return systemlist(build_args(prompt, use_regex))
  end

  telescope_pickers
    .new({}, {
      prompt_title = "Live Grep",
      finder = telescope_finders.new_dynamic {
        entry_maker = entry_maker,
        fn = function(prompt)
          if prompt == nil then
            return {}
          end

          local normalized_prompt = prompt:gsub("^%s+", ""):gsub("%s+$", "")

          if vim.fn.strchars(normalized_prompt) < 3 then
            return {}
          end

          local fixed_results = run_grep(normalized_prompt, false)

          if #fixed_results > 0 then
            return fixed_results
          end

          return run_grep(normalized_prompt, true)
        end,
      },
      previewer = telescope_previewers.vimgrep.new {},
      sorter = telescope_sorters.highlighter_only {},
      push_cursor_on_edit = true,
    })
    :find()
end

return M