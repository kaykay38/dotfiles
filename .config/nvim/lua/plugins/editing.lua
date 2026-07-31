local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

return {
    -- change/add/delete surrounding pairs
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    },

    -- comments: disable default gc* and drive <leader>/ ourselves
    {
        "numToStr/Comment.nvim",
        opts = { mappings = { basic = false, extra = false } },
        keys = {
            {
                "<leader>/",
                function() require("Comment.api").toggle.linewise.current() end,
                mode = "n",
                desc = "Toggle comment line",
            },
            {
                "<leader>/",
                function()
                    vim.api.nvim_feedkeys(esc, "nx", false)
                    require("Comment.api").toggle.linewise(vim.fn.visualmode())
                end,
                mode = "x",
                desc = "Toggle comment selection",
            },
        },
    },

    -- smarter buffer delete (loads on use via <leader>q in config/keymaps.lua)
    { "famiu/bufdelete.nvim", keys = { { "<leader>q", desc = "Close buffer (quit if last)" } } },
}
