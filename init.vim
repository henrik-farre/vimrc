" vim:fdm=marker
"
" Explanation of vimrc
" https://gist.github.com/romainl/9ecd7b09a693816997ba
"
" Anti-pattern of vimrc
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
"
" http://usevim.com/2014/03/28/vimrc-folding/
" from http://www.reddit.com/r/vim/comments/20eyjk/preventing_plugin_clash_and_key_lag_sculpting/
"
" Variable scope: http://www.ibm.com/developerworks/library/l-vim-script-1/#N101F8
"

" Disable unused providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

let $VIMHOME = split(&rtp, ',')[0] " Find the Vim path

if has('vim_starting')
  " ensure that we always start with Vim defaults (as opposed to those set by the current system)
  " Save 'diff' as set all& resets it, from http://ruderich.org/simon/config/vimrc
  let s:save_diff = &diff
  " Disabled to fix lack of nvim resize, see https://github.com/neovim/neovim/issues/11066
  " - also it should not be needed for neovim https://github.com/neovim/neovim/issues/5783

  " Some Arch Linux packages (tmux, docker) install syntax and more in the following path
  set runtimepath+=/usr/share/vim/vimfiles
endif

if has('eval')
  let &diff = s:save_diff
  unlet s:save_diff
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug {{{
" https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob("$VIMHOME/autoload/plug.vim"))
  silent !curl -fLo $VIMHOME/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! call plug#begin("$VIMHOME/bundle")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}  " We recommend updating the parsers on update
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript
" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
Plug 'fatih/vim-go'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
Plug 'tpope/vim-markdown', { 'for': 'ghmarkdown' }
" Add-on to Tim Pope's markdown.vim to highlight using Github Flavored Markdown.
Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'puremourning/vimspector'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
" Shows git branch in statusline + tags to the one in .git/tags if exists
if executable('git')
  Plug 'tpope/vim-fugitive'
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Web
Plug 'mattn/emmet-vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
Plug 'hrsh7th/nvim-compe'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-nvim-lua'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-emoji'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
Plug 'Raimondi/delimitMate'
Plug 'andymass/vim-matchup'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

if v:version >= 704
  Plug 'haya14busa/incsearch.vim'
endif

" Highlights on f F t T
Plug 'bradford-smith94/quick-scope'
" Add visual marks in gutter
Plug 'kshenoy/vim-signature'
Plug 'godlygeek/tabular'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
Plug 'pacha/vem-dark'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shows registers
Plug 'junegunn/vim-peekaboo'
Plug 'svermeulen/vim-easyclip'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
" Examples of python interpolation:
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'phenomenes/ansible-snippets'
" Ansible
Plug 'pearofducks/ansible-vim'
" Detect tabs vs spaces
Plug 'tpope/vim-sleuth'
" Hashicorp plugins
Plug 'hashivim/vim-terraform'
" Syntax and more for tmux
Plug 'tmux-plugins/vim-tmux'
" TypeScript
Plug 'leafgarland/typescript-vim'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Icons for filetypes
Plug 'ryanoasis/vim-devicons'
" Icons for filetypes - support for telescope
Plug 'kyazdani42/nvim-web-devicons'
Plug 'norcalli/nvim-colorizer.lua'
" Linting and formatting
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
" Show indent lines
Plug 'lukas-reineke/indent-blankline.nvim'
" LSP setup
Plug 'neovim/nvim-lspconfig'
" Plug 'iamcco/diagnostic-languageserver'
Plug 'folke/lsp-colors.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'folke/trouble.nvim'
" Show 💡 if there is a code action avaliable
Plug 'kosayoda/nvim-lightbulb'
" Set working to project directory
Plug 'airblade/vim-rooter'
" Telescope and dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" vim tests
Plug 'junegunn/vader.vim'
Plug 'equalsraf/neovim-gui-shim'
" Enhanced wild menu
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
" Needs to be set here, and not in bindings.vim as it is sourced to late
" http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
let g:mapleader = "\<Space>"
map <Space> <Leader>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings {{{
"
" Note: Plugins are not loaded at this point... don't know why, but stuff
" like:
" if exists(":Tabularize")
" Does not work...

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
let g:snips_author = 'Henrik Farre <hfar@tv2.dk>'
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" incsearch
if has_key(g:plugs, 'incsearch')
  let g:incsearch#auto_nohlsearch = 0
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable plugins:
let g:loaded_html_danish = 1      " html_da
let g:loaded_netrwPlugin = 1      " netrw
let g:loaded_vimballPlugin = 1    " vimball
let g:loaded_matchparen = 1       " Parenthesis matching is just too slow
let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_tutor_mode_plugin = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'html' : {
      \   'filters' : 'html',
      \   'indentation' : ' '
      \ },
      \ 'php' : {
      \   'extends' : 'html,javascript',
      \   'filters' : 'html,c',
      \ },
      \ 'css' : {
      \   'filters' : 'fc',
      \ }
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax checking when in a diff
if &diff
  set noswapfile
  let g:loaded_javascript_syntax_checker = 1
  let g:loaded_html_syntax_checker = 1
  let g:loaded_xhtml_syntax_checker = 1
  " let g:neomake_javascript_enabled_makers = []
  " let g:neomake_html_enabled_makers = []
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope
"
nnoremap <leader>bv <cmd>Telescope buffers<CR>
nnoremap <leader>gv <cmd>Telescope git_files<CR>
nnoremap <leader>fv <cmd>Telescope find_files<CR>
nnoremap <leader>lv <cmd>Telescope live_grep<CR>

lua << EOF
require('telescope').setup{
  defaults = {
    color_devicons = true,
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
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" NERD Commenter
map <F5> <Plug>NERDCommenterToggle
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" JSON
" Don't hide "
let g:vim_json_syntax_conceal = 0

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ansible settings
" When this variable is set, indentation will completely reset (unindent to column 0) after two newlines in insert-mode. The normal behavior of YAML is to always keep the previous indentation, even across multiple newlines with no content.
let g:ansible_unindent_after_newline = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
"
if has_key(g:plugs, 'neomake')
  let g:neomake_javascript_enabled_makers = ['jshint']
  let g:neomake_ansiblelint_maker = {
        \ 'exe': 'ansible-lint',
        \ 'args': ['--parseable-severity', '-x', 'yaml', '--nocolor'],
        \ 'errorformat':
            \ '%f:%l: %m,'.
            \ '%f:%l:%c: %m',
        \ }
  " '%f:%l: [%t%n] %m,%f:%l: [%tANSIBLE%n] %m'
  let g:neomake_error_sign = {
      \ 'text': '',
      \ 'texthl': 'NeomakeErrorSign',
      \ }
  let g:neomake_warning_sign = {
      \   'text': '',
      \   'texthl': 'NeomakeWarningSign',
      \ }
  let g:neomake_message_sign = {
      \   'text': '',
      \   'texthl': 'NeomakeMessageSign',
      \ }
  let g:neomake_info_sign = {
      \ 'text': '',
      \ 'texthl': 'NeomakeInfoSign'
      \ }
  let g:neomake_yaml_ansible_enabled_makers = ['ansiblelint']
  let g:neomake_open_list=0
  let g:neomake_list_height=5
  let g:neomake_logfile = '/tmp/neomake.log'
  call neomake#configure#automake('nirw', 750)
endif

" Terraform settings
let g:terraform_fmt_on_save=1       " Run terraform fmt on save to comply with style guide
let g:terraform_align=1             " Set indent to 2 spaces


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DevIcons
"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zsh'] = ''
" ryanoasis/vim-devicons contains an explicit setting for .zshrc: https://github.com/ryanoasis/vim-devicons/blob/master/plugin/webdevicons.vim#L300
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.zshrc'] = ''

" nvim-web-devicons also has a override for .zshrc https://github.com/kyazdani42/nvim-web-devicons/blob/master/lua/nvim-web-devicons.lua#L175
lua <<EOF
require'nvim-web-devicons'.setup {
  override = {
    [".zshrc"] = {
      icon = "",
      color = "#428850",
      name = "Zsh"
    }
  };
 default = true;
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treesitter
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "dockerfile", "yaml", "python", "bash", "json", "javascript", "html", "css", "lua" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent blankline
"
let g:indent_blankline_char_list = ['│', '¦', '┆', '┊']
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_filetype_exclude = ["help", "terminal", "list", "nofile", "man"]
let g:indent_blankline_buftype_exclude = ["help", "terminal", "list", "nofile", "man"]
let g:indent_blankline_bufname_exclude = ["man://.*"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP setup
"
lua << EOF
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ansiblels', 'bashls', 'cssls', 'dockerls', 'groovyls', 'html', 'jsonls', 'null-ls', 'terraformls', 'pyright', 'vimls', 'yamlls' }
local nvim_lsp = require('lspconfig')

-- null-ls setup
local null_ls = require("null-ls")
local sources = {
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.shellcheck,
}

null_ls.config({ sources = sources })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

for _, server in ipairs(servers) do
  if server == 'ansiblels' then
    nvim_lsp[server].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 200,
      },
      filetypes = { "yaml.ansible" },
      settings = {
        ansible = {
          ansible = {
            path = "/usr/bin/ansible"
          },
          ansibleLint = {
            enabled = true,
            path = "/usr/bin/ansible-lint",
            arguments = "-x yaml"
          },
          python = {
            interpreterPath = "/usr/bin/python3"
          }
        },
      }
    }
  elseif server == 'yamlls' then
    nvim_lsp[server].setup {
      settings = {
        yaml = {
          schemaStovalidate = false,
          hover = true,
          completion = true,re = { enable = true },
          schemas = {
            ['https://json.schemastore.org/chart.json'] = 'Chart.{yml,yaml}'
          }
        }
      }
    }
  elseif server == 'jsonls' then
    nvim_lsp[server].setup {
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { 'Packer/**/*.json' },
              url = 'https://json.schemastore.org/packer.json',
            }
          }
        }
      }
    }
  elseif server == 'groovyls' then
   nvim_lsp[server].setup {
     cmd = { "java", "-jar", "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" },
   }
  else
    nvim_lsp[server].setup {
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
end

local signs = { Error = "❌", Warning = "⚠️", Hint = "💡", Information = "ℹ️" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compe: completion plugin
"
if has_key(g:plugs, 'nvim-compe')
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.preselect = 'enable'
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:false
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.emoji = v:true
let g:compe.source.treesitter = v:true
let g:compe.documentation = {}
let g:compe.documentation.border = "rounded"

" Press enter to select element in menu
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

if has_key(g:plugs, 'nvim-cmp')
lua << EOF
local cmp = require'cmp'
cmp.setup {
  completion = {
    autocomplete = { ... },
  },
  sources = { ... }
}
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP colors, highlightning of messages for colorschemes that does not support
" those groups
"
if has_key(g:plugs, 'lsp-colors')
lua << EOF
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP kind: show icons for completions
"
if has_key(g:plugs, 'lspkind-nvim')
lua << EOF
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'default',

    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Operator = 'ƒ',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
    },
})
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trouble, A pretty list for showing diagnostics, references, telescope
" results, quickfix and location lists to help you solve all the trouble your
" code is causing.
if has_key(g:plugs, 'trouble.nvim')
lua << EOF
  require("trouble").setup {}
EOF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rooter
"
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wilder
"
" Key bindings can be changed, see below
call wilder#setup({'modes': [':', '/', '?']})

set wildoptions+=pum
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['fd', '-tf'],
      \       'dir_command': ['fd', '-td'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline(),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Peekaboo
"
" Increase size of window
if has_key(g:plugs, 'vim-peekaboo')
  let g:peekaboo_window = "vert bo 70new"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy clip
"
if has_key(g:plugs, 'vim-easyclip')
  let g:EasyClipAlwaysMoveCursorToEndOfPaste = 1
  let g:EasyClipPreserveCursorPositionAfterYank = 1
  let g:EasyClipUseCutDefaults = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"
set fileencodings=utf-8,iso-8859-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"
set ignorecase                    " Do case insensitive matching, must be set for smartcase to work
set smartcase                     " Do smart case search - case sensitive if first letter in search is uppercase
set inccommand=split              " Incremental replace, https://github.com/neovim/neovim/pull/5561
set gdefault                      " Applies substitutions globally on lines, /g to disable

set infercase                     " Handle case in a smart way in autocompletes
set lazyredraw                    " Speed up macros

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding rules
"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=10                " deepest fold is 10 levels
set nofoldenable                  " dont fold by default
set foldlevel=1                   " this is just what i use
" set nofen                       " foldenable no
" set foldenable                  " enable folding
" set foldcolumn=2                " add a fold column
" set foldmethod=marker           " detect triple-{ style fold markers
" set foldlevelstart=0            " start out with everything folded
" set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " which commands trigger auto-unfold

set number                        " Line numbers
" Switch between relativenumber and number on focus/enter/leave
augroup vimrc_number
  autocmd!
  autocmd FocusLost * :set norelativenumber
  autocmd FocusGained * :set relativenumber
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" Only show cursorline in active window/buffer
augroup vimrc_CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

set list
" set listchars=tab:▸\ ,eol:¬
set listchars=tab:\ \ ,extends:»,precedes:«,trail:▒,nbsp:·

"vertical/horizontal scroll off settings
set scrolloff=10                  " Keep lines between the cursor and bottom/top
set sidescrolloff=7
set sidescroll=1
" All abbrevitions, truncate middle of long messages, no intro when starting,
set shortmess=aTI
" no ins-completion-menu messages
set shortmess+=c

set nostartofline                 " Cursor does not jump to first nonblank char on line after buffer switch http://stackoverflow.com/questions/8292742/vim-cursor-jumps-to-begining-of-the-line-after-buffer-switch

"set showmatch                    " show matching brackets
"set mat=5                        " how many tenths of a second to blink matching brackets for

" More natural split opening
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session
"
set ssop-=options " do not store global and local values in a session
set ssop-=folds " do not store folds

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff
"
set breakindent                   " visually indent text: http://www.reddit.com/r/vim/comments/2jjtad/this_picture_says_it_all_thanks_to_uchrisbra10/
set confirm                       " present a dialog
set display+=lastline             " A nicer way to show long wrapped lines
set title                         " change the terminals/windows title
set hid                           " change buffer without saving
set autowrite                     " Write contents of the file, if it has been modified, on buffer exit
set history=10000                 " remember more than the default 20 commands and search patterns
set virtualedit=block             " Allow the cursor to go in to 'invalid' places in visual block mode
set showcmd                       " Show (partial) command in status line.
set showmode                      " display the current mode
" set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set fillchars+=vert:│
set showfulltag                   " Show full tag for completion
set switchbuf=useopen             " Buffer switching the reuses already visible buffers
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
" html.vim overrides comments setting, so a fix is in vimrc_php autocmd group
"  -t:  Do not apply 'textwidth' to code.
"  +c:  Apply 'textwidth' to comments.
"  +r:  Continue comments after hitting <Enter> in Insert mode.
"  +o:  Continue comments after when using 'O' or 'o' to open a new line.
"  +q:  Format comments using q<motion>.
"  +l:  Do not break a comment line if it is long before you start.
"  +j:  Where it makes sense, remove a comment leader when joining lines.
set formatoptions-=t
set formatoptions+=croql
" Fix comments when jusing j to join lines
set formatoptions+=j
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
set ttimeout
set ttimeoutlen=100
set timeoutlen=1000
" NeoVim handles ESC keys as alt+key set this to solve the problem
" https://github.com/neovim/neovim/issues/2051
set ttimeoutlen=0

" Do not autoread changed files, also see checktime augroup
set noautoread

" Automatically change to directory of current file
" - fixes start location of telescope find files
" set autochdir

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard {{{
"
" In insert mode:
" - <C+r> *: Primary selection
" - <C+r> +: Contents of clipboard
"
" use X clipboard if avaliable
" let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" Make it work in Neovim
if (has('clipboard') && executable('xsel') && exists('$DISPLAY'))
  set clipboard+=unnamedplus
elseif (has('clipboard') && executable('pbcopy') && has('mac'))
  set clipboard+=unnamedplus
endif
" }}}

set modeline                      " read settings for stuff like shiftwidth from current file
set modelines=3                   " number lines checked for modelines

if has("gui_running")
  set noesckeys                   " Get rid of the delay when hitting esc!, NOTE: this produces A,B,C,D in input mode using arrow
endif

" set completeopt+=menu,longest,preview
set completeopt=menuone,noselect
set complete-=i                   " disabled scanning of include files

" Wrapping/linebreak
set textwidth=0                   " Do not wrap text
set linebreak                     " Do not softwrap the line in the middle of a word
set whichwrap=<,>,[,],h,l,b,s,~   " Make end/beginning-of-line cursor wrapping behave human-like, not vi-like

set wildmenu
" Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
set wildignore+=.hg,.git,.svn,CSV                " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

set wildmode=list:longest,full
if exists("&wildignorecase")
  set wildignorecase
endif
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,CVS/,tags

set nobackup                      " dont use backups
" set noswapfile                  " do not write annoying intermediate swap files, who did ever restore from swap files anyway?
" Store temporary files in a central spot
if !isdirectory($VIMHOME."/backups/")
    call mkdir($VIMHOME."/backups/", "", 0700)
endif

set backupdir=$VIMHOME/backups/
set backupskip=/tmp/*"            " Make Vim able to edit crontab files again.

if !isdirectory($VIMHOME."/swaps/")
    call mkdir($VIMHOME."/swaps/", "", 0700)
endif
set directory=$VIMHOME/swaps/       " swap files

" Use less space for line numbering if possible
try
  setlocal numberwidth=3
catch
endtry

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning
"
set synmaxcol=500                " Syntax coloring lines that are too long just slows down the world

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff
"
set diffopt+=iwhite               " Ignore whitespace
set diffexpr=""                   " When 'diffexpr' is empty, Vim uses this command to find the differences between file1 and file2: diff file1 file2 > outfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indention
" Note that modeline may override this
"
set softtabstop=2                 " Standard vi interprets the tab key literally, but there are popular vi-derived alternatives that are smarter, like vim. To get vim to interpret tab as an ``indent'' command instead of an insert-a-tab command
set shiftwidth=2                  " Number of spaces to use for each insertion of (auto)indent.
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4                     " To cause the TAB file-character to be displayed as mod-N in vi and vim (what Emacs calls tab-width)
set expandtab                     " To cause TAB characters to not be used in the file for compression, and for only spaces to be used (what emacs calls indent-tabs-mode),
" set smarttab
" Disable smartindent
" http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
" http://vim.wikia.com/wiki/Indenting_source_code#Methods_for_automatic_indentation
" set smartindent                   " insert tabs on the start of a line according to shiftwidth, not tabstop
set copyindent                    " copy the previous indentation on autoindenting
set preserveindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions {{{
"
" http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleHomeZero()
  let pos = getpos('.')
  execute "normal! ^"
  if pos == getpos('.')
    execute "normal! 0"
  endif
endfunction

" FIXME: clashes with 0 g0 mapping in bindings
nnoremap 0 :call ToggleHomeZero()<CR>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

" Sudo write (from http://git.tpope.net/tpope.git?a=blob&f=.vimrc )
" remember to use sudo -e instead
command! -bar -nargs=0 SudoW   :silent exe "write !sudo tee % >/dev/null"|silent edit!

" <SID> explanation: http://stackoverflow.com/questions/16768059/how-to-understand-these-vim-scripts
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" Removes trailing spaces
function! TrimWhiteSpace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! TrimWhiteSpace call TrimWhiteSpace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrevs
"
iabbrev seperator separator
iabbrev lenght length
iab _DATE_ <C-r>=strftime("%Y-%m-%d")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
"
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=500, on_visual=true}

" Show 💡 when code action is avaliable
augroup vimrc_lightbulb
  autocmd!
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
augroup END

" Omnicomplete
"
augroup vimrc_complete
  autocmd!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html,xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

" Reads the skeleton files, delete empty line
if !&diff
  augroup vimrc_skeleton
    autocmd!
    autocmd BufNewFile *.module 0r $VIMHOME/skel/drupal_module |normal Gdd2h
    autocmd BufNewFile *.info 0r $VIMHOME/skel/drupal_info |normal Gdd2h
    autocmd BufNewFile *.html 0r $VIMHOME/skel/html | $,$d
    autocmd BufNewFile *.css 0r $VIMHOME/skel/css | $,$d
    autocmd BufNewFile *.sh 0r $VIMHOME/skel/bash | $,$d
    autocmd BufNewFile Dockerfile 0r $VIMHOME/skel/Dockerfile | $,$d
    autocmd BufNewFile .dockerignore 0r $VIMHOME/skel/dockerignore | $,$d
    autocmd BufNewFile hest.yml 0r $VIMHOME/skel/hest.yml | $,$d
    autocmd BufNewFile pyrightconfig.json 0r $VIMHOME/skel/pyrightconfig.json | $,$d
  augroup END
endif

augroup vimrc_tmuxfiletype
  autocmd!
  autocmd BufNewFile,BufRead .tmux.conf setlocal filetype=tmux
augroup END

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
  autocmd!
  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre      *.gpg set bin
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPre,FileReadPre      *.gpg let shsave=&sh
  autocmd BufReadPre,FileReadPre      *.gpg let &sh='sh'
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
  autocmd BufReadPost,FileReadPost    *.gpg let &sh=shsave
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
  " Convert all text to encrypted text before writing
  autocmd BufWritePre,FileWritePre    *.gpg set bin
  autocmd BufWritePre,FileWritePre    *.gpg let shsave=&sh
  autocmd BufWritePre,FileWritePre    *.gpg let &sh='sh'
  autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
  autocmd BufWritePre,FileWritePre    *.gpg let &sh=shsave
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost  *.gpg   silent u
  autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END

" Use github style markdown
augroup vimrc_markdown
    autocmd!
    " autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
    autocmd BufNewFile,BufRead *.md,*.markdown :call MarkdownTypeDetect()
augroup END

" Spelling, files for neovim: ftp://ftp.vim.org/pub/vim/runtime/spell/
augroup vimrc_spelling
    autocmd!
    autocmd FileType gitcommit,markdown,ghmarkdown,cucumber setlocal spell spelllang=en_us
    autocmd FileType gitcommit,markdown,ghmarkdown,cucumber setlocal complete+=kspell
augroup END

" Indent xml using xmllint
" - Only works for entire file
" augroup vimrc_xml
"     autocmd!
"     autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
" augroup END

" ansible-vim does not detect playbooks, `set filetype=x` overrides setfiletype
augroup vimrc_ansible
    autocmd!
    autocmd BufRead,BufNewFile */ansible/*.{yml,yaml} set filetype=yaml.ansible
    autocmd BufRead,BufNewFile inventory set filetype=ansible_hosts
augroup END

" go-jira
augroup vimrc_gojira
  autocmd!
  autocmd BufRead,BufNewFile /tmp/comment*.yml setlocal spell spelllang=da
  autocmd BufRead,BufNewFile ~/.jira.d/templates/* setfiletype gotexttmpl
augroup END

" Jenkinsfile
augroup vimrc_jenkins
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
  autocmd FileType groovy setlocal omnifunc=javacomplete#Complete
augroup END

augroup vimrc_whitespace
  autocmd!
  autocmd FileWritePre    *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FileAppendPre   *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FilterWritePre  *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd BufWritePre     *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
augroup END

" Resize splits when the window is resized
" augroup vimrc_resize
"   autocmd!
"   autocmd VimResized * :wincmd =
" augroup END

" Make sure Vim returns to the same line when you reopen a file.
" Based on
" https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
augroup vimrc_line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Hide quickfix from bufferlist
augroup vimrc_qfix
    autocmd!
    autocmd FileType qf setlocal nobuflisted
augroup END

" Help Neovim check if file has changed on disc
" https://github.com/neovim/neovim/issues/2127
augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Detect Markdown filetype
"
function! MarkdownTypeDetect()
  setlocal filetype=ghmarkdown
  if expand("%:p:h") =~ 'content'
    setlocal filetype=ghmarkdown.hugo
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI settings
"
source $VIMHOME/ui.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"
source $VIMHOME/bindings.vim
