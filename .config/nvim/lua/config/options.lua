-- Editor options, globals, and environment. Required first from init.lua so the
-- leader key is set before lazy.nvim maps any plugin `keys`, and so the Mason bin
-- is on $PATH before any LSP server `cmd` is resolved.

-- Leader must be set before plugins are loaded.
vim.g.mapleader = " "

-- --------- options / UX ----------
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪>> "
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.clipboard = "unnamedplus" -- system clipboard: "+y / "+p just work
vim.opt.cursorline = true

-- --- Persistent undo --------------------------------------------------------
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

local undo_dir = vim.fn.expand("$HOME/.local/share/nvim/undo")
vim.opt.undodir = undo_dir
-- create directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(vim.opt.undodir, "p")
end

-- disable netrw (nvim-tree replaces it; see config/autocmds.lua for dir-open)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set Mason bin for lsp server paths
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end
