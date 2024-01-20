return {
  -- File explorer
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    -- fe mnemonic "file explorer"
    { "<leader>fe", "<cmd>Neotree toggle<CR>" }
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  branch = 'v3.x',

  config = function()
    require('neo-tree').setup{
      default_component_configs = {
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
      },
      filesystem = {
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        cwd_target = {
          sidebar = "tab",   -- sidebar is when position = left or right
          current = "window" -- current is when position = current
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        }
      }
    }
  end,
}
