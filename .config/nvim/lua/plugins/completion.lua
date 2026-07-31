return {
    -- completion stack: on first InsertEnter
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")

            local kind_icons = {
                Text          = "󰉿", -- nf-md-text
                Method        = "󰆧", -- nf-md-function_variant
                Function      = "󰊕", -- nf-md-function
                Constructor   = "", -- nf-oct-package

                Field         = "󰜢", -- nf-md-variable
                Variable      = "󰀫", -- nf-md-variable
                Class         = "󰠱", -- nf-md-class
                Interface     = "", -- nf-fa-sitemap

                Module        = "󰏗", -- nf-md-package
                Property      = "󰜢", -- nf-md-variable
                Unit          = "󰑭", -- nf-md-ruler
                Value         = "󰎠", -- nf-md-numeric

                Enum          = "󰕘", -- nf-md-format_list_bulleted
                Keyword       = "󰌋", -- nf-md-key
                Snippet       = "󰅌", -- nf-md-code_tags
                Color         = "󰏘", -- nf-md-palette

                File          = "󰈙", -- nf-md-file
                Reference     = "󰈇", -- nf-md-bookmark
                Folder        = "󰉋", -- nf-md-folder
                EnumMember    = "󰕘", -- same as Enum

                Constant      = "󰏿", -- nf-md-alpha_uppercase
                Struct        = "󰙅", -- nf-md-view_grid
                Event         = "󰉁", -- nf-md-lightning_bolt
                Operator      = "󰆕", -- nf-md-math_integral
                TypeParameter = "󰅲", -- nf-md-format_letter_case
            }

            -- Safe-load LuaSnip
            local has_luasnip, luasnip = pcall(require, "luasnip")

            cmp.setup({
                -- Give the windows rounded borders and a custom highlight group
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                    }),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" }, -- Order: Icon, Name, Source
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        -- Source labels (cleaner look)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snippet]",
                            buffer   = "[Buffer]",
                            path     = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        if has_luasnip then luasnip.lsp_expand(args.body) end
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_luasnip and luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif has_luasnip and luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })

            -- Completion menu colors
            vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = "#808080" })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#83a598", bold = true }) -- Blue for matches
            vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#83a598" })
            vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#b8bb26" })
            vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#fb4934" })
        end,
    },

    -- autopairs: when you start typing; integrates with cmp on confirm
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
