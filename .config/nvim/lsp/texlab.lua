local exepath = require("util").exepath

return {
    cmd = { exepath("texlab") },
    filetypes = { "tex", "plaintex", "bib" },
    root_markers = { "texlabroot", ".latexmkrc", "Tectonic.toml", ".git" },
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
            },
            -- Put your platform forwardSearch here (zathura is Linux; macOS Skim uses displayline)
        },
    },
}
