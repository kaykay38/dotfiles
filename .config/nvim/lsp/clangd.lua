local exepath = require("util").exepath

return {
    cmd = { exepath("clangd"), "--background-index", "--clang-tidy", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", ".git" },
}
