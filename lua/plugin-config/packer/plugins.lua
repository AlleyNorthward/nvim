local packer = require("packer")
packer.startup(
    function(use)
        -- Packer 可以管理自己本身
        use 'wbthomason/packer.nvim'
        -- 主题
        use("folke/tokyonight.nvim")
        use("mhartington/oceanic-next")
        use({"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}})
        use("shaunsingh/nord.nvim")
        use("ful1e5/onedark.nvim")
        use("EdenEast/nightfox.nvim")

        -- 树
        use({"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"})

        -- bufferline
        use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})

        -- lualine
--         use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
--         use("arkav/lualine-lsp-progress")

        -- treesitter 代码高亮
        use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
        -- lsp
        use("neovim/nvim-lspconfig")
        use("williamboman/mason.nvim")
        use("williamboman/mason-lspconfig.nvim")
        -- 补全
        use 'hrsh7th/nvim-cmp'                 -- 核心补全插件
        use 'hrsh7th/cmp-nvim-lsp'             -- LSP 补全源
        use 'hrsh7th/cmp-buffer'               -- buffer 补全
        use 'hrsh7th/cmp-path'                 -- 路径补全
        use 'L3MON4D3/LuaSnip'                 -- snippet 引擎
        use 'saadparwaiz1/cmp_luasnip'         -- snippet 补全源
    end
)

-- 每次保存 plugins.lua 自动安装插件

pcall(
    vim.cmd,
    [[
        augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
        augroup end
    ]]
)
