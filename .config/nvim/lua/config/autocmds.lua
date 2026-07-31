-- Editor autocommands not tied to a specific plugin's setup.

-- ----- Tree-sitter highlighting / indentation (main branch is opt-in) -----
-- The main branch no longer enables these automatically. Start highlighting for
-- any buffer whose parser is installed, and wire up the (experimental) indentexpr
-- everywhere except C/C++ (which have better built-in indenting).
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
        if ev.match ~= "c" and ev.match ~= "cpp" then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

-- netrw is disabled, so make `nvim <directory>` open nvim-tree instead.
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("custom-open-directory", { clear = true }),
    callback = function()
        if vim.fn.argc() ~= 1 then return end

        local dir = vim.fn.argv(0)
        if vim.fn.isdirectory(dir) ~= 1 then return end

        local dir_buf = vim.api.nvim_get_current_buf()
        vim.cmd.cd(vim.fn.fnameescape(dir))
        require("lazy").load({ plugins = { "nvim-tree.lua" } })
        require("nvim-tree.api").tree.open({ path = dir, current_window = true })
        if vim.api.nvim_buf_is_valid(dir_buf) and dir_buf ~= vim.api.nvim_get_current_buf() then
            vim.api.nvim_buf_delete(dir_buf, { force = true })
        end
    end,
})

-- Terminal-buffer conveniences: escape to normal mode and window navigation.
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

-- format on save (LSP formatting; silently no-ops when no formatter is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        pcall(vim.lsp.buf.format, { bufnr = args.buf, timeout_ms = 800 })
    end,
})
