return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
}
