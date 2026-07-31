local exepath = require("util").exepath

return {
    cmd = { exepath("vscode-html-language-server"), "--stdio" },
    filetypes = { "html", "templ" },
    root_markers = { { "package.json", ".htmlhintrc", ".prettierrc", ".prettierrc.json", "prettier.config.js" }, ".git" },
}
