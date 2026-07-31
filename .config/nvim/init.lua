-- =========================
-- Neovim entry point
-- Modular config: see lua/config/ (options, keymaps, autocmds, lazy, lsp),
-- lua/plugins/ (plugin specs, auto-imported), and lsp/ (per-server configs).
-- =========================

require("config.options")  -- must be first: sets leader + $PATH before plugins/LSP
require("config.lazy")     -- bootstrap lazy.nvim and load lua/plugins/*
require("config.keymaps")  -- global, plugin-independent keymaps
require("config.autocmds") -- editor autocommands
require("config.lsp")      -- LSP capabilities, keymaps, servers, floats
