local exepath = require("util").exepath

return {
    cmd = { exepath("omnisharp") },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.csproj", ".git" },
}
