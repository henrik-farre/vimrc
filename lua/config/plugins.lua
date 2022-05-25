require("indent_blankline").setup {
  char_list = {'│', '¦', '┆', '┊'},
  filetype_exclude = {"help", "terminal", "list", "nofile", "man"},
  buftype_exclude = {"help", "terminal", "list", "nofile", "man"},
  bufname_exclude = {"man://.*"},
  show_current_context = true,
}
