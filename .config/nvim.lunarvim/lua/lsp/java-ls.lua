local util = require 'lspconfig/util'
-- In Vimscript
-- augroup lsp
--   au!
--   au FileType java lua require('jdtls').start_or_attach({cmd = {'java-linux-ls'}})
-- augroup end
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- require'lspconfig'.jdtls.setup {cmd = {'java-linux-ls'}}
if vim.fn.has("mac") == 1 then
    JAVA_LS_EXECUTABLE = 'java-mac-ls'
elseif vim.fn.has("unix") == 1 then
    JAVA_LS_EXECUTABLE = 'java-linux-ls'
else
    print("Unsupported system")
end
-- local bundles = {
--     vim.fn.glob(
--         "~/.config/nvim/.debuggers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
-- };

-- local on_attach = function(client, bufr)
--     require('jdtls').setup_dap()
--     require'lsp'.common_on_attach(client, bufr)
-- end


require'lspconfig'.jdtls.setup({
-- require('jdtls').start_or_attach({
    on_attach = on_attach,
    -- cmd = { JAVA_LS_EXECUTABLE, "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx2G", "-jar", "vim.NIL", "-configuration", "vim.NIL", "-data", "vim.NIL", "--add-modules=ALL-SYSTEM", "--add-opens java.base/java.util=ALL-UNNAMED", "--add-opens java.base/java.lang=ALL-UNNAMED" },
    root_dir = util.root_pattern('build.gradle', 'pom.xml',vim.fn.getcwd()),
    -- init_options = {bundles = bundles},
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                underline = true
            }
        )
    }

})

-- require('jdtls').start_or_attach({
--     on_attach = on_attach,
--     cmd = {JAVA_LS_EXECUTABLE},
--     root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml'}),
--     init_options = {bundles = bundles},
--     handlers = {
--         ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--                 virtual_text = false,
--                 underline = true
--             }
--         )
--     }
-- 
-- })
