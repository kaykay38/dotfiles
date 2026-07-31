return {
    -- statusline after UI settles
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                        refresh_time = 16, -- ~60fps
                        events = {
                            "WinEnter",
                            "BufEnter",
                            "BufWritePost",
                            "SessionLoadPost",
                            "FileChangedShellPost",
                            "VimResized",
                            "Filetype",
                            "CursorMoved",
                            "CursorMovedI",
                            "ModeChanged",
                        },
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },

    -- file tree only on demand
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File tree" },
        },
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { view = { width = 34 }, renderer = { group_empty = true } },
    },

    -- gitsigns: only when editing files
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    -- indent guides after file open
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = { scope = { enabled = false } },
    },

    -- which-key: load early so <leader> shows menu immediately
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            local wk = require("which-key")
            wk.setup({ delay = 150, notify = false })
            wk.add({
                { "<leader>f", group = "Find" },
                { "<leader>d", group = "Diagnostics" },
                { "<leader>s", group = "Splits" },
                { "<leader>l", group = "LSP" },
                { "<leader>o", group = "OpenCode" },
                { "<leader>x", group = "Xcode" },
            })
        end,
    },
}
