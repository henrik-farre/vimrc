-- -----------------------------------------------------------------------------
-- Disable Language providers
--
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- -----------------------------------------------------------------------------
--  Encoding & fileformat
--
vim.scriptencoding = "utf-8"
vim.opt.fileencodings = "utf-8"

-- vim.o.binary = true
-- vim.o.eol = false -- Avoid adding newline to last line of file

-- -----------------------------------------------------------------------------
--  Modeline
--
vim.o.modeline = false -- Nobody uses modelines

-- -----------------------------------------------------------------------------
-- Leader
--
-- Needs to be set here, and not in bindings.vim as it is sourced to late
-- http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
vim.g.mapleader = " "

-- -----------------------------------------------------------------------------
-- Diff settings
--
vim.opt.diffopt:append({
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
vim.o.ignorecase = true     -- Do case insensitive matching, must be set for smartcase to work
vim.o.smartcase = true      -- Do smart case search - case sensitive if first letter in search is uppercase
vim.o.inccommand = "split"  -- Incremental replace, https://github.com/neovim/neovim/pull/5561
vim.o.gdefault = true       -- Applies substitutions globally on lines, /g to disable

-- -----------------------------------------------------------------------------
-- Infercase
--
vim.o.infercase = true      -- Handle case in a smart way in autocompletes

-- -----------------------------------------------------------------------------
-- Miscellaneous settings
--
vim.o.confirm = true        -- Present a dialog
vim.o.virtualedit = "block" -- Allow the cursor to go in to 'invalid' places in visual block mode
vim.o.keymodel = "startsel" -- Allow select of text in insert mode using shift

-- -----------------------------------------------------------------------------
-- Completion
--
vim.o.completeopt = "menu,menuone,noselect"
vim.o.showfulltag = true    -- Show full tag for completion

-- -----------------------------------------------------------------------------
-- Wild ignore/mode and suffixes
--
-- Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
vim.opt.wildignore:append(".hg,.git,.svn,CSV")                    -- Version control
vim.opt.wildignore:append("*.aux,*.out,*.toc")                    -- LaTeX intermediate files
vim.opt.wildignore:append("*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf") -- binary images
vim.opt.wildignore:append("*.o,*.obj,*.exe,*.dll,*.manifest")     -- compiled object files
vim.opt.wildignore:append("*.spl")                                -- compiled spelling word lists
vim.opt.wildignore:append("*.sw?")                                -- Vim swap files
vim.opt.wildignore:append("*.DS_Store")                           -- OSX bullshit
vim.opt.wildignore:append("*.luac")                               -- Lua byte code
vim.opt.wildignore:append("*.pyc")                                -- Python byte code
vim.opt.wildignore:append("*.orig")                               -- Merge resolution files
vim.opt.wildignore:append("*.zip,*.tgz")                          -- Compressed files

vim.o.wildmode = "list:longest,full"
vim.o.wildignorecase = true

-- Suffixes that get lower priority when doing tab completion for filenames.
-- These are files we are not likely to want to edit or read.
vim.o.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,CVS/,tags"

-- -----------------------------------------------------------------------------
-- Buffers
--
vim.o.hidden = true         -- Change buffer without saving
vim.o.switchbuf = "useopen" -- Buffer switching the reuses already visible buffers

-- -----------------------------------------------------------------------------
-- Backup
--
vim.o.backup = false        -- Don't use backups
vim.o.backupskip = "/tmp/*" -- Make Vim able to edit crontab files again.

-- ----------------------------------------------------------------------------
-- Shortmess
--
-- Avoid all the |hit-enter| prompts caused by file messages
vim.opt.shortmess = {
  a = true,                  -- all abbrevitions (filmnrwx)
  T = true,                  -- truncate middle of long messages
  I = true,                  -- no intro when starting
  c = true,                  -- no ins-completion-menu messages, needed by cmp
}

-- -----------------------------------------------------------------------------
-- Indent
--
-- Note that modeline may override this
-- treesitter indent is disabled
vim.o.breakindent = true              -- Every wrapped line will continue visually indented
vim.o.softtabstop = 2                 -- Standard vi interprets the tab key literally, but there are popular vi-derived alternatives that are smarter, like vim. To get vim to interpret tab as an ``indent'' command instead of an insert-a-tab command
vim.o.shiftwidth = 2                  -- Number of spaces to use for each insertion of (auto)indent.
vim.o.shiftround = true               -- use multiple of shiftwidth when indenting with '<' and '>'
vim.o.tabstop = 4                     -- To cause the TAB file-character to be displayed as mod-N in vi and vim (what Emacs calls tab-width)
vim.o.expandtab = true                -- To cause TAB characters to not be used in the file for compression, and for only spaces to be used (what emacs calls indent-tabs-mode),
-- set smarttab
-- Disable smartindent
-- http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
-- http://vim.wikia.com/wiki/Indenting_source_code#Methods_for_automatic_indentation
-- set smartindent                    -- insert tabs on the start of a line according to shiftwidth, not tabstop
vim.o.copyindent = true               -- copy the previous indentation on autoindenting
vim.o.preserveindent = true
vim.o.linebreak = true                -- Do not softwrap the line in the middle of a word
vim.o.whichwrap = '<,>,[,],h,l,b,s,~' -- Make end/beginning-of-line cursor wrapping behave human-like, not vi-like

-- -----------------------------------------------------------------------------
-- Formatting
--
-- This is a sequence of letters which describes how automatic formatting is to be done.
-- http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
vim.opt.formatoptions:remove("t") -- Do not apply 'textwidth' to code.
vim.opt.formatoptions:append("c") -- Apply 'textwidth' to comments.
vim.opt.formatoptions:append("r") -- Continue comments after hitting <Enter> in Insert mode.
vim.opt.formatoptions:append("o") -- Continue comments after when using 'O' or 'o' to open a new line.
vim.opt.formatoptions:append("q") -- Format comments using q<motion>.
vim.opt.formatoptions:append("l") -- Do not break a comment line if it is long before you start.
vim.opt.formatoptions:append("j") -- Where it makes sense, remove a comment leader when joining lines

-- -----------------------------------------------------------------------------
-- Spelling
--
vim.o.spellsuggest = "best,9"
vim.o.spell = true
vim.o.spelllang = "en"
vim.opt.spelloptions = "noplainbuffer,camel" -- only spell check buffers with syntax enabled, and treat camelCase as separate words

-- -----------------------------------------------------------------------------
-- Auto options
--
vim.o.autowrite = false               -- Write contents of the file, if it has been modified, on buffer exit
vim.o.autoread = false                -- Do not autoread changed files (still detect changes) https://github.com/neovim/neovim/issues/2127
vim.o.autochdir = false               -- Do not automatically change to directory of current file, project.nvim is used instead

-- -----------------------------------------------------------------------------
-- Session
--
vim.opt.sessionoptions:remove('options') -- do not store global and local values in a session
vim.opt.sessionoptions:remove('folds')   -- do not store folds

-- -----------------------------------------------------------------------------
-- Folding rules
--
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax = 10      -- deepest fold is 10 levels
vim.o.foldenable = false    -- don't fold by default
vim.o.foldlevel = 1

-- -----------------------------------------------------------------------------
-- Load old vimscript settings
--
vim.cmd.source(vim.fn.stdpath("config") .. "/old.vim")

-- -----------------------------------------------------------------------------
-- Clipboard
--
-- In insert mode:
-- <C+r> *: Primary selection
-- <C+r> +: Contents of clipboard
vim.o.clipboard = 'unnamedplus'

if vim.env.WAYLAND_DISPLAY and vim.fn.has('wsl') == 1 then
  -- https://github.com/neovim/neovim/issues/10223
  -- clipboard on wayland with newline fix
  vim.g.clipboard = {
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
-- Init lazy.nvim
--
-- Archlinux adds /usr/share/vim/vimfiles to rtp
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- Disable plugins:
--
vim.g.loaded_netrwPlugin = 1       -- netrw
vim.g.loaded_matchparen = 1        -- Parenthesis matching is just too slow
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1

-- -----------------------------------------------------------------------------
-- Setup Lazy.nvim and load plugins
--
require("lazy").setup("plugins")
require('functions')
require('autocommands')
require('ui')

-- -----------------------------------------------------------------------------
-- Keymaps
--
vim.cmd.source(vim.fn.stdpath("config") .. "/bindings.vim")
