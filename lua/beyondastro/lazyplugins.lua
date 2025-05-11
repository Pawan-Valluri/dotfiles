return {

    {	-- toggles linenums to releative in normal mode
        "sitiom/nvim-numbertoggle",
        lazy = false,
    },

    {	-- A keybinding helper plugin
        "folke/which-key.nvim",
        -- event = "VeryLazy",
        lazy = false,
        opts = {
            preset = 'helix',
        },
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        -- config = require("beyondastro.remap").whichkey_extras
    },

    -- {	-- Select themes interactively 
    -- 	"zaldih/themery.nvim",
    -- 	lazy = false,
    -- 	config = function()
    -- 		require("themery").setup({
    -- 			themes = {
    -- 				{
    -- 				name = "Night Owl",
    -- 					colorscheme = "night-owl",
    -- 					before = [[
    -- 						require("night-owl").setup()
    -- 						vim.cmd.colorscheme("night-owl")
    -- 					]]
    -- 				},
    -- 				"gruvbox-material",
    -- 				"everforest",
    -- 			},
    -- 			livePreview = true,
    -- 		})
    -- 	end
    -- },

    {	-- LSP Manager/Installer
        "mason-org/mason.nvim",
        version = "1.11.0",
        config = function()
            require("mason").setup()
        end
    },

    {	-- Config for Mason(LSP Manager)
        "mason-org/mason-lspconfig.nvim",
        version = "1.32.0",
        dependencies = { "neovim/nvim-lspconfig", "mason.nvim" },
        config = function()
            require("mason-lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(servername)
                    require("lspconfig")[servername].setup({})
                end,
            })
        end,
    },

    {	-- LSP config
        "neovim/nvim-lspconfig",
        -- dependencies = { "mason-lspconfig" }
    },

    {   -- Statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "night-owl",
                },
                sections = {
                    lualine_c = { '%f' },
                    lualine_x = {
                        function()
                            return os.date(" %d/%m/%Y")
                        end,
                        function()
                            return os.date("󱑀 %-I:%02M %p")
                        end,
                    },
                }
            })
        end
    },

    -- {	-- Statusline
    -- 	'echasnovski/mini.statusline',
    -- 	version = '*',
    -- 	config = function()
    -- 		require("mini.statusline").setup()
    -- 	end,
    -- },

    {   -- Commenting support
        'numToStr/Comment.nvim',
        config = function()
            require("Comment").setup({
                padding = true,
            })
        end,
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 80,
                open_mapping = [[<C-\>]],
                direction = "float",
                shade_terminals = true,
                shade_filetypes = {},
                persist_size = true,
                shading_factor = 2,
                insert_mappings = true,
                start_in_insert = true,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    }
                }
            })
        end,
    },

}
