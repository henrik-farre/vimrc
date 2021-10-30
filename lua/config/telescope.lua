-- -----------------------------------------------------------------------------------------------
-- Telescope
--
require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
  pickers = {
    buffers = {
      -- ignore_current_buffer = true,
      sort_mru = true,
      sort_lastused = true,
      show_all_buffers = true,
      -- theme = "dropdown",
      scroll_strategy = "cycle",
      -- previewer = false,
    },
  },
  defaults = {
    color_devicons = true,
    file_ignore_patterns = { '.cache', '.wine', '.cargo', '.git' },
    vimgrep_arguments = {
      "ag",
      "--no-color",
      "--no-heading",
      "--filename",
      "--numbers",
      "--column",
      "--smart-case",
    },
  }
}

require('telescope').load_extension('fzf')
