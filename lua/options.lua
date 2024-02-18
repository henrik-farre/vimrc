local g = vim.g
local o = vim.o
local opt = vim.opt

-- -----------------------------------------------------------------------------
-- Disable Language providers
--
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- -----------------------------------------------------------------------------
--  Encoding & fileformat
--
vim.scriptencoding = "utf-8"
opt.fileencodings = "utf-8"

-- vim.o.binary = true
-- vim.o.eol = false -- Avoid adding newline to last line of file

-- -----------------------------------------------------------------------------
--  Modeline
--
o.modeline = false -- Nobody uses modelines

-- -----------------------------------------------------------------------------
-- Leader
--
-- Needs to be set here, and not in keymaps.lua as it is sourced to late
-- http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
g.mapleader = " "

-- -----------------------------------------------------------------------------
-- Diff settings
--
opt.diffopt:append({
  "iwhite",             -- Ignore changes in amount of white space
  "linematch:60",       -- Enable a second stage diff on each generated hunk in order to align lines
  "algorithm:histogram" -- Use either histogram or patience diff algorithm, https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
})

-- Disable swapfile when in a diff
-- the old syntax checker options do not exist anymore
if vim.opt.diff:get() then
  vim.o.noswapfile = true
end

-- -----------------------------------------------------------------------------
-- Search / Replace
--
o.ignorecase = true     -- Do case insensitive matching, must be set for smartcase to work
o.smartcase = true      -- Do smart case search - case sensitive if first letter in search is uppercase
o.inccommand = "split"  -- Incremental replace, https://github.com/neovim/neovim/pull/5561
o.gdefault = true       -- Applies substitutions globally on lines, /g to disable

-- -----------------------------------------------------------------------------
-- Infercase
--
o.infercase = true      -- Handle case in a smart way in autocompletes

-- -----------------------------------------------------------------------------
-- Miscellaneous settings
--
o.confirm = true        -- Present a dialog
o.virtualedit = "block" -- Allow the cursor to go in to 'invalid' places in visual block mode
o.keymodel = "startsel" -- Allow select of text in insert mode using shift
o.selection = "inclusive" -- Selection will include current char, set to exclusive else
o.showcmd = false       -- Do not show (partial) command in status line (also displays keys)

-- -----------------------------------------------------------------------------
-- Completion
--
o.completeopt = "menu,menuone,noselect"
o.showfulltag = true    -- Show full tag for completion

-- -----------------------------------------------------------------------------
-- Wild ignore/mode and suffixes
--
-- Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
-- ignored by cmp cmdline :(
opt.wildignore:append({
  ".hg,.git,.svn,CSV",                    -- Version control
  "*.aux,*.out,*.toc",                    -- LaTeX intermediate files
  "*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf", -- binary images
  "*.o,*.obj,*.exe,*.dll,*.manifest",     -- compiled object files
  "*.spl",                                -- compiled spelling word lists
  "*.sw?",                                -- Vim swap files
  "*.DS_Store",                           -- OSX bullshit
  "*.luac",                               -- Lua byte code
  "*.pyc",                                -- Python byte code
  "*.orig",                               -- Merge resolution files
  "*.zip,*.tgz",                          -- Compressed files
})

o.wildmode = "list:longest,full"
o.wildignorecase = true

-- Suffixes that get lower priority when doing tab completion for filenames.
-- These are files we are not likely to want to edit or read.
o.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,CVS/,tags"

-- -----------------------------------------------------------------------------
-- Buffers
--
o.hidden = true         -- Change buffer without saving
o.switchbuf = "useopen" -- Buffer switching the reuses already visible buffers

-- -----------------------------------------------------------------------------
-- Backup
--
o.backup = false        -- Don't use backups
o.backupskip = "/tmp/*" -- Make Vim able to edit crontab files again.

-- ----------------------------------------------------------------------------
-- Shortmess
--
-- Avoid all the |hit-enter| prompts caused by file messages
opt.shortmess:append({
  a = true,                  -- all abbrevitions (filmnrwx)
  I = true,                  -- no intro when starting
  s = true,                  -- no search hit bottom
  c = true,                  -- no ins-completion-menu messages, needed by cmp
})
-- -----------------------------------------------------------------------------
-- Indent
--
-- Note that modeline may override this
-- treesitter indent is disabled
o.breakindent = true              -- Every wrapped line will continue visually indented
o.softtabstop = 2                 -- Standard vi interprets the tab key literally, but there are popular vi-derived alternatives that are smarter, like vim. To get vim to interpret tab as an ``indent'' command instead of an insert-a-tab command
o.shiftwidth = 2                  -- Number of spaces to use for each insertion of (auto)indent.
o.shiftround = true               -- use multiple of shiftwidth when indenting with '<' and '>'
o.tabstop = 4                     -- To cause the TAB file-character to be displayed as mod-N in vi and vim (what Emacs calls tab-width)
o.expandtab = true                -- To cause TAB characters to not be used in the file for compression, and for only spaces to be used (what emacs calls indent-tabs-mode),
-- set smarttab
-- Disable smartindent
-- http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
-- http://vim.wikia.com/wiki/Indenting_source_code#Methods_for_automatic_indentation
-- set smartindent                    -- insert tabs on the start of a line according to shiftwidth, not tabstop
o.copyindent = true               -- copy the previous indentation on autoindenting
o.preserveindent = true
o.linebreak = true                -- Do not softwrap the line in the middle of a word
o.whichwrap = '<,>,[,],h,l,b,s,~' -- Make end/beginning-of-line cursor wrapping behave human-like, not vi-like

-- -----------------------------------------------------------------------------
-- Formatting
--
-- This is a sequence of letters which describes how automatic formatting is to be done.
-- http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
opt.formatoptions:remove("t")       -- Do not apply 'textwidth' to code.
opt.formatoptions:append({
  c = true,                              -- Apply 'textwidth' to comments.
  r = true,                              -- Continue comments after hitting <Enter> in Insert mode.
  o = true,                              -- Continue comments after when using 'O' or 'o' to open a new line.
  q = true,                              -- Format comments using q<motion>.
  l = true,                              -- Do not break a comment line if it is long before you start.
  j = true,                              -- Where it makes sense, remove a comment leader when joining lines
})

-- -----------------------------------------------------------------------------
-- Spelling
--
o.spellsuggest = "best,9"
o.spell = true
o.spelllang = "en"
opt.spelloptions = "noplainbuffer,camel" -- only spell check buffers with syntax enabled, and treat camelCase as separate words

-- -----------------------------------------------------------------------------
-- Auto options
--
o.autowrite = false               -- Write contents of the file, if it has been modified, on buffer exit
o.autoread = false                -- Do not autoread changed files (still detect changes) https://github.com/neovim/neovim/issues/2127
o.autochdir = false               -- Do not automatically change to directory of current file, project.nvim is used instead

-- -----------------------------------------------------------------------------
-- Session
--
opt.sessionoptions:remove({
  'options',                      -- do not store global and local values in a session
  'folds',                        -- do not store folds
})

-- -----------------------------------------------------------------------------
-- Folding rules
--
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldnestmax = 10      -- deepest fold is 10 levels
o.foldenable = false    -- don't fold by default
o.foldlevel = 1

-- -----------------------------------------------------------------------------
-- Clipboard
--
-- In insert mode:
-- <C+r> *: Primary selection
-- <C+r> +: Contents of clipboard
o.clipboard = 'unnamedplus'

if vim.env.WAYLAND_DISPLAY and vim.fn.has('wsl') == 1 then
  -- https://github.com/neovim/neovim/issues/10223
  -- clipboard on wayland with newline fix
  g.clipboard = {
      name = "WL-Clipboard with ^M Trim",
      copy = {
          ["+"] = "wl-copy --foreground --type text/plain",
          ["*"] = "wl-copy --foreground --type text/plain --primary"
      },
      paste = {
        ["+"] = (function()
          return vim.fn.systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" 2>/dev/null | sed -e "s/\r$//"', {''}, 1) -- '1' keeps empty lines
        end),
        ["*"] = (function()
          return vim.fn.systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" --primary 2>/dev/null | sed -e "s/\r$//"', {''}, 1)
        end),
      },
      cache_enabled = 1
  }
end

-- -----------------------------------------------------------------------------
-- Disable plugins:
--
g.loaded_netrwPlugin = 1       -- netrw
g.loaded_matchparen = 1        -- Parenthesis matching is just too slow
g.loaded_gzip = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_matchit = 1
