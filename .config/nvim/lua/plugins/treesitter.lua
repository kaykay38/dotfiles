return {
    -- treesitter (main branch: manual highlight/indent, no lazy-loading)
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local nts = require("nvim-treesitter")

            -- Idempotent: installs any parsers that are missing. Run :TSUpdate to
            -- rebuild them after upgrading the plugin. Guarded so a stale checkout
            -- (e.g. before the branch is switched to `main`) cannot hard-error
            -- startup, since the old `master` module has no `install()`.
            if type(nts.install) == "function" then
                nts.install({
                    "lua", "vim", "vimdoc", "bash", "json", "yaml", "toml",
                    "markdown", "markdown_inline", "html", "css",
                    "javascript", "typescript", "tsx", "python", "swift", "c", "cpp",
                })
            end

            -- There is no dedicated `jsonc` parser; reuse `json` for jsonc files.
            vim.treesitter.language.register("json", "jsonc")

            -- Highlight code blocks that name no language using the source buffer's
            -- language, exposed as `b:ts_hover_lang` on LSP hover floats. Buffers
            -- without the variable set (ordinary Markdown) are left untouched, and
            -- fenced blocks that already name a language are skipped so they keep
            -- their own highlighting. See after/queries/markdown/injections.scm.
            local tsq = require("vim.treesitter.query")
            tsq.add_directive("inject-hover-lang!", function(match, _, source, pred, metadata)
                if type(source) ~= "number" then return end
                local lang = vim.b[source].ts_hover_lang
                if not lang or lang == "" then return end
                local node = match[pred[2]]
                if type(node) == "table" then node = node[1] end
                if not node then return end
                if node:type() == "fenced_code_block" then
                    for child in node:iter_children() do
                        if child:type() == "info_string" then return end
                    end
                end
                metadata["injection.language"] = lang
            end, { force = true })
        end,
    },
}
