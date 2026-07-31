local exepath = require("util").exepath

return {
    cmd = { exepath("vscode-css-language-server"), "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { { "package.json", ".stylelintrc", ".stylelintrc.json", ".stylelintrc.js", "stylelint.config.js" }, ".git" },
}
