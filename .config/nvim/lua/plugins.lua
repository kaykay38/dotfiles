local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

        -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
        use {"neovim/nvim-lspconfig", opt = true}
        use {"glepnir/lspsaga.nvim", opt = true}
        use {"kabouzeid/nvim-lspinstall", opt = true}
        -- use {"mfussenegger/nvim-jdtls", opt = true}
        use {"jlcrochet/vim-razor", opt = true}
		use {"OmniSharp/omnisharp-vim", opt = true}
		use {"diepm/vim-rest-console", opt = true}

        -- Tlescope
        -- use {"nvim-lua/popup.nvim", opt = true}
        -- use {"nvim-lua/plenary.nvim", opt = true}
        -- use {"nvim-telescope/telescope.nvim", opt = true}
		use {"junegunn/fzf.vim"}
	 	use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }

        -- Dbugging
        -- use {"mfussenegger/nvim-dap", opt = true}
        use {"puremourning/vimspector", opt = true}

        -- Atocomplete
        use {"hrsh7th/nvim-compe", opt = true}
        use {"hrsh7th/vim-vsnip", opt = true}
        -- use {"rafamadriz/friendly-snippets", opt = true}

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        -- use {"windwp/nvim-ts-autotag", opt = true}

        -- Explorer
        use "kyazdani42/nvim-tree.lua"
        -- TODO remove when open on dir is supported by nvimtree

        -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
        -- use {"liuchengxu/vim-which-key", opt = true}
        -- use {"ChristianChiarulli/dashboard-nvim", opt = true}
        use {"windwp/nvim-autopairs", opt = true}
        use {"terrortylor/nvim-comment", opt = true}
        -- use {"kevinhwang91/nvim-bqf", opt = true}

        -- Color
        --use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}
        use {"norcalli/nvim-colorizer.lua", opt = true}
        use {"dikiaap/minimalist", opt = true}
        use {"sainnhe/sonokai", opt = true}
        use {"sonph/onehalf", opt = true}

        -- Icons
        use {"kyazdani42/nvim-web-devicons", opt = true}

        -- Status Line and Bufferline
        use {"glepnir/galaxyline.nvim", opt = true}
        -- use {"romgrk/barbar.nvim", opt = true}

        require_plugin("nvim-lspconfig")
        require_plugin("lspsaga.nvim")
        require_plugin("nvim-lspinstall")
        require_plugin("omnisharp-vim")
        -- require_plugin("nvim-jdtls")
        -- require_plugin("popup.nvim")
        -- require_plugin("plenary.nvim")
        -- require_plugin("telescope.nvim")
        -- require_plugin("nvim-dap")
		require_plugin("vimspector")
        require_plugin("nvim-compe")
        require_plugin("vim-vsnip")
        require_plugin("vim-razor")
        require_plugin("nvim-treesitter")
        require_plugin("minimalist")
        require_plugin("sonokai")
        require_plugin("onehalf/vim")
        --require_plugin("nvim-ts-autotag")
        require_plugin("nvim-colorizer.lua")
        require_plugin("nvim-tree.lua")
        require_plugin("nvim-autopairs")
        require_plugin("nvim-comment")
        --require_plugin("nvim-bqf")
        --require_plugin("nvcode-color-schemes.vim")
        require_plugin("nvim-web-devicons")
        require_plugin("galaxyline.nvim")
		require_plugin("vim-rest-console")
        -- require_plugin("barbar.nvim")
    end
)
