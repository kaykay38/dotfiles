require('plugins')
require('lv-globals')
require('lv-utils')
vim.cmd('luafile ~/.config/nvim/lv-settings.lua')
require('lv-autocommands')
require('settings')
require('keymappings')
vim.cmd('source ~/.config/nvim/vimscript/keymappings.vim')
require('colorscheme')
require('lv-galaxyline')
vim.cmd('source ~/.config/nvim/vimscript/nvimtree.vim')
require('lv-compe')
-- require('lv-barbar')
-- require('lv-telescope')
require('lv-treesitter')
require('colorizer').setup()
require('lv-autopairs')
require('lv-comment')
-- require('lv-gitsigns')
-- require('lv-dashboard')

-- Which Key (Hope to replace with Lua plugin someday)
-- vim.cmd('source ~/.config/nvim/vimscript/lv-whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/vimspector.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/fzf.vim')
vim.cmd('source ~/.config/nvim/vimscript/rest-console.vim')

-- LSP
require('lsp')
require('lsp.clangd')
require('lsp.latex-ls')
require('lsp.python-ls')
require('lsp.lua-ls')
require('lsp.java-ls')
require('lsp.js-ts-ls')
require('lsp.html-ls')
require('lsp.css-ls')
require('lsp.tailwindcss-ls')
require('lsp.emmet-ls')
require('lsp.efm-general-ls')
require('lsp.omnisharp-ls')
require('lsp.json-ls')
-- require('lsp.php-ls')
-- require('lsp.docker-ls')
-- require('lsp.bash-ls')
-- require('lsp.go-ls')
-- require('lsp.dart-ls')
-- require('lsp.svelte-ls')
-- require('lsp.rust-ls')
-- require('lsp.yaml-ls')
-- require('lsp.terraform-ls')
-- require('lsp.vim-ls')
-- require('lsp.graphql-ls')
