-- -----------------------------------------------------------------------------------------------
-- Telescope
--
require('telescope').setup{
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
