local exepath = require("util").exepath

return {
    cmd = { exepath("sourcekit-lsp") },
    filetypes = { "swift" },
    -- Nested list = priority tiers, not a flat "nearest ancestor wins" search.
    -- The build-config markers must outrank .git: in a monorepo the Xcode project
    -- sits well below the repo root, and if .git ever wins, sourcekit-lsp roots at
    -- the repo root, finds no buildServer.json, and silently drops to single-file
    -- mode (every project type reads as "cannot find in scope").
    root_markers = {
        { "buildServer.json", "compile_commands.json", ".sourcekit-lsp", "Package.swift" },
        ".git",
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
