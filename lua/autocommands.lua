-- -----------------------------------------------------------------------------
-- Toggle relativenumber on focus/insert
--
local custom_number_grp = vim.api.nvim_create_augroup('custom_number', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusLost', 'InsertEnter' }, {
  group = custom_number_grp,
  callback = function()
    vim.opt_local.relativenumber = false
  end
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'InsertLeave' }, {
  group = custom_number_grp,
  callback = function()
    vim.opt_local.relativenumber = true
  end
})

-- -----------------------------------------------------------------------------
-- Only show cursorline in active window/buffer
--
local custom_cursorline_grp = vim.api.nvim_create_augroup('custom_cursorline', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = custom_cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = true
  end
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  group = custom_cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = false
  end
})

-- -----------------------------------------------------------------------------
-- Highlight yanked text
--
local custom_yankhighlight_grp = vim.api.nvim_create_augroup('custom_cursorline', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = custom_yankhighlight_grp,
    callback = function()
        vim.highlight.on_yank({ higroup="IncSearch", timeout=500, on_visual=true })
    end,
})

-- -----------------------------------------------------------------------------
-- Skeleton files
--
local custom_skeleton_grp = vim.api.nvim_create_augroup('custom_skeleton', { clear = true })
local skeleton_options = {
  {
    pattern = {"*.html"},
    file = "html",
  },
  {
    pattern = {"*.css"},
    file = "css"
  },
  {
    pattern = {"*.sh"},
    file = "bash"
  },
  {
    pattern = {"Dockerfile"},
    file = "Dockerfile"
  },
  {
    pattern = {".dockerignore"},
    file = "dockerignore"
  },
  {
    pattern = {"hest.yml"},
    file = "ansible_playbook.yml"
  },
  {
    pattern = {"pyrightconfig.json"},
    file = "pyrightconfig.json"
  },
  {
    pattern = {".vimspector.json"},
    file = "vimspector.json"
  },
}

for _, skeleton in pairs(skeleton_options) do
    vim.api.nvim_create_autocmd({"BufNewFile"}, {
      group = custom_skeleton_grp,
      pattern = skeleton.pattern,
      command = "0r " .. vim.fn.stdpath("config") .. "/skeletons/" .. skeleton.file .. " | $,$d" ,
    })
end
