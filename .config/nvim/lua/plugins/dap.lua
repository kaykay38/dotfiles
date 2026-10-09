-- Debug Adapter Protocol wiring.
--
-- nvim-dap is only a DAP *client*. Each language needs a separate adapter
-- process that speaks the protocol on the other end:
--   lldb-dap  -> C, C++, Swift   (ships with Xcode / LLVM)
--   debugpy   -> Python          (installed via :MasonInstall debugpy)

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

-- The interpreter that has debugpy importable. Mason keeps it in its own venv
-- so it never has to exist in the project's environment.
local function find_debugpy_python()
    local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    if vim.fn.executable(mason_python) == 1 then
        return mason_python
    end

    vim.notify("debugpy not found, run :MasonInstall debugpy", vim.log.levels.WARN)
    return nil
end

-- The interpreter the *debuggee* runs under. Distinct from the one above: the
-- debugger only needs debugpy, while your code needs its own dependencies.
-- venv-selector exports VIRTUAL_ENV when you pick an env with ,v.
local function find_debuggee_python()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
        return venv .. "/bin/python"
    end

    -- No venv (e.g. a scratch/LeetCode directory): fall back to the ambient
    -- interpreter, then to debugpy's own, which is always importable.
    if vim.fn.executable("python3") == 1 then
        return vim.fn.exepath("python3")
    end

    return find_debugpy_python()
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require("dap")

            -- ----- C / C++ / Swift -----
            -- Create the lldb-dap adapter: tells the plugin where to find the
            -- lldb-dap executable and how to start it.
            dap.adapters["lldb-dap"] = {
                type = "executable",
                name = "lldb-dap",
                command = find_lldb_dap(),
                options = {
                    -- Uncomment and set a path to enable lldb-dap logging (useful for bug reports).
                    -- env = { LLDBDAP_LOG = "/path/to/store/lldb-dap.log" },
                },
            }

            -- ----- Python -----
            local debugpy_python = find_debugpy_python()
            if debugpy_python then
                -- Registers the "python" adapter plus default launch configurations.
                require("dap-python").setup(debugpy_python)

                -- Resolve the debuggee interpreter lazily, at session start, so
                -- switching venvs with ,v takes effect without restarting nvim.
                for _, config in ipairs(dap.configurations.python or {}) do
                    config.pythonPath = find_debuggee_python
                    -- Step into your own code only, not the stdlib internals.
                    config.justMyCode = true
                    -- Run the program in an integrated terminal so input() works.
                    config.console = "integratedTerminal"
                end
            end

            -- ----- Breakpoint signs -----
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })

            -- ----- Keymaps (<leader>d = Debug) -----
            local map = function(lhs, rhs, desc)
                vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
            end

            map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
            map("<leader>dB", function()
                vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
                    if cond and cond ~= "" then
                        dap.set_breakpoint(cond)
                    end
                end)
            end, "Conditional breakpoint")
            map("<leader>dc", dap.continue, "Continue / start")
            map("<leader>do", dap.step_over, "Step over")
            map("<leader>di", dap.step_into, "Step into")
            map("<leader>dO", dap.step_out, "Step out")
            map("<leader>dr", dap.restart, "Restart")
            map("<leader>dt", dap.terminate, "Terminate")
            map("<leader>dl", dap.run_last, "Run last config")
            map("<leader>dR", dap.repl.toggle, "Toggle REPL")
            map("<leader>du", function() require("dapui").toggle() end, "Toggle UI")
            map("<leader>de", function() require("dapui").eval(nil, { enter = true }) end, "Eval expression")
            vim.keymap.set("v", "<leader>de", function() require("dapui").eval() end,
                { silent = true, desc = "Eval selection" })

            -- Python-only: debug the test function/class under the cursor.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserDapPython", { clear = true }),
                pattern = "python",
                callback = function(ev)
                    vim.keymap.set("n", "<leader>dn", function()
                        require("dap-python").test_method()
                    end, { buffer = ev.buf, silent = true, desc = "Debug nearest test" })
                end,
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            -- Open the UI when a session starts, close it when the program exits.
            dap.listeners.before.attach.dapui_config = dapui.open
            dap.listeners.before.launch.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close
        end,
    },
}
