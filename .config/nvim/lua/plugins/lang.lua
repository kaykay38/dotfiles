return {
    -- syntax highlighting for mdx.
    --
    -- Must stay lazy: the plugin's after/queries/markdown/highlights.scm is marked
    -- `; extends`, so when it is on the runtimepath its `#lua-match?` predicates run
    -- against *every* Markdown buffer, not just mdx ones. That predicate reads node
    -- text, and on an edit that shrinks the buffer (`dd`) the highlighter evaluates it
    -- against a stale node whose range now runs past the end, so nvim_buf_get_text
    -- raises "Index out of bounds" from the decoration provider.
    {
        "davidmh/mdx.nvim",
        ft = "mdx",
        -- The plugin registers the mdx extension from its own after/plugin file, which
        -- never runs while it is lazy-loaded. Register it here instead: `init` runs at
        -- startup, so opening a .mdx file sets ft=mdx, which is what loads the plugin.
        init = function()
            vim.filetype.add({ extension = { mdx = "mdx" } })
        end,
    },

    -- python virtualenv manager
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
        },
        ft = "python",                       -- Load when opening Python files
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
        },
        opts = {                             -- this can be an empty lua table - just showing below for clarity.
            search = {},                     -- if you add your own searches, they go here.
            options = {},                    -- if you add plugin options, they go here.
            settings = {
                options = {
                    notify_user_on_venv_change = true, -- Confirms it worked
                    type = "pyright",                  -- Match the configured Python LSP
                },
            },
        },
    },
}
