if vim.g.plugs['lualine.nvim'] then
  -- Override 'encoding': Don't display if encoding is UTF-8.
  local lualine_encoding = function()
    local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
    return ret
  end

  local truncateStringMiddle = function(originalString, maxLength)
      if #originalString > maxLength then
          local halfLength = math.floor((maxLength - 3) / 2)  -- Subtract 3 for the ellipsis (...)
          local truncatedString = string.sub(originalString, 1, halfLength) .. "..." .. string.sub(originalString, -halfLength)
          return truncatedString
      else
          return originalString
      end
  end

  local yaml_key_value = function()
    if vim.bo.filetype == "yaml" or vim.bo.filetype == "helm" then
      local path = require("yaml_nvim").get_yaml_key()
      if string.len(path) > 0 then
          return truncateStringMiddle(path,70)
      end
    end
    return ""
  end

  require('lualine').setup {
    options = {
      theme = 'ayu_dark'
    },
    extensions = { 'fzf', 'neo-tree', 'trouble', 'man' },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 3,
          shorting_target = 40,
        }
      },
      lualine_x = {
        yaml_key_value, lualine_encoding, 'fileformat', 'filetype',
      },
    }
  }
end
