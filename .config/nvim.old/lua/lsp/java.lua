--require'lspconfig'.jdtls.setup({
--    on_attach = on_attach,
--    root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml'}),
--    init_options = {bundles = bundles},
--    handlers = {
--        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--                virtual_text = false,
--                underline = true
--            }
--        )
--    }
--
--})

require('jdtls').start_or_attach({
    on_attach = on_attach,
    cmd = {java-lsp.sh},
    root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml'}),
    init_options = {bundles = bundles},
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                underline = true
            }
        )
    }

})
