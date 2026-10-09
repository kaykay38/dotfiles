-- All git tooling lives here: signs/hunks (gitsigns) and the diff/merge file
-- panel plus conflict resolution (diffview).
-- Everything hangs off the <leader>g group registered in ui.lua.

return {
    -- ---------------------------------------------------------------
    -- gitsigns: hunk signs in the gutter, plus hunk-level actions.
    -- Maps are buffer-local via on_attach so they only exist in files
    -- gitsigns actually tracks.
    -- ---------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- Hunk navigation. In a real diff split, ]c / [c are Vim's own
                -- native change motions, so hand them back rather than shadow them.
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.nav_hunk("next") end)
                    return "<Ignore>"
                end, "Next hunk")

                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.nav_hunk("prev") end)
                    return "<Ignore>"
                end, "Previous hunk")

                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>gd", gs.diffthis, "Diff this file")
                map("n", "<leader>ga", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            end,
        },
    },

    -- No git-conflict.nvim here on purpose (tried 2026-08-12, removed same day).
    -- It writes conflict extmarks to nvim_get_current_buf() instead of the
    -- buffer it actually parsed (git-conflict.lua:256, still unfixed on main),
    -- so it throws "Invalid 'line': out of range" whenever a conflicted file is
    -- visible in a non-focused window. Diffview's 4-pane merge tool guarantees
    -- that. The same mistake at :655 can bind co/ct to the wrong buffer, which
    -- is the dangerous half. It also still calls vim.diagnostic.disable(),
    -- removed in Neovim 0.11. Diffview below does the whole job and owns its
    -- own windows.

    -- ---------------------------------------------------------------
    -- diffview: the VSCode-style left-hand file panel.
    -- Opened during a merge it drops straight into the 3-way merge tool:
    --   file panel on the left, OURS / BASE / THEIRS across the top,
    --   working copy below.
    --   ]x / [x      next / prev conflict
    --   <leader>co   choose OURS        <leader>cO  ours, whole file
    --   <leader>ct   choose THEIRS      <leader>cT  theirs, whole file
    --   <leader>cb   choose BASE        <leader>cB  base, whole file
    --   <leader>ca   choose ALL         <leader>cA  all, whole file
    --   dx           delete the conflict region
    --   g?           show every mapping for the pane you are in
    -- ---------------------------------------------------------------
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
        keys = {
            { "<leader>gc", "<cmd>DiffviewOpen<CR>", desc = "Diffview: conflicts / working diff" },
            { "<leader>gC", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
            { "<leader>gf", "<cmd>DiffviewToggleFiles<CR>", desc = "Diffview: toggle file panel" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: history (this file)" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: history (repo)" },
        },
        opts = {
            enhanced_diff_hl = true,
            view = {
                merge_tool = {
                    layout = "diff3_mixed", -- OURS | BASE | THEIRS on top, result below
                    disable_diagnostics = true,
                },
            },
            file_panel = {
                listing_style = "tree",
                win_config = { width = 34 }, -- match nvim-tree's width
            },
        },
    },
}
