-- Small shared helpers used across config/ and lsp/ modules.

local M = {}

-- Resolve an executable, preferring Mason-installed binaries when present so
-- server `cmd`s work whether the tool came from Mason or the system PATH.
function M.exepath(cmd)
    local mason = vim.fn.stdpath("data") .. "/mason/bin/" .. cmd
    local mason_cmd = mason .. ".cmd"
    if vim.fn.executable(mason) == 1 then return mason end
    if vim.fn.executable(mason_cmd) == 1 then return mason_cmd end
    local p = vim.fn.exepath(cmd)
    return (p ~= "" and p) or cmd
end

return M
