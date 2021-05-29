local vim = vim
local api = vim.api
local lspconfig = require "lspconfig"

-- this initializes jhe packer plugin manager
api.nvim_command [[packadd packer.nvim]]

-- plugins
require("packer").startup(
  function()
    use {"wbthomason/packer.nvim", opt = true}
    -- navigating the file tree
    use {
      'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
 
    -- Colorscheme
    --use "itchyny/lightline.vim"
    --use "shinchu/lightline-gruvbox.vim"
    -- Galaxyline Statusline
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require'my_statusline' end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    --use "pangloss/vim-javascript"
    --use "MaxMEllon/vim-jsx-pretty"
    --use "jxnblk/vim-mdx-js"
    use "PProvost/vim-ps1"
    --use "uiiaoo/java-syntax.vim"
    --use "jackguo380/vim-lsp-cxx-highlight"
    use "lervag/vimtex"

    -- for easily changing a line to comment
    use "preservim/nerdcommenter"
    use "jiangmiao/auto-pairs"
    --use "alvan/vim-closetag"
    --use "tpope/vim-unimpaired"
    --use "tpope/vim-surround"

    use "OmniSharp/omnisharp-vim"
    use "mfussenegger/nvim-jdtls"
    use "neovim/nvim-lspconfig"
    use "glepnir/lspsaga.nvim"
    use "hrsh7th/nvim-compe"

    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"

    use "/usr/bin/fzf"
    use "junegunn/fzf.vim"
    --use "mhartington/formatter.nvim"
  end
)

vim.cmd [[set mouse=a]]
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true


-- Appearance
------------------------------------------------------------------------
vim.wo.relativenumber = true
vim.wo.number = true

vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
-- I use a unicode curly array with a <backslash><space>
vim.wo.showbreak = ↪>>>

vim.cmd([[
set undofile
]])

-- colorscheme
api.nvim_command [[
    let g:gruvgox_italic=1
    let g:gruvgox_transp_bg=1
]]
api.nvim_command [[colorscheme gruvbox]]

if vim.fn.exists("+termguicolors") then
  cmd [[
    set termguicolors
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  ]]
    require("colorizer").setup()
end


-----------------------
-- Editing
-----------------------
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- In insert mode, on pressing tab, insert 2 spaces
-- vim.o.expandtab = true
-- vim.o.smarttab = true
-- Use system clipboard
-- I don't know why this is not the default option. I am missing something.
-- TODO: Figure out a better way to copy to system clipboard and paste from
-- system clipboard.
-- TODO: I think when we do `set clipboard+=unnamedplus`, it's not concatenating
-- the string 'unnamedplus' to the option clipboard. It's add another value to
-- some object probably
--vim.o.clipboard = "unnamedplus"

-- trigger prettier formatting on save
-- vim.cmd [[augroup fmt]]
-- vim.cmd [[autocmd!]]
-- vim.cmd [[augroup END]]

-----------------------
-- Key mappings
-----------------------
-- took me a long time to figure out how to change the leader key in lua
vim.g.mapleader = " "

-- Let's make & to trigger :&&, which preserves substitution flags when
-- rerunning a substitute, which is what we want most of the times
api.nvim_set_keymap("n", "&", ":&&<CR>", {noremap = true})
api.nvim_set_keymap("x", "&", ":&&<CR>", {noremap = true})

-- expand with current file path. Picked from practical vim.
-- Try out :e %%
api.nvim_set_keymap("c", "%%", "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", {noremap = true, expr = true})

-- I like my cmd+s for saving files. In insert mode!
-- The terminal (or iterm) does not have support for anything related to
-- Command key
-- Hence need to hack stuff -
-- https://stackoverflow.com/questions/33060569/mapping-command-s-to-w-in-vim
api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>i", {noremap = true})
api.nvim_set_keymap("n", "<C-s>", ":w<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>s", ":w<CR>", {noremap = true})

-- To remove highlight from searched word
-- C-l redraws the screen. We change it so that it also removes all highlights
-- C-u so that we remove any ranges which might be there due to visual mode
api.nvim_set_keymap("n", "<C-l>", ":<C-u>noh<CR><C-l>", {noremap = true, silent = true})

-- When in terminal mode, escape will leave terminal mode and then it becomes
-- like any other vim buffer and can be switched or deleted or whatever
api.nvim_set_keymap("t", "<esc>", ":<C-\\><C-n>", {noremap = true})

-- open vimrc
api.nvim_set_keymap("n", "<leader>ev", ":split $MYVIMRC<CR>", {noremap = true})
-- Source my vimrc file
-- TODO: i don't know how to source a lua file
-- source /path/to/lua does not work
api.nvim_set_keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", {noremap = true})

-- open my vimrc file in a split pane
-- command! Vimrc :sp $MYVIMRC
-- TODO: Don't know how to define a command from lua

------ NerdTree configuration ------

-- toggle NERDTree show/hide using <C-n> and <leader>n
api.nvim_set_keymap("n", "<leader>n", ":NERDTreeToggle<CR>", {noremap = true})
-- reveal open buffer in NERDTree
api.nvim_set_keymap("n", "<leader>r", ":NERDTreeFind<CR>", {noremap = true})

------ file search and find in project command mappings ------
-- map Ctrl-q (terminals don't recognize ctrl-tab) (recent files) to show all
-- files in the buffer
api.nvim_set_keymap("n", "<leader>f", ":Buffers<CR>", {noremap = true})
-- Ctrl-I maps to tab
-- But it destroys the C-i mapping in vim. Which is used to kind of go in and
-- used in conjunction with C-o.
api.nvim_set_keymap("n", "<C-b>", ":Buffers<CR>", {noremap = true})
-- map ctrlp to open file search
api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", {noremap = true})
api.nvim_set_keymap("n", "<C-t>", ":GFiles<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>fg", ":Rg!", {noremap = true})
api.nvim_set_keymap("n", "<leader>a", ":exe 'Rg!' expand('<cword')<CR>", {noremap = true})

-- NERDCommenter
-- shortcuts to toggle comment
api.nvim_set_keymap("n", ",c", ':call NERDComment(0, "toggle")<CR>', {noremap = true})
api.nvim_set_keymap("v", ",c", ':call NERDComment(0, "toggle")<CR>', {noremap = true})

require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,
  source = {
    path = true,
    buffer = true,
    vsnip = true,
    lamp = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    snippets_nvim = true
  }
}
-- setup lsp client

-- setup java lsp client
vim.cmd 'augroup lsp
        au!
            au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
          augroup end'

local on_attach = function(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    print("setting shortcut for formatting")
    buf_set_keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
		hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
		augroup lsp_document_highlight
		autocmd!
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]],
      false
    )
  end
end

vim.o.completeopt = "menu,menuone,noselect"
lspconfig.flow.setup {on_attach = on_attach}
-- lspconfig.tsserver.setup { on_attach = on_attach }
lspconfig.pyls.setup {on_attach = on_attach}
local eslint_d = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true
  -- formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  -- formatStdin = true
}
-- prettier or eslint --fix is not working with neovim lsp
-- calling :lua vim.lsp.buf.formatting() should have worked, but never did
-- I don't know how to debug that
-- local prettier = {
-- formatCommand = "prettier --stdin --stdin-filepath ${INPUT}",
-- formatStdin = true
-- }

-- to use efm-langserver and eslint_d, those need to be installed globally
-- brew install efm-langserver
-- npm install -g eslint_d
lspconfig.efm.setup {
  on_attach = on_attach,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  init_options = {
    documentFormatting = false,
    codeAction = true
  },
  settings = {
    lintDebounce = 500,
    languages = {
      javascript = {eslint_d},
      javascriptreact = {eslint_d},
      ["javascript.jsx"] = {eslint_d},
      typescript = {eslint_d},
      typescriptreact = {eslint_d},
      ["typescript.tsx"] = {eslint_d}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  }
}

------ Commands ------
-- There is not api to set a command directly
-- But there's an api to execute random vimscript - vim.nvim_exec
-- But vim.cmd or vim.api.nvim_command serve the same purpose
-- The second argument says if we want the return value from the executed
-- vimscript
vim.cmd("command! Vimrc :sp $MYVIMRC")

------ Nerd commenter ------
--
-- add 1 space after comment delimiter
api.nvim_set_var("NERDSpaceDelims", 1)

-- NERDTree
-- If we toggle the nerdtree buffer, and it's the only buffer open, it shouldn't
-- close vim itself. It should just replace the current buffer with last open
-- buffer
-- I just couldn't get nvim_exec to run the below code
-- And my guess is that nvim_command or vim.cmd only runs the first line
-- And just ignores the rest
-- Can test by putting echo as the second line
-- Yup, when i put echo in the second line, nothing echoes
-- But when it's in the first line, all is good
-- One way to define a vimscript function can be to create a multiline string
-- and then split it by newline and execute each line using vim.cmd
-- local nerdtree_safe = [[
-- autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
-- autocmd BufWinEnter * call PreventBuffersInNERDTree()

-- function! PreventBuffersInNERDTree()
-- if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr && &buftype == '' && !exists('g:launching_fzf')
-- let bufnum = bufnr('%')
-- close
-- exe 'b ' . bufnum
-- endif
-- if exists('g:launching_fzf') | unlet g:launching_fzf | endif
-- endfunction
-- ]]
--
-- for cmd in nerdtree_safe:gmatch("[^\r\n]+") do
-- -- print(cmd)
-- vim.cmd(cmd)
-- end
-- The above didn't work. It waits for input after the first line of function
-- declaration
-- Solution 2: Define the function in lua and then call `lua LuaFn` for the
-- autocmd
-- local nerdtree_safe = [[
-- autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
-- autocmd BufWinEnter * call PreventBuffersInNERDTree()

-- function! PreventBuffersInNERDTree()
-- if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr && &buftype == '' && !exists('g:launching_fzf')
-- let bufnum = bufnr('%')
-- close
-- exe 'b ' . bufnum
-- endif
-- if exists('g:launching_fzf') | unlet g:launching_fzf | endif
-- endfunction
-- ]]

-- api.nvim_command(nerdtree_safe)

-- highlight yanked stuff. Done with native neovim api. No plugin.
-- augroup command didn't work with vim.cmd.
-- TODO: Find the difference between vim.api.nvim_command (alias vim.cmd)
-- and vim.api.nvim_exec
api.nvim_exec(
  [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]],
  false
)

vim.cmd [[ set grepprg=rg\ --vimgrep ]]

-- the live_grep default implementation is slow. Get's stuck between typing.
-- Enabling the fzf_writer extension makes it better
-- require('telescope').setup {
-- extensions = {
-- fzf_writer = {
-- minimum_grep_characters = 2,
-- minimum_files_characters = 2,

-- -- Disabled by default.
-- -- Will probably slow down some aspects of the sorter, but can make color highlights.
-- -- I will work on this more later.
-- use_highlighter = false,
-- },
-- fzy_native = {
-- override_generic_sorter = true,
-- override_file_sorter = true
-- }
-- }
-- }
-- require('telescope').load_extension('fzy_native')

-- Gstatus or git status in vim-fugitive
api.nvim_set_keymap("n", "<leader>gs", ":G<CR>", {noremap = true})

-- mapping to format file using prettier installed inside project place frontend/harmony folder
--vim.cmd [[nnoremap <leader>p :silent %!/Volumes/code-case-sensitive/code/main_service/frontend/harmony/node_modules/.bin/prettier --stdin-filepath %<CR>]]

vim.cmd [[let g:fugitive_pty = 0]]

-- so that tab select the next option in autocomplete menu
vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<C-r>=compe#complete()<CR>"',
  {noremap = true, expr = true}
)

require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      javascriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- format on save
vim.api.nvim_exec(
  [[
  augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.rs,*.lua FormatWrite
  augroup END
  ]],
  true
)
