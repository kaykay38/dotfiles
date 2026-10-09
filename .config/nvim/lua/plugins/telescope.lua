return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
            { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
            { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
            { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git status (all changed files)" },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
