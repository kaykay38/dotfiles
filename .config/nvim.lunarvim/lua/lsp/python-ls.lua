-- npm i -g pyright
local util = require 'lspconfig/util'
require'lspconfig'.pyright.setup {
    cmd = {DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio"},

    root_dir = function(fname)
       return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
          util.path.dirname(fname)
      end;
    on_attach = require'lsp'.common_on_attach,
	-- linter = O.python.linter,
    handlers = {
    ['client/registerCapability'] = function(_, _, _, _)
      return {
        result = nil;
        error = nil;
      }
    end;
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.python.diagnostics.virtual_text,
            signs = true,
            underline = O.python.diagnostics.underline,
            update_in_insert = true

        })
    }
}
-- require'lspconfig'.diagnosticls.setup {
--   filetypes = { "python" },
--   init_options = {
--     filetypes = {
--       python = {"flake8"},
--     },
--     linters = {
--       flake8 = {
--         debounce = 100,
--         sourceName = "flake8",
--         command = "flake8",
--         args = {
--           "--format",
--           "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
--           "%file",
--         },
--         formatPattern = {
--           "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
--           {
--               line = 1,
--               column = 2,
--               message = {"[", 3, "] ", 5},
--               security = 4
--           }
--         },
--       },
--     },
--   }
-- }
