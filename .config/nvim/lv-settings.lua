--[[
O is the global options object

Formatters and linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- general
O.auto_complete = true
O.colorscheme = 'gruvbox8'
O.wrap_lines = true

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.ignore_install = {"haskell"}
O.treesitter.highlight.enabled = true
O.treesitter.highlight.disable = {"c_sharp", "latex"}


O.clang.diagnostics.virtual_text = false
O.clang.diagnostics.signs = true
O.clang.diagnostics.underline = true

-- python
-- add things like O.python.formatter.yapf.exec_path
-- add things like O.python.linter.flake8.exec_path
-- add things like O.python.formatter.isort.exec_path
-- O.python.formatter = 'efm'
-- O.python.linter = 'pyright'
-- O.python.isort = true
-- O.python.autoformat = true
-- O.python.diagnostics.virtual_text = false
-- O.python.diagnostics.signs = true
-- O.python.diagnostics.underline = true
-- 
-- lua
-- TODO look into stylua
O.lua.formatter = 'lua-format'
-- O.lua.formatter = 'lua-format'
O.lua.autoformat = false

-- javascript
O.tsserver.formatter = 'prettier'
O.tsserver.linter = nil
O.tsserver.autoformat = true

-- json
O.json.autoformat = true

-- create custom autocommand field (This would be easy with lua)
