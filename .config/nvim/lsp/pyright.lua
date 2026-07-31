local exepath = require("util").exepath

return {
    cmd = { exepath("pyright-langserver"), "--stdio" },
    filetypes = { "python" },
    root_markers = { { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "uv.lock" }, ".git" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
            },
        },
    },
}
