-- LSP wiring (Neovim 0.11+). Individual server definitions live in lsp/<name>.lua
-- (auto-discovered on the runtimepath); this file holds the shared pieces:
-- capabilities, on-attach keymaps, diagnostics, the enable list, and hover floats.

-- Merge nvim-cmp's completion capabilities into every server via the '*' default,
-- so file-based configs in lsp/ (including sourcekit) don't each repeat it.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- Prefer ONE place for keymaps: LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
        map("n", "go", vim.lsp.buf.type_definition, "Type Definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>ll", function()
            vim.diagnostic.open_float(nil, { focus = false, scope = "line", border = "rounded" })
        end, "Line diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    end,
})

-- Enable servers (each name resolves to lsp/<name>.lua on the runtimepath).
vim.lsp.enable({
    "lua_ls",
    "pyright",
    "sourcekit",
    "ts_ls",
    "tailwindcss",
    "cssls",
    "html",
    "jsonls",
    "clangd",
    "omnisharp",
    "texlab",
})

-- ----- Diagnostics -----
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN]  = signs.Warn,
            [vim.diagnostic.severity.HINT]  = signs.Hint,
            [vim.diagnostic.severity.INFO]  = signs.Info,
        },
    },
    float = { border = "rounded", max_width = 72, max_height = 20 },
})

---- quality of life ----
-- hover window appearance
-- Compact, wrapped, rounded LSP floats everywhere (hover, signature, etc.)
do
    local orig = vim.lsp.util.open_floating_preview

    -- SourceKit (and others) emit indented example code directly after a paragraph
    -- line with no blank line between. In CommonMark an indented code block cannot
    -- interrupt a paragraph, so those lines parse as plain paragraph text and never
    -- get highlighted. Insert a blank line before such runs so they become real
    -- indented_code_block nodes (fenced blocks are left untouched).
    local function separate_indented_code(lines)
        local out, in_fence = {}, false
        local function is_indented(l) return l:match("^    %S") ~= nil or l:match("^\t%S") ~= nil end
        for _, line in ipairs(lines) do
            if line:match("^%s*```") or line:match("^%s*~~~") then
                in_fence = not in_fence
                table.insert(out, line)
            else
                if not in_fence then
                    local prev = out[#out]
                    if is_indented(line) and prev and prev:match("%S") and not is_indented(prev) then
                        table.insert(out, "")
                    end
                end
                table.insert(out, line)
            end
        end
        return out
    end

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts            = opts or {}
        opts.border     = opts.border or "rounded"
        opts.max_width  = opts.max_width or 72
        opts.max_height = opts.max_height or 20

        -- Remember the language of the buffer the hover came from so unlabeled
        -- code blocks in the float can be highlighted as that language.
        local src_ft    = vim.bo.filetype

        if syntax == "markdown" and type(contents) == "table" then
            contents = separate_indented_code(contents)
        end

        -- With the Tree-sitter injection crash fixed (see the nvim-treesitter config),
        -- Markdown hovers render through Tree-sitter, highlighting both the prose and
        -- fenced code (Swift and others) rather than only explicitly-marked fences.
        local ok, bufnr, winnr = pcall(orig, contents, syntax, opts, ...)
        if not ok then error(bufnr) end

        -- Servers such as SourceKit emit example code as indented blocks or bare
        -- ``` fences with no info string. Tag the float with the source language so
        -- the Markdown injection query (after/queries/markdown/injections.scm) can
        -- highlight those blocks, then restart Tree-sitter to pick up the tag.
        if bufnr and syntax == "markdown" and src_ft ~= "" and src_ft ~= "markdown"
            and vim.treesitter.highlighter.active[bufnr] then
            vim.b[bufnr].ts_hover_lang = src_ft
            -- The float was already parsed (for its height) before the tag was set, so
            -- invalidate the cached tree — injections included — and re-parse so the
            -- code blocks and inline spans pick up the tagged language. Re-parsing only
            -- updates the tree; the float is already on screen with stale highlights, so
            -- force a redraw of the buffer to make the highlighter repaint from it.
            local ok_p, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
            if ok_p and parser then
                parser:invalidate(true)
                pcall(parser.parse, parser, true)
                pcall(vim.api.nvim__redraw, { buf = bufnr, valid = false })
            end
        end

        if winnr then
            vim.api.nvim_set_option_value("wrap", true, { win = winnr })
            vim.api.nvim_set_option_value("linebreak", true, { win = winnr })
            vim.api.nvim_set_option_value("breakindent", false, { win = winnr })
            vim.api.nvim_set_option_value("breakindentopt", "", { win = winnr })
            vim.api.nvim_set_option_value("showbreak", "", { win = winnr })
            vim.api.nvim_set_option_value("list", false, { win = winnr })
            vim.api.nvim_set_option_value("listchars", "", { win = winnr })
            vim.api.nvim_set_option_value("signcolumn", "no", { win = winnr })
            if syntax == "markdown" then
                vim.api.nvim_set_option_value("conceallevel", 2, { win = winnr })
                vim.api.nvim_set_option_value("concealcursor", "", { win = winnr })
            end
        end
        return bufnr, winnr
    end
end

-- Readable inline code in Markdown (hover floats and .md files alike). Tree-sitter
-- capture groups can't be scoped to a single window, so this is global and
-- re-applied whenever the colorscheme changes. Inline `code` becomes neutral text
-- on a faint background "chip" (à la VS Code) instead of gruvbox's hard-to-read
-- olive foreground. Only the inline-specific group is touched, so headings keep
-- their gruvbox colour + bold and code blocks keep their syntax colours.
local function style_markdown_hl()
    vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#d4be98", bg = "#3c3836" })
end
style_markdown_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = style_markdown_hl })
