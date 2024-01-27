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
