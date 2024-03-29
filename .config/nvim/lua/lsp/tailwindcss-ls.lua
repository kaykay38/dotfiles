local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

-- Check if tailwindls server already defined.
if not lspconfig.tailwindls then configs['tailwindls'] = {default_config = {}} end

lspconfig.tailwindls.setup {
    cmd = {
        "node", DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/index.js",
        "--stdio"
    },
    filetypes = O.tailwindls.filetypes,
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    handlers = {
        ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
            -- tailwindcss lang server waits for this repsonse before providing hover
            vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", {_id = params._id})
        end
    },
    on_attach = require'lsp'.common_on_attach
}

---------------------------------------------
-- lspconfig file
---------------------------------------------

-- local configs = require 'lspconfig/configs'
-- local util = require 'lspconfig/util'
-- local nvim_lsp = require('lspconfig')
-- 
-- local server_name = 'tailwindls'
-- 
-- configs[server_name] = {
--   default_config = {
--     cmd = {
--         "node", DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/index.js",
--         "--stdio"
--     },
--     filetypes = {'razor','html', 'cshtml', 'css', 'scss', 'svelt', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'};
--     root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git");
--     -- on_attach = require'lsp'.common_on_attach;
--   };
--   docs = {
--     description = [[ ]];
--     default_config = {
--         root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]];
--         -- on_attach = require'lsp'.common_on_attach
--     };
--   }
-- }
