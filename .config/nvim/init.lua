--=========================
-- Minimal, comfy Neovim (single file)
-- =========================

-- --------- options / UX ----------
vim.g.mapleader = " "
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitbelow = true
vim.opt.splitright = true -- optional but usually desired
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪>> "
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.clipboard = "unnamedplus" -- system clipboard: "+y / "+p just work

-- --- Persistent undo --------------------------------------------------------
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

local undo_dir = vim.fn.expand("$HOME/.local/share/nvim/undo")
vim.opt.undodir = undo_dir
-- create directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(vim.opt.undodir, "p")
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- transparent background toggle (like your LV setup)
-- local transparent = true
-- if transparent then
--     vim.api.nvim_create_autocmd("ColorScheme", {
--         callback = function()
--             for _, group in ipairs({ "Normal", "NormalNC", "SignColumn", "StatusLine", "StatusLineNC", "LineNr",
--                 "CursorLineNr", "EndOfBuffer" }) do
--                 vim.cmd(("hi %s ctermbg=none guibg=none"):format(group))
--             end
--         end,
--     })
-- end

-- quick toggle relativenumber (matches your mapping)
vim.keymap.set("n", "<leader>r", ":set relativenumber!<CR>", { silent = true, desc = "Toggle relativenumber" })

-- set Mason bin for lsp server paths
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- --------- lazy.nvim bootstrap ----------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- --------- PLUGINS ----------
require("lazy").setup({
        -- color scheme: load early so colors are ready
        {
            "sainnhe/gruvbox-material",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.gruvbox_material_background = "medium" -- or "hard", "soft"
                vim.g.gruvbox_material_foreground = "material"
                vim.g.gruvbox_material_enable_italic = 1
                vim.g.gruvbox_material_transparent_background = 1
                vim.cmd.colorscheme("gruvbox-material")
            end,
        },
        -- syntax highlighting for mdx
        {
            "davidmh/mdx.nvim"
        },

        -- statusline after UI settles
        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            opts = { options = { globalstatus = true } },
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

        -- telescope only when used
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            cmd = "Telescope",
            keys = {
                { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
                { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
                { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
                { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
            },
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        -- treesitter after first file load
        {
            "nvim-treesitter/nvim-treesitter",
            event = { "BufReadPost", "BufNewFile" },
            build = ":TSUpdate",
            opts = {
                ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "markdown", "python", "c", "cpp" },
                highlight = { enable = true },
                indent = { enable = true, disable = { "c", "cpp" } },
            },
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
        },

        -- mason only when you open the UI
        {
            "williamboman/mason.nvim",
            lazy = false,
            cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
            opts = { ui = { border = "rounded" } },
        },

        -- {
        --     "jose-elias-alvarez/null-ls.nvim",
        --     ft = { "python" },
        --     opts = function()
        --         return require "configs.null-ls"
        --     end,
        -- },

        -- AI/OpenCode
        {
            "cousine/opencode-context.nvim",
            opts = {
                tmux_target = nil,       -- Manual override: "session:window.pane"
                auto_detect_pane = true, -- Auto-detect opencode pane in current window
            },
            keys = {
                { "<leader>oa", "<cmd>OpencodeSend<cr>",       desc = "Send prompt to opencode" },
                { "<leader>oa", "<cmd>OpencodeSend<cr>",       mode = "v",                              desc = "Send prompt to opencode" },
                { "<leader>ot", "<cmd>OpencodeSwitchMode<cr>", desc = "Toggle opencode mode" },
                { "<leader>op", "<cmd>OpencodePrompt<cr>",     desc = "Open opencode persistent prompt" },
            },
            cmd = { "OpencodeSend", "OpencodeSwitchMode" },
        },

        -- smarter buffer delete (loads on use via your mapping)
        { "famiu/bufdelete.nvim",     keys = { { "<leader>q", desc = "Close buffer (quit if last)" } } },

        -- completion stack: on first InsertEnter
        { "hrsh7th/nvim-cmp",         event = "InsertEnter" },
        { "hrsh7th/cmp-nvim-lsp",     event = "InsertEnter" },
        { "hrsh7th/cmp-buffer",       event = "InsertEnter" },
        { "hrsh7th/cmp-path",         event = "InsertEnter" },
        { "L3MON4D3/LuaSnip",         event = "InsertEnter" },
        { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },

        -- autopairs: when you start typing
        { "windwp/nvim-autopairs",    event = "InsertEnter",                                           opts = {} },

        -- change surround
        {
            "kylechui/nvim-surround",
            version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        },
        -- comments: configure via opts and map <leader>/ yourself (no default gc*)
        {
            "numToStr/Comment.nvim",
            keys = { { "<leader>/", mode = { "n", "x" }, desc = "Toggle comment" } },
            opts = { mappings = { basic = false, extra = false } },
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
                require("which-key").setup({ delay = 150, notify = false })
            end,
        },

        -- environment manager
        {
            "linux-cultist/venv-selector.nvim",
            dependencies = {
                { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
            },
            ft = "python",                                                                                      -- Load when opening Python files
            keys = {
                { ",v", "<cmd>VenvSelect<cr>" },                                                                -- Open picker on keymap
            },
            opts = {                                                                                            -- this can be an empty lua table - just showing below for clarity.
                search = {},                                                                                    -- if you add your own searches, they go here.
                options = {},                                                                                   -- if you add plugin options, they go here.
                settings = {
                    options = {
                        notify_user_on_venv_change = true, -- Confirms it worked
                        type = "basedpyright",             -- Explicitly tell it you use pyright
                    },
                },
            },
        },

    },
    {
        ui = { border = "rounded" },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "matchit",
                },
            },
        },
    }
)

-- ----- Lualine -----
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- ----- KEYMAPS -----

-- splits
-- create quick split
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit | wincmd l<CR>", { desc = "Vertical split → focus" })
vim.keymap.set("n", "<leader>sh", "<cmd>split  | wincmd j<CR>", { desc = "Horizontal split → focus" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" }) -- if you prefer equalize on '=' instead
vim.keymap.set("n", "<leader>j", "<C-w>w", { desc = "Nav Split →" })
vim.keymap.set("n", "<leader>k", "<C-w>W", { desc = "Nav Split ←" })
-- 3) Smart resize on <leader>- / <leader>=
--    Shrinks/grows width if there are left/right neighbors,
--    otherwise adjusts height (for top/bottom layouts).
local function has_neighbor(dir) return vim.fn.winnr(dir) ~= vim.fn.winnr() end

local function smart_resize(delta)
    if has_neighbor("h") or has_neighbor("l") then
        -- left/right split layout → change width
        if delta > 0 then
            vim.cmd("vertical resize +" .. delta)
        else
            vim.cmd("vertical resize " .. delta) -- delta is negative already
        end
    else
        -- top/bottom split layout → change height
        if delta > 0 then
            vim.cmd("resize +" .. delta)
        else
            vim.cmd("resize " .. delta)
        end
    end
end

-- Tweak the step to taste (4–6 feels good on typical fonts)
local RESIZE_STEP = 5
vim.keymap.set("n", "<leader>-", function() smart_resize(-RESIZE_STEP) end, { desc = "Shrink split" })
vim.keymap.set("n", "<leader>=", function() smart_resize(RESIZE_STEP) end, { desc = "Grow split" })

-- ----- buffer navigation with <leader>h/j/k/l -----
vim.keymap.set("n", "<leader>h", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- nvim-tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File tree" })

-- <leader>q : close current buffer
vim.keymap.set("n", "<leader>q", function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    local real = 0
    for _, b in ipairs(bufs) do
        if vim.bo[b.bufnr].buftype == "" then -- “normal” file buffers only
            real = real + 1
        end
    end
    if real <= 1 then
        vim.cmd("quit") -- or :qa to quit all tabs
    else
        require("bufdelete").bufdelete(0, true)
    end
end, { desc = "Close buffer (quit if last)" })

-- Apply these specifically when a terminal opens
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], opts)
    end,
})

-- telescope
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Help tags" })

-- custom <leader>/ keymaps for line & block comments
local api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

-- Normal mode: toggle comment on current line
vim.keymap.set("n", "<leader>/", function()
    api.toggle.linewise.current()
end, { desc = "Toggle comment line" })

-- Visual mode: toggle comment on selection
vim.keymap.set("x", "<leader>/", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment selection" })

-- ----- LSP / cmp glue -----
local kind_icons = {
    Text          = "󰉿", -- nf-md-text
    Method        = "󰆧", -- nf-md-function_variant
    Function      = "󰊕", -- nf-md-function
    Constructor   = "", -- nf-oct-package

    Field         = "󰜢", -- nf-md-variable
    Variable      = "󰀫", -- nf-md-variable
    Class         = "󰠱", -- nf-md-class
    Interface     = "", -- nf-fa-sitemap

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

-- completion
local cmp = require("cmp")

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
    -- ... keep your existing mapping and sources ...
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

-- Modern diagnostic sign configuration
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
})

-- ----- LSP (Neovim 0.11+) -----

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

-- Helper: prefer Mason bins if present
local function exepath(cmd)
    local mason = vim.fn.stdpath("data") .. "/mason/bin/" .. cmd
    local mason_cmd = mason .. ".cmd"
    if vim.fn.executable(mason) == 1 then return mason end
    if vim.fn.executable(mason_cmd) == 1 then return mason_cmd end
    local p = vim.fn.exepath(cmd)
    return (p ~= "" and p) or cmd
end

-- Define server configs (Neovim 0.11+)
vim.lsp.config("lua_ls", {
    cmd = { exepath("lua-language-server") },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("basedpyright", {
    cmd = { exepath("basedpyright-langserver"), "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
            },
        },
    },
})

vim.lsp.config("clangd", {
    cmd = { exepath("clangd"), "--background-index", "--clang-tidy", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = capabilities,
})

vim.lsp.config("omnisharp", {
    cmd = { exepath("omnisharp") },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.csproj", ".git" },
    capabilities = capabilities,
})

vim.lsp.config("texlab", {
    cmd = { exepath("texlab") },
    filetypes = { "tex", "plaintex", "bib" },
    root_markers = { "texlabroot", ".latexmkrc", "Tectonic.toml", ".git" },
    capabilities = capabilities,
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
            },
            -- Put your platform forwardSearch here (zathura is Linux; macOS Skim uses displayline)
        },
    },
})

vim.lsp.config("harper_ls", {
    cmd = { exepath("harper-ls") },
    filetypes = { "markdown", "text", "gitcommit", "tex", "plaintex", "typst" },
    -- IMPORTANT: don't set a cwd root for this; it should be "single file" style.
    root_markers = {}, -- no project roots needed
    capabilities = capabilities,
    settings = {
        ["harper-ls"] = {
            linters = {
                SentenceCapitalization = true,
                SpellCheck = true,
                CorrectNumberSuffix = true,
                RepeatedWords = true,
                LongSentences = true,
                Spaces = true,
            },
            diagnosticSeverity = "hint",
            dialect = "American",
        },
    },
})

-- Enable servers (you can enable all, or selectively)
vim.lsp.enable({
    "lua_ls",
    "basedpyright",
    "clangd",
    "omnisharp",
    "texlab",
    "harper_ls",
})

---- quality of life ----
-- hover window appearance
-- Compact, wrapped, rounded LSP floats everywhere (hover, signature, etc.)
do
    local orig = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts               = opts or {}
        opts.border        = opts.border or "rounded"
        opts.max_width     = opts.max_width or 72
        opts.max_height    = opts.max_height or 20

        local bufnr, winnr = orig(contents, syntax, opts, ...)
        if winnr then
            vim.api.nvim_set_option_value("wrap", true, { win = winnr })
            vim.api.nvim_set_option_value("linebreak", true, { win = winnr })
            vim.api.nvim_set_option_value("breakindent", false, { win = winnr })
            vim.api.nvim_set_option_value("breakindentopt", "", { win = winnr })
            vim.api.nvim_set_option_value("showbreak", "", { win = winnr })
            vim.api.nvim_set_option_value("list", false, { win = winnr })
            vim.api.nvim_set_option_value("listchars", "", { win = winnr })
            vim.api.nvim_set_option_value("signcolumn", "no", { win = winnr })
        end
        return bufnr, winnr
    end
end

-- Customizing completion window colors
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = "#808080" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#83a598", bold = true }) -- Blue for matches
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#b8bb26" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#fb4934" })

-- (Optional) make diagnostic floats match
vim.diagnostic.config({ float = { border = "rounded", max_width = 72, max_height = 20 } })

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        pcall(vim.lsp.buf.format, { bufnr = args.buf, timeout_ms = 800 })
    end,
})

-- autopairs integrates with cmp
local ok_ap, npairs = pcall(require, "nvim-autopairs")
if ok_ap then
    npairs.setup({})
    -- add cmp integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
    wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>s", group = "Splits" },
        { "<leader>l", group = "LSP" },
        { "<leader>o", group = "OpenCode" },
    })
end
