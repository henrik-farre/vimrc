-- -----------------------------------------------------------------------------
-- Output selected yaml schema from yaml-companion
--
function get_yaml_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema then
    return schema.result[1].name
  end
  return ""
end

-- -----------------------------------------------------------------------------
-- Replaces escaped chars like \n and \t with the real ones
--
function ReplaceEscapedChars()
  vim.cmd([[
    %s/\\n/\r/
    %s/\\t/\t/
  ]])
end
vim.api.nvim_create_user_command('ReplaceEscapedChars', function() ReplaceEscapedChars() end, { desc = 'Replace \n and \t with real chars' })

-- -----------------------------------------------------------------------------
-- Removes trailing spaces and windows line endings
--
function TrimWhiteSpace()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- keep* ensures existing jumps and search patterns are kept
  vim.cmd([[
    :keepjumps keeppatterns %s/\r$//e
    :keepjumps keeppatterns %s/\s\+$//e
  ]])

  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

vim.api.nvim_create_user_command("TrimWhiteSpace", function() TrimWhiteSpace() end, {})

-- -----------------------------------------------------------------------------
-- Move to first non whitespace char or beginning of line
--
-- http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function ToggleHomeZero()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)[2]
  -- Move to first non whitespace char
  vim.cmd([[normal! ^]])

  -- If the position did not change move to beginning of line
  if cursor_pos == vim.api.nvim_win_get_cursor(0)[2] then
    vim.cmd([[normal! 0"]])
  end
end
