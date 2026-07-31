-- Xcode project support: build / run / test / debug, quickfix diagnostics, and
-- automatic buildServer.json management for sourcekit-lsp. Loads on Swift files or
-- on first use of a keymap/command. File-management (pbxproj editing) is left off —
-- this project uses Xcode 16 file-system-synchronized groups, so files are picked
-- up by folder and the xcodeproj gem isn't needed.
return {
    {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        ft = { "swift", "objc", "objcpp" },
        cmd = {
            "XcodebuildPicker",
            "XcodebuildSetup",
            "XcodebuildBuild",
            "XcodebuildBuildRun",
            "XcodebuildRun",
            "XcodebuildTest",
            "XcodebuildToggleLogs",
        },
        keys = {
            { "<leader>xx", "<cmd>XcodebuildPicker<cr>",             desc = "Xcode: all actions" },
            { "<leader>xX", "<cmd>XcodebuildSetup<cr>",              desc = "Xcode: setup wizard (project/scheme/device)" },
            { "<leader>xb", "<cmd>XcodebuildBuild<cr>",              desc = "Xcode: build" },
            { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>",          desc = "Xcode: build & run" },
            { "<leader>xR", "<cmd>XcodebuildRun<cr>",               desc = "Xcode: run (no build)" },
            { "<leader>xt", "<cmd>XcodebuildTest<cr>",              desc = "Xcode: run tests" },
            { "<leader>xT", "<cmd>XcodebuildTestClass<cr>",         desc = "Xcode: run tests in class" },
            { "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Xcode: toggle test explorer" },
            { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>",        desc = "Xcode: toggle logs" },
            { "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>",      desc = "Xcode: select scheme" },
            { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>",      desc = "Xcode: select device" },
            { "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Xcode: toggle code coverage" },
            { "<leader>xq", "<cmd>Telescope quickfix<cr>",          desc = "Xcode: quickfix list" },
        },
        config = function()
            -- Defaults are sensible; setup() also wires the quickfix/diagnostics
            -- reporters and offers to create buildServer.json on first project setup.
            require("xcodebuild").setup({})
        end,
    },
}
