local exepath = require("util").exepath

return {
    cmd = { exepath("vscode-json-language-server"), "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { { "package.json", ".prettierrc", ".prettierrc.json", "prettier.config.js" }, ".git" },
}
