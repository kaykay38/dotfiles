-- Global, plugin-independent keymaps. Plugin-specific maps live in their spec's
-- `keys` (telescope, nvim-tree, comment, bufdelete, claude-code) so they load lazily.

-- quick toggle relativenumber
vim.keymap.set("n", "<leader>r", ":set relativenumber!<CR>", { silent = true, desc = "Toggle relativenumber" })

-- ----- splits -----
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit | wincmd l<CR>", { desc = "Vertical split → focus" })
vim.keymap.set("n", "<leader>sh", "<cmd>split  | wincmd j<CR>", { desc = "Horizontal split → focus" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>j", "<C-w>w", { desc = "Nav Split →" })
vim.keymap.set("n", "<leader>k", "<C-w>W", { desc = "Nav Split ←" })

-- Smart resize on <leader>- / <leader>=
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

-- ----- buffer navigation -----
vim.keymap.set("n", "<leader>h", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- <leader>q : close current buffer (quit if it's the last real one)
vim.keymap.set("n", "<leader>q", function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    local real = 0
    for _, b in ipairs(bufs) do
        if vim.bo[b.bufnr].buftype == "" then -- "normal" file buffers only
            real = real + 1
        end
    end
    if real <= 1 then
        vim.cmd("quit") -- or :qa to quit all tabs
    else
        require("bufdelete").bufdelete(0, true)
    end
end, { desc = "Close buffer (quit if last)" })
