return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "henrik-farre/yaml.nvim",
    -- "someone-stole-my-name/yaml-companion.nvim",
  },
  config = function()
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

    -- -----------------------------------------------------------------------------
    -- Output selected yaml schema from yaml-companion
    --
    --[[
       [ local get_yaml_schema = function()
       [   local schema = require("yaml-companion").get_buf_schema(0)
       [   if schema then
       [     return schema.result[1].name
       [   end
       [   return ""
       [ end
       ]]

    local yaml_key_value = function()
      if vim.bo.filetype == "yaml" or vim.bo.filetype == "yaml.ansible" or vim.bo.filetype == "helm" then
        local path = require("yaml_nvim").get_yaml_key()
        if string.len(path) > 0 then
            return truncateStringMiddle(path,70)
        end
      end
      return ""
    end

    local custom_theme = require('lualine.themes.ayu_dark')
    custom_theme.inactive.a.fg = '#3e4b59'
    custom_theme.normal.a.fg = '#e6e1cf'

    require('lualine').setup {
      options = {
        theme = custom_theme
      },
      extensions = { 'fzf', 'neo-tree', 'trouble', 'man' },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 3,
            shorting_target = 50,
          }
        },
        lualine_x = {
          lualine_encoding, 'fileformat', 'filetype',
        },
        lualine_z = {
          'selectioncount',
          'location'
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 3,
          }
        }
      },
      winbar = {
        lualine_a = {
          {
            'filename',
            path = 3,
            shorting_target = 50,
          },
          -- get_yaml_schema(),
        },
        lualine_x = {
          yaml_key_value,
        },
      },
      inactive_winbar = {
        lualine_a = {
          {
            'filename',
            path = 3,
            shorting_target = 50,
          },
        },
      }
    }
  end,
}
