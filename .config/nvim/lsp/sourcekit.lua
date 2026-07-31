local exepath = require("util").exepath

return {
    cmd = { exepath("sourcekit-lsp") },
    filetypes = { "swift" },
    root_markers = {
        ".git",
        "buildServer.json",
        "compile_commands.json",
        ".sourcekit-lsp",
        "Package.swift",
    },
    get_language_id = function(_, ftype)
        return ftype
    end,
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
        textDocument = {
            diagnostic = {
                dynamicRegistration = true,
                relatedDocumentSupport = true,
            },
        },
    },
}
