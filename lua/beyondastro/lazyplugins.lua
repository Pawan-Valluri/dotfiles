return {
    {
        'mg979/vim-visual-multi',
        branch = "master",
        lazy = false,
    },

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

    {
        "natecraddock/workspaces.nvim",
        config = function()
            require("workspaces").setup()
        end,
    },

    {	-- LSP Manager/Installer
        "mason-org/mason.nvim",
        version = "1.11.0",
        config = function()
            require("mason").setup()
        end
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Add your plugin folders here
                vim.fn.stdpath("config") .. "/lua/beyondastro",
            },
        },
        -- config = function()
        --     require("lazydev").setup()
        -- end,
    },

    {	-- Config for Mason(LSP Manager)
        "mason-org/mason-lspconfig.nvim",
        version = "1.32.0",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(servername)
                    require("lspconfig")[servername].setup({})
                end,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-lspconfig.nvim",
            "lazydev.nvim",
        },
        -- opts = {
        --     servers = {
        --         lua_ls = {
        --             settings = {
        --                 Lua = {
        --                     runtime = {
        --                         version = "LuaJIT",
        --                         path = vim.split(package.path, ";"),
        --                     },
        --                     diagnostics = {
        --                         globals = { "vim" },
        --                     },
        --                     workspace = {
        --                         checkThirdParty = false,
        --                         library = {
        --                             vim.env.VIMRUNTIME,
        --                             vim.fn.stdpath("config") .. "/lua",
        --                             vim.fn.stdpath("config") .. "/lua/beyondastro", -- Your plugin code
        --                         },
        --                     },
        --                     telemetry = {
        --                         enable = false,
        --                     },
        --                 },
        --             },
        --         },
        --     },
        -- },
    },

    {   -- Statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "night-owl",
                    -- Other separator symbols:
                    -- █
                    --   
                    --   
                    --   
                    --   
                    --   
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
