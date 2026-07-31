-- Locate the lldb-dap executable, preferring Xcode's toolchain on macOS.
local function find_lldb_dap()
    -- If you know the path to the lldb-dap binary change the line below.
    -- return "/path/to/lldb-dap"

    -- macOS: Try lldb-dap with xcrun.
    local xcrun_result = vim.system({ "xcrun", "--find", "lldb-dap" }, { text = true }):wait()
    if xcrun_result.code == 0 then
        local xcrun_dap_path = vim.fn.trim(xcrun_result.stdout)
        if vim.fn.executable(xcrun_dap_path) then
            return xcrun_dap_path
        end
    end

    -- Fallback to lldb-dap in the ${PATH} environment.
    if vim.fn.executable("lldb-dap") == 1 then
        return "lldb-dap"
    end

    vim.notify("lldb-dap not found, add it to your ${PATH}", vim.log.levels.WARN)
    return ""
end

return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Create the lldb-dap adapter: tells the plugin where to find the
            -- lldb-dap executable and how to start it.
            local dap = require("dap")
            dap.adapters["lldb-dap"] = {
                type = "executable",
                name = "lldb-dap",
                command = find_lldb_dap(),
                options = {
                    -- Uncomment and set a path to enable lldb-dap logging (useful for bug reports).
                    -- env = { LLDBDAP_LOG = "/path/to/store/lldb-dap.log" },
                },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
}
